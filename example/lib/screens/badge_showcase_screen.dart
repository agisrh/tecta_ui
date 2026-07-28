import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class BadgeShowcasePage extends StatelessWidget {
  const BadgeShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Widget mailIcon = Icon(SolarLinearIcons.letter, color: TectaColors.grey800, size: 24);

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Badge',
          style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: TectaColors.grey300.withValues(alpha: 0.5), height: 1.0),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          // ===========================================================================
          // STANDARD BADGES
          // ===========================================================================
          _buildSectionHeader('STANDARD'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 28,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TectaBadge(
                  color: TectaColors.grey300,
                  count: 4,
                  child: mailIcon,
                ),
                const TectaBadge(color: TectaColors.grey900, count: 4, child: mailIcon),
                const TectaBadge(color: TectaColors.primaryMain, count: 4, child: mailIcon),
                const TectaBadge(color: TectaColors.secondaryMain, count: 4, child: mailIcon),
                const TectaBadge(color: TectaColors.successMain, count: 4, child: mailIcon),
                const TectaBadge(color: TectaColors.infoMain, count: 4, child: mailIcon),
                const TectaBadge(color: TectaColors.warningMain, count: 4, child: mailIcon),
                const TectaBadge(color: TectaColors.errorMain, count: 4, child: mailIcon),
                TectaBadge(
                  color: TectaColors.infoMain,
                  count: 4,
                  child: Text('Typography', style: TectaTypography.subtitle2),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // DOT BADGES
          // ===========================================================================
          _buildSectionHeader('DOT'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 28,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.grey300,
                  child: mailIcon,
                ),
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.grey900,
                  child: mailIcon,
                ),
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.primaryMain,
                  child: mailIcon,
                ),
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.secondaryMain,
                  child: mailIcon,
                ),
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.successMain,
                  child: mailIcon,
                ),
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.infoMain,
                  child: mailIcon,
                ),
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.warningMain,
                  child: mailIcon,
                ),
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.errorMain,
                  child: mailIcon,
                ),
                TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.infoMain,
                  child: Text('Typography', style: TectaTypography.subtitle2),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // CUSTOM COLORS
          // ===========================================================================
          _buildSectionHeader('CUSTOM COLORS'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 28,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TectaBadge(color: Colors.purple, count: 5, child: mailIcon),
                const TectaBadge(color: Colors.teal, count: 25, child: mailIcon),
                const TectaBadge(color: Colors.deepOrange, count: 12, child: mailIcon),
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: Colors.pink,
                  child: mailIcon,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // STATUS BADGES
          // ===========================================================================
          _buildSectionHeader('STATUS'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 28,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TectaAvatar(
                  backgroundColor: TectaColors.grey300,
                  badge: TectaAvatarBadge.away(size: 14),
                ),
                TectaAvatar(
                  backgroundColor: TectaColors.grey300,
                  badge: TectaAvatarBadge.online(size: 14),
                ),
                TectaAvatar(
                  backgroundColor: TectaColors.grey300,
                  badge: TectaAvatarBadge.busy(size: 14),
                ),
                TectaAvatar(
                  backgroundColor: TectaColors.grey300,
                  badge: TectaAvatarBadge.offline(size: 14),
                ),
                const TectaAvatar(backgroundColor: TectaColors.grey300),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // MAXIMUM VALUES
          // ===========================================================================
          _buildSectionHeader('MAXIMUM VALUE'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 36,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TectaBadge(color: TectaColors.errorMain, count: 99, child: mailIcon),
                const TectaBadge(
                  color: TectaColors.errorMain,
                  count: 100,
                  max: 99,
                  child: mailIcon,
                ),
                const TectaBadge(
                  color: TectaColors.errorMain,
                  count: 1000,
                  max: 999,
                  child: mailIcon,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // BADGE OVERLAPS
          // ===========================================================================
          _buildSectionHeader('BADGE OVERLAP'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 36,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Rectangular target - Standard overlap (isOverlapCircle: false)
                TectaBadge(
                  color: TectaColors.infoMain,
                  variant: TectaBadgeVariant.dot,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: TectaColors.warningMain,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                // Rectangular target - Overlap Circle (isOverlapCircle: true) - shifted inward
                TectaBadge(
                  color: TectaColors.infoMain,
                  variant: TectaBadgeVariant.dot,
                  isOverlapCircle: true,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: TectaColors.warningMain,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                // Circular target - Overlap Circle (isOverlapCircle: true) - aligns cleanly on circle edge
                TectaBadge(
                  color: TectaColors.infoMain,
                  variant: TectaBadgeVariant.dot,
                  isOverlapCircle: true,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: TectaColors.warningMain,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Circular target - Standard overlap (isOverlapCircle: false) - hangs outside circle
                TectaBadge(
                  color: TectaColors.infoMain,
                  variant: TectaBadgeVariant.dot,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: TectaColors.warningMain,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        title,
        style: TectaTypography.overline.copyWith(
          color: TectaColors.grey500,
          fontSize: 12,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
      decoration: BoxDecoration(
        color: TectaColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: child,
    );
  }
}
