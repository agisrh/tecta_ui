import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class TemplatesTabScreen extends StatelessWidget {
  const TemplatesTabScreen({super.key});

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
            'Blocks',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : TectaColors.grey900,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Ready-to-use UI blocks and page layouts built using Tecta UI components.',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : TectaColors.grey600,
            ),
          ),
          const SizedBox(height: 48),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: TectaEmptyState(
                title: 'Blocks & Layouts Coming Soon',
                description: 'We are crafting a collection of beautiful, ready-to-use page layouts, dashboards, SaaS landing pages, and auth suites built entirely with Tecta UI components.',
                iconData: Icons.widgets_outlined,
                action: TectaButton(
                  label: 'Stay Tuned',
                  color: TectaColors.primaryMain,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
