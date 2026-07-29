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
          const SizedBox(height: 32),
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 3 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.3,
            children: [
              _buildTemplateCard(
                context,
                title: 'Admin Dashboard',
                description: 'A complete admin panel layout with charts, sidebars, and user management tables.',
                badge: 'Coming Soon',
                icon: Icons.dashboard_outlined,
              ),
              _buildTemplateCard(
                context,
                title: 'SaaS Landing Page',
                description: 'Modern landing page with pricing grids, feature sections, and beautiful hero elements.',
                badge: 'Premium',
                icon: Icons.web_outlined,
              ),
              _buildTemplateCard(
                context,
                title: 'Authentication Suite',
                description: 'Clean sign in, sign up, and password reset flows with interactive field validation.',
                badge: 'Premium',
                icon: Icons.lock_outline,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(BuildContext context, {
    required String title,
    required String description,
    required String badge,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 28, color: TectaColors.primaryMain),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: badge == 'Premium' ? TectaColors.successLighter : TectaColors.warningLighter,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: badge == 'Premium' ? TectaColors.successDarker : TectaColors.warningDarker,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : TectaColors.grey800,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white70 : TectaColors.grey600,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
