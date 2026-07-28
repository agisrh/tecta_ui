import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A custom TextEditingController to highlight code editor text dynamically.
class CodePlaygroundController extends TextEditingController {
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> children = [];
    final textVal = text;

    // A basic syntax highlighter using Regex
    final regExp = RegExp(
      r'(import|from|export|default|function|return)|' // Keywords [1]
      r'(<[A-Za-z0-9_]+|</[A-Za-z0-9_]+>)|' // Tags [2]
      r'([a-zA-Z0-9_-]+)(?=\=)|' // Attributes [3]
      r'(".*?"|' + "'.*?')" + r'|' // Strings [4]
      r'(\d+)', // Numbers [5]
    );

    int lastMatchEnd = 0;

    regExp.allMatches(textVal).forEach((match) {
      // Add unhighlighted text before match
      if (match.start > lastMatchEnd) {
        children.add(TextSpan(text: textVal.substring(lastMatchEnd, match.start)));
      }

      // Add highlighted text based on capturing group
      if (match.group(1) != null) {
        // Keywords
        children.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Color(0xFFC586C0), fontWeight: FontWeight.bold),
        ));
      } else if (match.group(2) != null) {
        // Tags
        children.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Color(0xFF569CD6)),
        ));
      } else if (match.group(3) != null) {
        // Attributes
        children.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Color(0xFF9CDCFE)),
        ));
      } else if (match.group(4) != null) {
        // Strings
        children.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Color(0xFFCE9178)),
        ));
      } else if (match.group(5) != null) {
        // Numbers
        children.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Color(0xFFB5CEA8)),
        ));
      } else {
        children.add(TextSpan(text: match.group(0)));
      }

      lastMatchEnd = match.end;
    });

    if (lastMatchEnd < textVal.length) {
      children.add(TextSpan(text: textVal.substring(lastMatchEnd)));
    }

    return TextSpan(style: style, children: children);
  }
}

class PlaygroundTabScreen extends StatefulWidget {
  const PlaygroundTabScreen({super.key});

  @override
  State<PlaygroundTabScreen> createState() => _PlaygroundTabScreenState();
}

class _PlaygroundTabScreenState extends State<PlaygroundTabScreen> {
  late CodePlaygroundController _codeController;
  Timer? _debounce;
  
  // Active template
  String _selectedTemplate = 'Card';
  double _previewScale = 1.0;
  bool _isMobilePreview = false;
  bool _isDarkPreview = true;

  // Parsed Visual states
  // Card Visual States
  String _cardTitle = 'Welcome';
  String _cardContent = 'Try out components in the code editor, open a ready-made template, and build your own theme in the theme editor — all in one place.';
  String _cardButtonLabel = 'Get started';
  bool _cardHasDivider = true;
  double _cardWidth = 400.0;
  double _cardPadding = 24.0;

  // Button Visual States
  String _btnLabel = 'Get started';
  TectaButtonVariant _btnVariant = TectaButtonVariant.contained;
  TectaButtonSize _btnSize = TectaButtonSize.medium;
  bool _btnLoading = false;
  bool _btnHasIcon = false;

  // Alert Visual States
  String _alertTitle = 'Notice';
  String _alertDesc = 'This is an example notification widget.';
  TectaAlertSeverity _alertSeverity = TectaAlertSeverity.info;
  TectaAlertVariant _alertVariant = TectaAlertVariant.soft;
  bool _alertIsClosable = true;

  // TextField Visual States
  String _tfLabel = 'Email Address';
  String _tfHint = 'Enter your email...';
  String _tfHelper = 'We will never share your email.';
  String _tfError = '';

  // Default Code Templates
  final Map<String, String> _templatesCode = {
    'Card': '''import {Card} from '@tecta_ui/core/Card';
import {Layout, LayoutHeader, LayoutContent, LayoutFooter} from '@tecta_ui/core/Layout';
import {Text, Heading} from '@tecta_ui/core/Text';
import {TectaButton} from '@tecta_ui/core/TectaButton';

export default function Example() {
  return (
    <Card width={400} padding={24}>
      <Layout>
        <LayoutHeader hasDivider={true}>
          <Heading level={2}>Welcome</Heading>
        </LayoutHeader>
        <LayoutContent>
          <Text type="body" color="secondary">
            Try out components in the code editor, open a ready-made template, and build your own theme in the theme editor — all in one place.
          </Text>
        </LayoutContent>
        <LayoutFooter>
          <TectaButton variant="contained">Get started</TectaButton>
        </LayoutFooter>
      </Layout>
    </Card>
  );
}''',
    'Button': '''import {TectaButton} from '@tecta_ui/core/TectaButton';

export default function ButtonExample() {
  return (
    <TectaButton 
      variant="contained" 
      size="medium"
      loading={false}
      hasIcon={false}
    >
      Get started
    </TectaButton>
  );
}''',
    'Alert': '''import {TectaAlert} from '@tecta_ui/core/TectaAlert';

export default function AlertExample() {
  return (
    <TectaAlert 
      severity="info"
      variant="soft" 
      title="Notice"
      isClosable={true}
    >
      This is an example notification widget.
    </TectaAlert>
  );
}''',
    'TextField': '''import {TectaTextField} from '@tecta_ui/core/TectaTextField';

export default function TextFieldExample() {
  return (
    <TectaTextField 
      label="Email Address" 
      placeholder="Enter your email..."
      helperText="We will never share your email."
      errorText=""
    />
  );
}''',
  };

