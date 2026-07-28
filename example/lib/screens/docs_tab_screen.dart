import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Syntax-highlighted code block widget (dark theme, VS Code style).
class SyntaxHighlightedCode extends StatelessWidget {
  final String code;

  const SyntaxHighlightedCode({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> spans = [];
    final textVal = code;

    final regExp = RegExp(
      r'//.*$|' // Comments [0]
      r'\b(import|class|extends|final|const|return|Widget|build|BuildContext|context|void|null|true|false|super|void\s+main|runApp|required|this|static|late|async|await|enum|switch|case|default|if|else|for|in|new)\b|' // Keywords [1]
      r'\b(TectaCard|TectaButton|TectaAlert|TectaTextField|TectaTheme|TectaColors|TectaTypography|TectaSnackbar|MaterialApp|MyApp|Text|Padding|Row|Column|EdgeInsets|TextStyle|Divider|Container|BoxDecoration|BorderRadius|Scaffold|Center|ThemeData|ThemeMode|ValueNotifier|SizedBox|Icon|IconButton|AppBar|Navigator|MediaQuery|LayoutBuilder|StatelessWidget|StatefulWidget|State|Widget|BuildContext|Key|GlobalKey|Color|Colors|Icons)\b|' // Widgets/Classes [2]
      r'([a-zA-Z0-9_]+)(?=:)|' // Parameters/Keys [3]
      r'(\".*?\"|' + "'.*?')" + r'|' // Strings [4]
      r'(\b\d+(?:\.\d+)?\b)', // Numbers [5]
      multiLine: true,
    );

    int lastMatchEnd = 0;
    regExp.allMatches(textVal).forEach((match) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: textVal.substring(lastMatchEnd, match.start)));
      }
      final fullMatch = match.group(0) ?? '';
      if (fullMatch.startsWith('//')) {
        spans.add(TextSpan(text: fullMatch, style: const TextStyle(color: Color(0xFF6A9955), fontStyle: FontStyle.italic)));
      } else if (match.group(1) != null) {
        spans.add(TextSpan(text: fullMatch, style: const TextStyle(color: Color(0xFFC586C0), fontWeight: FontWeight.bold)));
      } else if (match.group(2) != null) {
        spans.add(TextSpan(text: fullMatch, style: const TextStyle(color: Color(0xFF4EC9B0))));
      } else if (match.group(3) != null) {
        spans.add(TextSpan(text: fullMatch, style: const TextStyle(color: Color(0xFF9CDCFE))));
      } else if (match.group(4) != null) {
        spans.add(TextSpan(text: fullMatch, style: const TextStyle(color: Color(0xFFCE9178))));
      } else if (match.group(5) != null) {
        spans.add(TextSpan(text: fullMatch, style: const TextStyle(color: Color(0xFFB5CEA8))));
      } else {
        spans.add(TextSpan(text: fullMatch));
      }
      lastMatchEnd = match.end;
    });

    if (lastMatchEnd < textVal.length) {
      spans.add(TextSpan(text: textVal.substring(lastMatchEnd)));
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 48, 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontFamily: 'monospace', fontSize: 13, color: Color(0xFFD4D4D4), height: 1.6),
              children: spans,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: _CopyButton(code: code),
        ),
      ],
    );
  }
}

class _CopyButton extends StatefulWidget {
  final String code;
  const _CopyButton({required this.code});

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _copied = false;

  void _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: IconButton(
        key: ValueKey(_copied),
        icon: Icon(_copied ? Icons.check_rounded : Icons.copy_rounded, size: 15),
        color: _copied ? const Color(0xFF4EC9B0) : const Color(0xFF9CDCFE),
        tooltip: _copied ? 'Copied!' : 'Copy',
        style: IconButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.06)),
        onPressed: _copy,
      ),
    );
  }
}

// ─── Doc Section Data Model ──────────────────────────────────────────────────

class _DocSection {
  final String id;
  final String title;
  final List<Widget> Function(BuildContext, bool) contentBuilder;

