import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../widgets/docs_content_renderer.dart';

class DocSection {
  final String id;
  final String title;
  final List<Widget> Function(BuildContext, bool) contentBuilder;

  const DocSection({
    required this.id,
    required this.title,
    required this.contentBuilder,
  });
}

class DocsData {
  static Widget desc(bool isDark, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.5,
        color: isDark ? Colors.white70 : TectaColors.grey600,
        height: 1.6,
      ),
    );
  }

  static Widget noteCard(bool isDark, String label, Color accentColor, IconData icon, String text) {
    final effectiveAccent = isDark 
        ? (accentColor == TectaColors.primaryMain ? const Color(0xFF64B5F6) : accentColor)
        : accentColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: effectiveAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: effectiveAccent.withValues(alpha: 0.5), width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: effectiveAccent),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$label  ',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: effectiveAccent,
                        letterSpacing: 0.6),
                  ),
                  TextSpan(
                    text: text,
                    style: TextStyle(
                      fontSize: 13, 
                      color: isDark ? Colors.white70 : TectaColors.grey800, 
                      height: 1.5,
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

  static Widget componentGrid(bool isDark) {
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
            border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.08) : TectaColors.grey200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 20, color: TectaColors.primaryMain),
              const SizedBox(height: 8),
              Text(name,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : TectaColors.grey800)),
              const SizedBox(height: 2),
              Text(category,
                  style: TextStyle(
                      fontSize: 11, color: isDark ? Colors.white38 : TectaColors.grey400)),
            ],
          ),
        );
      }).toList(),
    );
  }

  static Widget featureList(bool isDark, List<(String, String)> items) {
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
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : TectaColors.grey800),
                      ),
                      TextSpan(
                        text: desc,
                        style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white60 : TectaColors.grey600,
                            height: 1.5),
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

  static List<DocSection> buildSections() {
    return [
      DocSection(
        id: 'installation',
        title: 'Installation',
        contentBuilder: (ctx, isDark) => [
          desc(isDark, 'Add Tecta UI to your Flutter project using flutter pub add:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(code: 'flutter pub add tecta_ui'),
          const SizedBox(height: 16),
          desc(isDark, 'Or add it directly to your pubspec.yaml file under dependencies:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(code: '''dependencies:
  tecta_ui: ^0.0.5'''),
          const SizedBox(height: 16),
          desc(isDark, 'Then run flutter pub get:'),
          const SizedBox(height: 12),
          const SyntaxHighlightedCode(code: 'flutter pub get'),
        ],
      ),
      DocSection(
        id: 'quick_start',
        title: 'Quick Start',
        contentBuilder: (ctx, isDark) => [
          desc(isDark,
              'Import the package and wrap your app with TectaTheme to enable light/dark theming:'),
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
      DocSection(
        id: 'theming',
        title: 'Theming & Colors',
        contentBuilder: (ctx, isDark) => [
          desc(isDark,
              'Tecta UI uses a semantic color system based on Material 3 tokens. Each role (primary, secondary, info, success, warning, error) has main, light, and dark variants:'),
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
          noteCard(
            isDark,
            'TIP',
            const Color(0xFF7C3AED),
            Icons.auto_awesome_rounded,
            'Always reference colors via TectaColors tokens — never use hardcoded hex values. This ensures full compatibility with future palette updates and light/dark theme switching.',
          ),
        ],
      ),
      DocSection(
        id: 'typography',
        title: 'Typography',
        contentBuilder: (ctx, isDark) => [
          desc(isDark,
              'Tecta UI ships a fluid type scale from display headings to captions. All styles bind automatically to the active ThemeData:'),
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
      DocSection(
        id: 'responsive',
        title: 'Responsive Layout',
        contentBuilder: (ctx, isDark) => [
          desc(isDark,
              'Tecta UI adapts to screen sizes. Use MediaQuery or LayoutBuilder to swap between desktop and mobile layouts:'),
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
          noteCard(
            isDark,
            'INFO',
            TectaColors.primaryMain,
            Icons.info_outline_rounded,
            'The recommended breakpoints are: mobile < 600px, tablet 600–1024px, desktop ≥ 1024px. These align with Material Design 3 adaptive layout guidelines.',
          ),
        ],
      ),
      DocSection(
        id: 'tecta_specs',
        title: 'TECTA_SPECS.md',
        contentBuilder: (ctx, isDark) => [
          desc(isDark,
              'The TECTA_SPECS.md file at the project root provides structured, AI-ready constructor signatures for all Tecta UI components. It enables AI coding assistants and developers to generate accurate UI layouts with correct prop usage:'),
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
          noteCard(
            isDark,
            'TIP',
            const Color(0xFF7C3AED),
            Icons.auto_awesome_rounded,
            'When using AI assistants (e.g. GitHub Copilot, Cursor, Antigravity), paste the relevant TECTA_SPECS.md section as context. This dramatically improves code generation accuracy for Tecta UI components.',
          ),
        ],
      ),
      DocSection(
        id: 'playground',
        title: 'Playground',
        contentBuilder: (ctx, isDark) => [
          desc(isDark,
              'The Playground tab provides an interactive code editor for experimenting with Tecta UI tokens in real time. It includes:'),
          const SizedBox(height: 16),
          featureList(isDark, [
            ('Live Preview', 'Instantly renders your changes as you type'),
            ('Syntax Highlighting', 'Full Dart syntax coloring in the editor'),
            ('API Reference', 'Collapsible property reference panel per component'),
            ('Docs Tab', 'Embedded documentation inside the playground editor'),
          ]),
        ],
      ),
    ];
  }
}
