import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class BadgeShowcasePage extends StatelessWidget {
  const BadgeShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    const Widget mailIcon = Icon(SolarLinearIcons.letter, color: TectaColors.primaryMain, size: 24);

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Badge',
                style: TectaTypography.h4.copyWith(
                  color: isDark ? Colors.white : TectaColors.grey800,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: theme.dividerColor,
                  height: 1.0,
                ),
              ),
            ),
      body: ShowcasePageLayout(
        sections: [
          ShowcaseSection(
            title: 'Standard Count Badges',
            note: 'TectaBadge displays numerical notification counts overlaid on top of a target child widget.',
            code: '''TectaBadge(
  color: TectaColors.primaryMain,
  count: 4,
  child: Icon(Icons.mail),
)''',
            overview: Wrap(
              spacing: 28,
              runSpacing: 20,
              children: [
                const TectaBadge(color: TectaColors.primaryMain, count: 4, child: mailIcon),
                const TectaBadge(color: TectaColors.secondaryMain, count: 8, child: mailIcon),
                const TectaBadge(color: TectaColors.successMain, count: 12, child: mailIcon),
                const TectaBadge(color: TectaColors.errorMain, count: 99, child: mailIcon),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Dot Badges',
            note: 'Use TectaBadgeVariant.dot to display simplified indicator status dots without displaying numbers.',
            code: '''TectaBadge(
  variant: TectaBadgeVariant.dot,
  color: TectaColors.errorMain,
  child: Icon(Icons.mail),
)''',
            overview: Wrap(
              spacing: 28,
              runSpacing: 20,
              children: [
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.primaryMain,
                  child: mailIcon,
                ),
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.successMain,
                  child: mailIcon,
                ),
                const TectaBadge(
                  variant: TectaBadgeVariant.dot,
                  color: TectaColors.errorMain,
                  child: mailIcon,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Maximum Values',
            note: 'Add cap values to avoid text overflow inside standard badges. Exceeding values render as "+".',
            code: '''TectaBadge(
  count: 100,
  max: 99,
  child: Icon(Icons.mail),
)''',
            overview: Wrap(
              spacing: 36,
              runSpacing: 20,
              children: [
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
          ShowcaseSection(
            title: 'Badge Overlaps',
            note: 'Toggle isOverlapCircle parameter to position badges cleanly along circular child edges vs square corners.',
            code: '''TectaBadge(
  isOverlapCircle: true,
  variant: TectaBadgeVariant.dot,
  child: Container(shape: BoxShape.circle),
)''',
            overview: Wrap(
              spacing: 36,
              runSpacing: 20,
              children: [
                // Rectangular target - Standard overlap
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
                // Circular target - Overlap Circle
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