  const _DocSection({required this.id, required this.title, required this.contentBuilder});
}

// ─── DocsTabScreen ────────────────────────────────────────────────────────────

class DocsTabScreen extends StatefulWidget {
  const DocsTabScreen({super.key});

  @override
  State<DocsTabScreen> createState() => _DocsTabScreenState();
}

class _DocsTabScreenState extends State<DocsTabScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = [];
  int _activeIndex = 0;

  late final List<_DocSection> _sections;

  @override
  void initState() {
    super.initState();
    _sections = _buildSections();
    for (int i = 0; i < _sections.length; i++) {
      _sectionKeys.add(GlobalKey());
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    int activeIndex = 0;
    double closestDistance = double.infinity;
    for (int i = 0; i < _sectionKeys.length; i++) {
      final keyContext = _sectionKeys[i].currentContext;
      if (keyContext != null) {
        final renderBox = keyContext.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final distance = (position.dy - 120).abs();
          if (distance < closestDistance) {
            closestDistance = distance;
            activeIndex = i;
          }
        }
      }
    }
    if (activeIndex != _activeIndex) setState(() => _activeIndex = activeIndex);
  }

  void _scrollToSection(int index) {
    final keyContext = _sectionKeys[index].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(keyContext, duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
      setState(() => _activeIndex = index);
    }
  }

  List<_DocSection> _buildSections() {
    return [
      _DocSection(
        id: 'installation',
        title: 'Installation',
        contentBuilder: (ctx, isDark) => [
          _desc(isDark, 'Add Tecta UI to your Flutter project via git dependency in pubspec.yaml:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(code: '''dependencies:
  tecta_ui:
    git:
      url: https://github.com/agisrh/tecta_ui.git'''),
          const SizedBox(height: 16),
          _desc(isDark, 'Then run flutter pub get to install:'),
          const SizedBox(height: 12),
          const SyntaxHighlightedCode(code: 'flutter pub get'),
        ],
      ),
      _DocSection(
        id: 'quick_start',
        title: 'Quick Start',
        contentBuilder: (ctx, isDark) => [
          _desc(isDark, 'Import the package and wrap your app with TectaTheme to enable light/dark theming:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(code: '''import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TectaTheme.lightTheme,
      darkTheme: TectaTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Center(
          child: TectaButton(
            label: 'Hello Tecta',
            variant: TectaButtonVariant.contained,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}'''),
        ],
      ),
      _DocSection(
        id: 'theming',
        title: 'Theming & Colors',
        contentBuilder: (ctx, isDark) => [
          _desc(isDark, 'Tecta UI uses a semantic color system based on Material 3 tokens. Each role (primary, secondary, info, success, warning, error) has main, light, and dark variants:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(code: '''// Accessing color tokens
Color primary = TectaColors.primaryMain;
Color surface = TectaColors.grey100;

// Custom theme override
final customTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: TectaColors.primaryMain,
  scaffoldBackgroundColor: TectaColors.grey900,
  cardColor: TectaColors.grey800,
  dividerColor: TectaColors.grey700,
);'''),
          const SizedBox(height: 16),
          _noteCard(isDark,
            'TIP',
            const Color(0xFF7C3AED),
            Icons.auto_awesome_rounded,
            'Always reference colors via TectaColors tokens — never use hardcoded hex values. This ensures full compatibility with future palette updates and light/dark theme switching.',
          ),
        ],
      ),
      _DocSection(
        id: 'typography',
        title: 'Typography',
        contentBuilder: (ctx, isDark) => [
          _desc(isDark, 'Tecta UI ships a fluid type scale from display headings to captions. All styles bind automatically to the active ThemeData:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(code: '''// Heading styles
Text('Display', style: TectaTypography.h1),
Text('Title Large', style: TectaTypography.h2),
Text('Title Medium', style: TectaTypography.h3),

// Body and utility
Text('Body', style: TectaTypography.body1),
Text('Caption', style: TectaTypography.caption),
Text('OVERLINE', style: TectaTypography.overline),

// Override individual properties
Text('Custom', style: TectaTypography.h4.copyWith(
  color: TectaColors.primaryMain,
  letterSpacing: 0.5,
)),'''),
        ],
      ),
      _DocSection(
        id: 'responsive',
        title: 'Responsive Layout',
        contentBuilder: (ctx, isDark) => [
          _desc(isDark, 'Tecta UI adapts to screen sizes. Use MediaQuery or LayoutBuilder to swap between desktop and mobile layouts:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(code: '''// Using MediaQuery
final width = MediaQuery.of(context).size.width;
final isDesktop = width >= 1024;

return isDesktop
  ? const ShowcaseDesktopView()
  : const ShowcaseMobileView();

// Using LayoutBuilder
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth >= 800) {
      return const DesktopLayout();
    }
    return const MobileLayout();
  },
)'''),
          const SizedBox(height: 16),
          _noteCard(isDark,
            'INFO',
            TectaColors.primaryMain,
            Icons.info_outline_rounded,
            'The recommended breakpoints are: mobile < 600px, tablet 600–1024px, desktop ≥ 1024px. These align with Material Design 3 adaptive layout guidelines.',
          ),
        ],
      ),
      _DocSection(
        id: 'components',
        title: 'Components Overview',
        contentBuilder: (ctx, isDark) => [
          _desc(isDark, 'Tecta UI provides a comprehensive set of pre-built components organized into categories:'),
          const SizedBox(height: 20),
          _componentGrid(isDark),
          const SizedBox(height: 16),
          _desc(isDark, 'All components are accessible via the Components tab in the navigation bar. Each component supports Overview (live preview) and Code (syntax-highlighted snippet) tabs.'),
        ],
      ),
      _DocSection(
        id: 'tecta_specs',
        title: 'TECTA_SPECS.md',
        contentBuilder: (ctx, isDark) => [
          _desc(isDark, 'The TECTA_SPECS.md file at the project root provides structured, AI-ready constructor signatures for all Tecta UI components. It enables AI coding assistants and developers to generate accurate UI layouts with correct prop usage:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(code: '''# File: /TECTA_SPECS.md

// Example — TectaButton spec:
const TectaButton({
  super.key,
  required String label,
  TectaButtonVariant variant = TectaButtonVariant.contained,
  TectaButtonSize size = TectaButtonSize.medium,
  bool loading = false,
  bool hasIcon = false,
  VoidCallback? onPressed,
});

// Example — TectaAlert spec:
const TectaAlert({
  super.key,
  required String message,
  TectaAlertVariant variant = TectaAlertVariant.soft,
  TectaAlertSeverity severity = TectaAlertSeverity.info,
  VoidCallback? onClose,
});'''),
          const SizedBox(height: 16),
          _noteCard(isDark,
            'TIP',
            const Color(0xFF7C3AED),
            Icons.auto_awesome_rounded,
            'When using AI assistants (e.g. GitHub Copilot, Cursor, Antigravity), paste the relevant TECTA_SPECS.md section as context. This dramatically improves code generation accuracy for Tecta UI components.',
          ),
        ],
      ),
      _DocSection(
        id: 'playground',
        title: 'Playground',
        contentBuilder: (ctx, isDark) => [
          _desc(isDark, 'The Playground tab provides an interactive code editor for experimenting with Tecta UI tokens in real time. It includes:'),
          const SizedBox(height: 16),
          _featureList(isDark, [
            ('Live Preview', 'Instantly renders your changes as you type'),
            ('Syntax Highlighting', 'Full Dart syntax coloring in the editor'),
            ('API Reference', 'Collapsible property reference panel per component'),
            ('Docs Tab', 'Embedded documentation inside the playground editor'),
          ]),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;

        if (!isWide) {
          return _buildMobileLayout(isDark);
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Scrollable content
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPageHeader(isDark),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(_sections.length, (index) {
                          return Container(
                            key: _sectionKeys[index],
                            child: _buildSection(context, isDark, _sections[index]),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Right: Sticky sidebar
            Container(
              width: 220,
              margin: const EdgeInsets.only(top: 40.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: theme.dividerColor.withValues(alpha: 0.4)),
                ),
              ),
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ON THIS PAGE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white70 : TectaColors.grey800,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(_sections.length, (index) {
                    final isSelected = _activeIndex == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _scrollToSection(index),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 3,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: isSelected ? TectaColors.secondaryMain : Colors.transparent,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 150),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    color: isSelected
                                        ? TectaColors.secondaryMain
                                        : (isDark ? Colors.white54 : TectaColors.grey500),
                                  ),
                                  child: Text(
                                    _sections[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMobileLayout(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(isDark),
          ...List.generate(_sections.length, (index) {
            return _buildSection(context, isDark, _sections[index]);
          }),
        ],
      ),
    );
  }

  Widget _buildPageHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documentation',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : TectaColors.grey900,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Modular, highly customizable UI library for Flutter — built for enterprise dashboard experiences.',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : TectaColors.grey600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, bool isDark, _DocSection section) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : TectaColors.grey900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 3,
                decoration: BoxDecoration(
                  color: TectaColors.secondaryMain,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          // Content
          ...section.contentBuilder(context, isDark),
        ],
      ),
    );
  }

  // ─── Helper Builders ────────────────────────────────────────────────────────

  static Widget _desc(bool isDark, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.5,
        color: isDark ? Colors.white70 : TectaColors.grey600,
        height: 1.6,
      ),
    );
  }

  static Widget _noteCard(bool isDark, String label, Color accentColor, IconData icon, String text) {
    final bgColor = isDark
        ? accentColor.withValues(alpha: 0.08)
        : accentColor.withValues(alpha: 0.05);
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: accentColor, width: 3),
          top: BorderSide(color: accentColor.withValues(alpha: 0.15)),
          right: BorderSide(color: accentColor.withValues(alpha: 0.15)),
          bottom: BorderSide(color: accentColor.withValues(alpha: 0.15)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: accentColor),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$label  ',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: accentColor, letterSpacing: 0.6),
                  ),
                  TextSpan(
                    text: text,
                    style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : TectaColors.grey700, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _componentGrid(bool isDark) {
    const items = [
      (Icons.palette_outlined, 'Colors', 'Foundation'),
      (Icons.format_size_rounded, 'Typography', 'Foundation'),
      (Icons.emoji_symbols_outlined, 'Icons', 'Foundation'),
      (Icons.layers_outlined, 'Shadows', 'Foundation'),
      (Icons.info_outline_rounded, 'Alert', 'Feedback'),
      (Icons.check_box_outlined, 'Checkbox', 'Forms'),
      (Icons.radio_button_checked, 'Radio', 'Forms'),
      (Icons.toggle_on_outlined, 'Switch', 'Forms'),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items.map((item) {
        final (icon, name, category) = item;
        return Container(
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.04) : TectaColors.grey100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.08) : TectaColors.grey200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 20, color: TectaColors.primaryMain),
              const SizedBox(height: 8),
              Text(name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isDark ? Colors.white : TectaColors.grey800)),
              const SizedBox(height: 2),
              Text(category, style: TextStyle(fontSize: 11, color: isDark ? Colors.white38 : TectaColors.grey400)),
            ],
          ),
        );
      }).toList(),
    );
  }

  static Widget _featureList(bool isDark, List<(String, String)> items) {
    return Column(
      children: items.map((item) {
        final (title, desc) = item;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: TectaColors.secondaryMain,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$title — ',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isDark ? Colors.white : TectaColors.grey800),
                      ),
                      TextSpan(
                        text: desc,
                        style: TextStyle(fontSize: 14, color: isDark ? Colors.white60 : TectaColors.grey600, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
