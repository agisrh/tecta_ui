import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium widget that displays read-only syntax highlighted code blocks (Dart / YAML).
class SyntaxHighlightedCode extends StatelessWidget {
  final String code;

  const SyntaxHighlightedCode({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> spans = [];
    final textVal = code;

    // Syntax highlighting parser
    final regExp = RegExp(
      r'//.*$|' // Comments [0]
      r'\b(import|class|extends|final|const|return|Widget|build|BuildContext|context|void|null|true|false|super|void\s+main|runApp)\b|' // Keywords [1]
      r'\b(TectaCard|TectaButton|TectaAlert|TectaTextField|TectaTheme|MaterialApp|MyApp|Text|Padding|Row|Column|EdgeInsets|TextStyle|Divider|Container|BoxDecoration|BorderRadius|Scaffold|Center|ThemeData|ThemeMode|ValueNotifier)\b|' // Widgets/Classes [2]
      r'([a-zA-Z0-9_-]+)(?=\:)|' // Parameters/Keys [3]
      r'(".*?"|' + "'.*?')" + r'|' // Strings [4]
      r'(\b\d+\b)', // Numbers [5]
      multiLine: true,
    );

    int lastMatchEnd = 0;

    regExp.allMatches(textVal).forEach((match) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: textVal.substring(lastMatchEnd, match.start)));
      }

      final fullMatch = match.group(0) ?? '';

      if (fullMatch.startsWith('//')) {
        // Comments
        spans.add(TextSpan(
          text: fullMatch,
          style: const TextStyle(color: Color(0xFF6A9955), fontStyle: FontStyle.italic),
        ));
      } else if (match.group(1) != null) {
        // Keywords
        spans.add(TextSpan(
          text: fullMatch,
          style: const TextStyle(color: Color(0xFFC586C0), fontWeight: FontWeight.bold),
        ));
      } else if (match.group(2) != null) {
        // Widgets/Classes
        spans.add(TextSpan(
          text: fullMatch,
          style: const TextStyle(color: Color(0xFF4EC9B0)),
        ));
      } else if (match.group(3) != null) {
        // Parameters/Keys
        spans.add(TextSpan(
          text: fullMatch,
          style: const TextStyle(color: Color(0xFF9CDCFE)),
        ));
      } else if (match.group(4) != null) {
        // Strings
        spans.add(TextSpan(
          text: fullMatch,
          style: const TextStyle(color: Color(0xFFCE9178)),
        ));
      } else if (match.group(5) != null) {
        // Numbers
        spans.add(TextSpan(
          text: fullMatch,
          style: const TextStyle(color: Color(0xFFB5CEA8)),
        ));
      } else {
        spans.add(TextSpan(text: fullMatch));
      }

      lastMatchEnd = match.end;
    });

    if (lastMatchEnd < textVal.length) {
      spans.add(TextSpan(text: textVal.substring(lastMatchEnd)));
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Color(0xFFD4D4D4),
            height: 1.5,
          ),
          children: spans,
        ),
      ),
    );
  }
}

class DocsTabScreen extends StatelessWidget {
  const DocsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Intro
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
            'Beautiful, minimalistic, and platform-agnostic UI library for Flutter. Built to give developers modular, highly customizable building blocks for enterprise dashboard experiences.',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : TectaColors.grey600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),

          // Section 1: Installation
          _buildSectionHeader(theme, 'Installation'),
          _buildDescription(isDark, 'Add Tecta UI dependency to your Flutter project via git url integration in pubspec.yaml:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(
            code: '''dependencies:
  tecta_ui:
    git:
      url: https://github.com/agisrh/tecta_ui.git''',
          ),
          const SizedBox(height: 40),

          // Section 2: Quick Start
          _buildSectionHeader(theme, 'Quick Start'),
          _buildDescription(isDark, 'Import Tecta UI and wrap your application structure with TectaTheme light/dark config:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(
            code: '''import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Configure default styling themes
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
}''',
          ),
          const SizedBox(height: 40),

          // Section 3: Theming Customization
          _buildSectionHeader(theme, 'Theming & Customization'),
          _buildDescription(isDark, 'Customize brand palettes, elevations, and typography tokens dynamically. You can create customized ThemeData using TectaTheme definitions:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(
            code: '''// Customizing theme tokens in main
final customTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: TectaColors.primaryMain,
  scaffoldBackgroundColor: TectaColors.grey900,
  cardColor: TectaColors.grey800,
  dividerColor: TectaColors.grey700,
);''',
          ),
          const SizedBox(height: 40),

          // Section 4: Responsive Layout
          _buildSectionHeader(theme, 'Responsive Principles'),
          _buildDescription(isDark, 'Tecta UI adapts to different screen sizes. Use MediaQuery to swap layouts or wrap viewports with platform adaptivity thresholds:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(
            code: '''// Example responsive check
final width = MediaQuery.of(context).size.width;
final isDesktop = width >= 1024;

return isDesktop 
  ? const ShowcaseDesktopView() 
  : const ShowcaseMobileView();''',
          ),
          const SizedBox(height: 40),

          // Section 5: AI-Ready Design Specifications
          _buildSectionHeader(theme, 'AI-Ready Design Specifications'),
          _buildDescription(isDark, 'Tecta UI includes a specialized specification document (TECTA_SPECS.md) at the project root directory. This contains clean widget constructor signatures, parameter details, and token styles optimized to help AI coding models and developers build UI layouts with perfect styling compliance:'),
          const SizedBox(height: 16),
          const SyntaxHighlightedCode(
            code: '''# Tecta Design System — AI-Ready Specifications
// File: /TECTA_SPECS.md

// Provides structured constructor signatures for AI:
const TectaButton({
  super.key,
  required String label,
  TectaButtonVariant variant = TectaButtonVariant.contained,
  TectaButtonSize size = TectaButtonSize.medium,
  bool loading = false,
  bool hasIcon = false,
  VoidCallback? onPressed,
});''',
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : TectaColors.grey900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: TectaColors.secondaryMain,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDescription(bool isDark, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.5,
        color: isDark ? Colors.white70 : TectaColors.grey600,
        height: 1.4,
      ),
    );
  }
}
