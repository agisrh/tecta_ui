import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

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
            'Learn how to integrate Tecta UI components into your Flutter applications.',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : TectaColors.grey600,
            ),
          ),
          const SizedBox(height: 32),
          _buildCard(
            theme,
            title: 'Installation',
            content: 'Add Tecta UI to your pubspec.yaml:',
            code: '''dependencies:
  tecta_ui:
    git:
      url: https://github.com/agisrh/tecta_ui.git''',
          ),
          const SizedBox(height: 24),
          _buildCard(
            theme,
            title: 'Quick Start',
            content: 'Import Tecta UI and wrap your app with TectaTheme:',
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
      theme: TectaTheme.lightTheme,
      home: Scaffold(
        body: Center(
          child: TectaButton(
            label: 'Hello Tecta',
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}''',
          ),
        ],
      ),
    );
  }

  Widget _buildCard(ThemeData theme, {required String title, required String content, required String code}) {
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : TectaColors.grey800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white70 : TectaColors.grey600,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
