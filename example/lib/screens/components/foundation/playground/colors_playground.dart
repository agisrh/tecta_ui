import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../playground_tab_screen.dart'; // To reuse CodePlaygroundController

class ColorsPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const ColorsPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<ColorsPlayground> createState() => _ColorsPlaygroundState();
}

class _ColorsPlaygroundState extends State<ColorsPlayground> {
  late CodePlaygroundController _codeController;
  Timer? _debounce;

  double _previewScale = 1.0;
  bool _isMobilePreview = false;
  bool _isDarkPreview = true;

  // Parsed Visual States
  Color _colorValue = TectaColors.primaryMain;
  String _colorName = 'primaryMain';
  double _colorWidth = 200.0;
  double _colorHeight = 200.0;
  double _colorRadius = 16.0;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: TectaColors.primaryMain,
      borderRadius: BorderRadius.circular(16),
    ),
  );
}''';

  @override
  void initState() {
    super.initState();
    _codeController = CodePlaygroundController();
    _codeController.text = _defaultCode;
    _parseCodeImmediate();
    _codeController.addListener(_onCodeChanged);
  }

  @override
  void dispose() {
    _codeController.removeListener(_onCodeChanged);
    _codeController.dispose();
    _debounce?.cancel();
    super.dispose();
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
      // 1. Width
      final widthMatch = RegExp(r'width:\s*(\d+)').firstMatch(code);
      if (widthMatch != null) {
        _colorWidth = double.tryParse(widthMatch.group(1) ?? '200') ?? 200.0;
      }

      // 2. Height
      final heightMatch = RegExp(r'height:\s*(\d+)').firstMatch(code);
      if (heightMatch != null) {
        _colorHeight = double.tryParse(heightMatch.group(1) ?? '200') ?? 200.0;
      }

      // 3. BorderRadius
      final radiusMatch = RegExp(r'BorderRadius\.circular\((\d+)\)').firstMatch(code);
      if (radiusMatch != null) {
        _colorRadius = double.tryParse(radiusMatch.group(1) ?? '16') ?? 16.0;
      }

      // 4. Color name & Value
      final colorMatch = RegExp(r'TectaColors\.([a-zA-Z0-9]+)').firstMatch(code);
      if (colorMatch != null) {
        final name = colorMatch.group(1) ?? 'primaryMain';
        _colorName = name;
        _colorValue = _getColorFromName(name);
      }
    });
  }

  Color _getColorFromName(String name) {
    switch (name) {
      case 'primaryLighter': return TectaColors.primaryLighter;
      case 'primaryLight': return TectaColors.primaryLight;
      case 'primaryMain': return TectaColors.primaryMain;
      case 'primaryDark': return TectaColors.primaryDark;
      case 'primaryDarker': return TectaColors.primaryDarker;
      case 'secondaryLighter': return TectaColors.secondaryLighter;
      case 'secondaryLight': return TectaColors.secondaryLight;
      case 'secondaryMain': return TectaColors.secondaryMain;
      case 'secondaryDark': return TectaColors.secondaryDark;
      case 'secondaryDarker': return TectaColors.secondaryDarker;
      case 'infoLighter': return TectaColors.infoLighter;
      case 'infoLight': return TectaColors.infoLight;
      case 'infoMain': return TectaColors.infoMain;
      case 'infoDark': return TectaColors.infoDark;
      case 'infoDarker': return TectaColors.infoDarker;
      case 'successLighter': return TectaColors.successLighter;
      case 'successLight': return TectaColors.successLight;
      case 'successMain': return TectaColors.successMain;
      case 'successDark': return TectaColors.successDark;
      case 'successDarker': return TectaColors.successDarker;
      case 'warningLighter': return TectaColors.warningLighter;
      case 'warningLight': return TectaColors.warningLight;
      case 'warningMain': return TectaColors.warningMain;
      case 'warningDark': return TectaColors.warningDark;
      case 'warningDarker': return TectaColors.warningDarker;
      case 'errorLighter': return TectaColors.errorLighter;
      case 'errorLight': return TectaColors.errorLight;
      case 'errorMain': return TectaColors.errorMain;
      case 'errorDark': return TectaColors.errorDark;
      case 'errorDarker': return TectaColors.errorDarker;
      default: return TectaColors.primaryMain;
    }
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

  Widget _buildTopDropdown({
    required String label,
    required List<String> items,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return PopupMenuButton<String>(
      tooltip: 'Select $label',
      offset: const Offset(0, 36),
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFF333333)),
      ),
      onSelected: onChanged,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF252526),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF3C3C3C)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white38,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white54,
              size: 16,
            ),
          ],
        ),
      ),
      itemBuilder: (context) {
        return items.map((item) {
          final isSelected = item == value;
          return PopupMenuItem<String>(
            value: item,
            height: 36,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_rounded,
                    color: TectaColors.primaryMain,
                    size: 14,
                  ),
              ],
            ),
          );
        }).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF161616),
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
                              items: ['Card', 'Button', 'Alert', 'TextField', 'Color'],
                              value: 'Color',
                              onChanged: (val) {
                                if (val != null) {
                                  widget.onTemplateChanged(val);
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
                        IconButton(
                          icon: const Icon(Icons.refresh_rounded, size: 18, color: Colors.white70),
                          tooltip: 'Reset Code',
                          onPressed: () {
                            setState(() {
                              _codeController.text = _defaultCode;
                              _parseCodeImmediate();
                            });
                          },
                        ),
                        Row(
                          children: [
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
                            _buildTopDropdown(
                              label: 'Zoom',
                              items: ['50%', '75%', '100%', '125%', '150%'],
                              value: '${(_previewScale * 100).toInt()}%',
                              onChanged: (val) {
                                if (val != null) {
                                  final numVal = double.tryParse(val.replaceAll('%', '')) ?? 100.0;
                                  setState(() {
                                    _previewScale = numVal / 100.0;
                                  });
                                }
                              },
                            ),
                            const SizedBox(width: 16),
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
                              child: Container(
                                width: _colorWidth,
                                height: _colorHeight,
                                decoration: BoxDecoration(
                                  color: _colorValue,
                                  borderRadius: BorderRadius.circular(_colorRadius),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.15),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'TectaColors.$_colorName',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 1)),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          '#${_colorValue.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 10,
                                            shadows: [
                                              Shadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 1)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
}