  @override
  void initState() {
    super.initState();
    _codeController = CodePlaygroundController();
    _loadTemplate(_selectedTemplate);
    _codeController.addListener(_onCodeChanged);
  }

  @override
  void dispose() {
    _codeController.removeListener(_onCodeChanged);
    _codeController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _loadTemplate(String templateName) {
    _codeController.text = _templatesCode[templateName] ?? '';
    _parseCodeImmediate();
  }

  void _onCodeChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _parseCodeImmediate();
    });
  }

  void _parseCodeImmediate() {
    final code = _codeController.text;
    setState(() {
      if (_selectedTemplate == 'Card') {
        _parseCardTemplate(code);
      } else if (_selectedTemplate == 'Button') {
        _parseButtonTemplate(code);
      } else if (_selectedTemplate == 'Alert') {
        _parseAlertTemplate(code);
      } else if (_selectedTemplate == 'TextField') {
        _parseTextFieldTemplate(code);
      }
    });
  }

  // Regex Parsers per Component
  void _parseCardTemplate(String code) {
    // 1. Width
    final widthMatch = RegExp(r'width\s*=\s*\{(\d+)\}').firstMatch(code);
    if (widthMatch != null) {
      _cardWidth = double.tryParse(widthMatch.group(1) ?? '400') ?? 400.0;
    }

    // 2. Padding
    final paddingMatch = RegExp(r'padding\s*=\s*\{(\d+)\}').firstMatch(code);
    if (paddingMatch != null) {
      _cardPadding = double.tryParse(paddingMatch.group(1) ?? '24') ?? 24.0;
    }

    // 3. hasDivider
    final dividerMatch = RegExp(r'hasDivider\s*=\s*\{(true|false)\}').firstMatch(code);
    if (dividerMatch != null) {
      _cardHasDivider = dividerMatch.group(1) == 'true';
    }

    // 4. Heading / Title
    final headingMatch = RegExp(r'<Heading[^>]*>(.*?)</Heading>').firstMatch(code);
    if (headingMatch != null) {
      _cardTitle = headingMatch.group(1)?.trim() ?? 'Welcome';
    }

    // 5. Content text
    final textMatch = RegExp(r'<Text[^>]*>(.*?)</Text>', dotAll: true).firstMatch(code);
    if (textMatch != null) {
      _cardContent = textMatch.group(1)?.trim() ?? '';
    }

    // 6. Button label
    final btnMatch = RegExp(r'<TectaButton[^>]*>(.*?)</TectaButton>').firstMatch(code);
    if (btnMatch != null) {
      _cardButtonLabel = btnMatch.group(1)?.trim() ?? 'Get started';
    }
  }

  void _parseButtonTemplate(String code) {
    // 1. Variant
    final varMatch = RegExp(r'variant\s*=\s*"([^"]*)"').firstMatch(code);
    if (varMatch != null) {
      final val = varMatch.group(1);
      _btnVariant = TectaButtonVariant.values.firstWhere(
        (e) => e.toString().split('.').last == val,
        orElse: () => TectaButtonVariant.contained,
      );
    }

    // 2. Size
    final sizeMatch = RegExp(r'size\s*=\s*"([^"]*)"').firstMatch(code);
    if (sizeMatch != null) {
      final val = sizeMatch.group(1);
      _btnSize = TectaButtonSize.values.firstWhere(
        (e) => e.toString().split('.').last == val,
        orElse: () => TectaButtonSize.medium,
      );
    }

    // 3. Loading
    final loadingMatch = RegExp(r'loading\s*=\s*\{(true|false)\}').firstMatch(code);
    if (loadingMatch != null) {
      _btnLoading = loadingMatch.group(1) == 'true';
    }

    // 4. HasIcon
    final iconMatch = RegExp(r'hasIcon\s*=\s*\{(true|false)\}').firstMatch(code);
    if (iconMatch != null) {
      _btnHasIcon = iconMatch.group(1) == 'true';
    }

    // 5. Button label
    final labelMatch = RegExp(r'<TectaButton[^>]*>\s*(.*?)\s*</TectaButton>', dotAll: true).firstMatch(code);
    if (labelMatch != null) {
      _btnLabel = labelMatch.group(1)?.trim() ?? 'Get started';
    }
  }

  void _parseAlertTemplate(String code) {
    // 1. Severity
    final sevMatch = RegExp(r'severity\s*=\s*"([^"]*)"').firstMatch(code);
    if (sevMatch != null) {
      final val = sevMatch.group(1);
      _alertSeverity = TectaAlertSeverity.values.firstWhere(
        (e) => e.toString().split('.').last == val,
        orElse: () => TectaAlertSeverity.info,
      );
    }

    // 2. Variant
    final varMatch = RegExp(r'variant\s*=\s*"([^"]*)"').firstMatch(code);
    if (varMatch != null) {
      final val = varMatch.group(1);
      _alertVariant = TectaAlertVariant.values.firstWhere(
        (e) => e.toString().split('.').last == val,
        orElse: () => TectaAlertVariant.soft,
      );
    }

    // 3. Title
    final titleMatch = RegExp(r'title\s*=\s*"([^"]*)"').firstMatch(code);
    if (titleMatch != null) {
      _alertTitle = titleMatch.group(1) ?? 'Notice';
    }

    // 4. Closable
    final closableMatch = RegExp(r'isClosable\s*=\s*\{(true|false)\}').firstMatch(code);
    if (closableMatch != null) {
      _alertIsClosable = closableMatch.group(1) == 'true';
    }

    // 5. Description content
    final descMatch = RegExp(r'<TectaAlert[^>]*>\s*(.*?)\s*</TectaAlert>', dotAll: true).firstMatch(code);
    if (descMatch != null) {
      _alertDesc = descMatch.group(1)?.trim() ?? '';
    }
  }

  void _parseTextFieldTemplate(String code) {
    // 1. Label
    final labelMatch = RegExp(r'label\s*=\s*"([^"]*)"').firstMatch(code);
    if (labelMatch != null) {
      _tfLabel = labelMatch.group(1) ?? 'Email Address';
    }

    // 2. Hint/Placeholder
    final hintMatch = RegExp(r'placeholder\s*=\s*"([^"]*)"').firstMatch(code);
    if (hintMatch != null) {
      _tfHint = hintMatch.group(1) ?? '';
    }

    // 3. Helper
    final helperMatch = RegExp(r'helperText\s*=\s*"([^"]*)"').firstMatch(code);
    if (helperMatch != null) {
      _tfHelper = helperMatch.group(1) ?? '';
    }

    // 4. Error
    final errorMatch = RegExp(r'errorText\s*=\s*"([^"]*)"').firstMatch(code);
    if (errorMatch != null) {
      _tfError = errorMatch.group(1) ?? '';
    }
  }

  Widget _buildPreviewComponent() {
    if (_selectedTemplate == 'Card') {
      return Container(
        width: _cardWidth,
        child: TectaCard(
          header: Padding(
            padding: EdgeInsets.fromLTRB(_cardPadding, _cardPadding, _cardPadding, _cardHasDivider ? 16 : _cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _cardTitle,
                  style: TectaTypography.h5.copyWith(fontWeight: FontWeight.bold),
                ),
                if (_cardHasDivider) ...[
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                ],
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: _cardPadding, vertical: _cardPadding / 2),
          content: Text(
            _cardContent,
            style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(_cardPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TectaButton(
                    label: _cardButtonLabel,
                    variant: TectaButtonVariant.contained,
                    color: TectaColors.primaryMain,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (_selectedTemplate == 'Button') {
      return TectaButton(
        label: _btnLabel,
        variant: _btnVariant,
        size: _btnSize,
        loading: _btnLoading,
        color: TectaColors.primaryMain,
        icon: _btnHasIcon ? const Icon(SolarLinearIcons.letter) : null,
        onPressed: () {},
      );
    } else if (_selectedTemplate == 'Alert') {
      return TectaAlert(
        title: _alertTitle,
        message: _alertDesc,
        severity: _alertSeverity,
        variant: _alertVariant,
        onClose: _alertIsClosable ? () {} : null,
      );
    } else if (_selectedTemplate == 'TextField') {
      return SizedBox(
        width: 340,
        child: TectaTextField(
          label: _tfLabel,
          placeholder: _tfHint,
          helperText: _tfHelper,
          errorText: _tfError.isEmpty ? null : _tfError,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _codeController.text));
    TectaSnackbar.show(
      context,
      message: 'Code snippet copied to clipboard!',
      variant: TectaSnackbarVariant.success,
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: const Color(0xFF161616), // Dark IDE theme
      child: Row(
        children: [
          // Left Pane: Code Editor
          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Color(0xFF2D2D2D), width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Editor Header
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: const Color(0xFF1E1E1E),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Playground',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.auto_awesome_rounded, size: 16, color: Colors.white38),
                            const SizedBox(width: 16),
                            // Templates Dropdown Menu
                            _buildTopDropdown(
                              label: 'Templates',
                              items: ['Card', 'Button', 'Alert', 'TextField'],
                              value: _selectedTemplate,
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedTemplate = val;
                                    _loadTemplate(val);
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Editor Body with Line Numbers
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      color: const Color(0xFF1E1E1E),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Line numbers column
                          Container(
                            width: 44,
                            padding: const EdgeInsets.only(right: 8),
                            alignment: Alignment.topRight,
                            child: ListView.builder(
                              itemCount: 40,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 13,
                                    color: Color(0xFF5A5A5A),
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.right,
                                );
                              },
                            ),
                          ),
                          // Editable code area
                          Expanded(
                            child: TextField(
                              controller: _codeController,
                              maxLines: null,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 13,
                                color: Color(0xFFD4D4D4),
                                height: 1.5,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Pane: Preview Canvas
          Expanded(
            flex: 5,
            child: Container(
              color: const Color(0xFF161616),
              child: Column(
                children: [
                  // Canvas Header
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: const Color(0xFF1E1E1E),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Clear/Refresh Icon
                        IconButton(
                          icon: const Icon(Icons.refresh_rounded, size: 18, color: Colors.white70),
                          tooltip: 'Reset Code',
                          onPressed: () => _loadTemplate(_selectedTemplate),
                        ),
                        // Center/Right Controls
                        Row(
                          children: [
                            // Theme toggle (Sun/Moon)
                            IconButton(
                              icon: Icon(
                                _isDarkPreview ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                                size: 18,
                                color: Colors.white70,
                              ),
                              tooltip: 'Toggle Canvas Theme',
                              onPressed: () => setState(() => _isDarkPreview = !_isDarkPreview),
                            ),
                            const SizedBox(width: 8),
                            // Device Ratio selection
                            IconButton(
                              icon: Icon(
                                _isMobilePreview ? Icons.phone_android_rounded : Icons.computer_rounded,
                                size: 18,
                                color: Colors.white70,
                              ),
                              tooltip: 'Toggle Device Layout',
                              onPressed: () => setState(() => _isMobilePreview = !_isMobilePreview),
                            ),
                            const SizedBox(width: 8),
                            // Zoom / Scale Selector
                            DropdownButtonHideUnderline(
                              child: DropdownButton<double>(
                                value: _previewScale,
                                icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white38),
                                dropdownColor: const Color(0xFF222222),
                                style: const TextStyle(fontSize: 12, color: Colors.white70),
                                items: [0.5, 0.75, 1.0, 1.25, 1.5].map((scale) {
                                  return DropdownMenuItem(
                                    value: scale,
                                    child: Text('${(scale * 100).toInt()}%'),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _previewScale = val;
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Export Button
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF444444)),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              ),
                              onPressed: _copyToClipboard,
                              icon: const Icon(Icons.copy_all_rounded, size: 16),
                              label: const Text('Export', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Canvas preview body
                  Expanded(
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _isMobilePreview ? 360 : null,
                        height: _isMobilePreview ? 640 : null,
                        decoration: BoxDecoration(
                          color: _isDarkPreview ? const Color(0xFF222222) : const Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(_isMobilePreview ? 24.0 : 0.0),
                          border: _isMobilePreview ? Border.all(color: const Color(0xFF333333), width: 8) : null,
                          boxShadow: _isMobilePreview
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    blurRadius: 24,
                                    offset: const Offset(0, 12),
                                  ),
                                ]
                              : null,
                        ),
                        child: Transform.scale(
                          scale: _previewScale,
                          child: Center(
                            child: SingleChildScrollView(
                              child: _buildPreviewComponent(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopDropdown({
    required String label,
    required List<String> items,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF444444), width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white60, size: 18),
          dropdownColor: const Color(0xFF1E1E1E),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
