import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class ChipShowcasePage extends StatefulWidget {
  const ChipShowcasePage({super.key});

  @override
  State<ChipShowcasePage> createState() => _ChipShowcasePageState();
}

class _ChipShowcasePageState extends State<ChipShowcasePage> {
  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Chip',
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
            title: 'Visual Variants',
            note: 'TectaChip is available in three visual variants: Filled (solid backdrop), Outlined (transparent with borders), and Soft (tinted opacity background).',
            code: '''// Filled
TectaChip(variant: TectaChipVariant.filled, label: 'Filled')

// Outlined
TectaChip(variant: TectaChipVariant.outlined, label: 'Outlined')

// Soft
TectaChip(variant: TectaChipVariant.soft, label: 'Soft')''',
            overview: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                TectaChip(
                  label: 'Filled Chip',
                  variant: TectaChipVariant.filled,
                  color: TectaColors.primaryMain,
                  onTap: () => _showFeedback('Filled tapped'),
                ),
                TectaChip(
                  label: 'Outlined Chip',
                  variant: TectaChipVariant.outlined,
                  color: TectaColors.primaryMain,
                  onTap: () => _showFeedback('Outlined tapped'),
                ),
                TectaChip(
                  label: 'Soft Tinted Chip',
                  variant: TectaChipVariant.soft,
                  color: TectaColors.primaryMain,
                  onTap: () => _showFeedback('Soft tapped'),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'With Avatars & Custom Icons',
            note: 'Easily attach leading elements such as text avatars, custom image circles, action icons, or change delete button symbols.',
            code: '''TectaChip(
  avatar: TectaAvatar(text: 'M'),
  label: 'User Profile',
)

TectaChip(
  icon: Icon(Icons.mood),
  label: 'Happy Status',
)''',
            overview: Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                TectaChip(
                  label: 'Marcus Carter',
                  variant: TectaChipVariant.soft,
                  color: TectaColors.successMain,
                  avatar: const TectaAvatar(text: 'M'),
                  onTap: () => _showFeedback('User profile clicked'),
                ),
                TectaChip(
                  label: 'Happy Mood',
                  variant: TectaChipVariant.outlined,
                  color: TectaColors.infoMain,
                  icon: const Icon(Icons.mood_rounded),
                  onTap: () => _showFeedback('Mood status clicked'),
                ),
                TectaChip(
                  label: 'Custom Delete Icon',
                  variant: TectaChipVariant.filled,
                  color: TectaColors.primaryMain,
                  icon: const Icon(Icons.cloud_done_rounded),
                  onDelete: () => _showFeedback('Delete tapped'),
                  deleteIcon: const Icon(Icons.close_rounded, size: 14),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Sizes & Dimensions',
            note: 'TectaChip supports small and medium sizing classes to fit into filter rows or compact metadata tags.',
            code: '''TectaChip(
  size: TectaChipSize.small,
  label: 'Small Density',
)''',
            overview: Row(
              children: [
                TectaChip(
                  label: 'Small Density',
                  variant: TectaChipVariant.soft,
                  size: TectaChipSize.small,
                  color: TectaColors.primaryMain,
                  avatar: const TectaAvatar(text: 'S'),
                  onDelete: () => _showFeedback('Small deleted'),
                ),
                const SizedBox(width: 24),
                TectaChip(
                  label: 'Medium Density',
                  variant: TectaChipVariant.soft,
                  size: TectaChipSize.medium,
                  color: TectaColors.primaryMain,
                  avatar: const TectaAvatar(text: 'M'),
                  onDelete: () => _showFeedback('Medium deleted'),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Disabled State',
            note: 'Deactivate chips by settings isEnabled to false to freeze click and delete actions.',
            code: '''TectaChip(
  isEnabled: false,
  label: 'Disabled option',
)''',
            overview: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                TectaChip(
                  label: 'Disabled Option',
                  variant: TectaChipVariant.filled,
                  isEnabled: false,
                  avatar: const TectaAvatar(text: 'D'),
                  onDelete: () {},
                ),
                TectaChip(
                  label: 'Disabled Outlined',
                  variant: TectaChipVariant.outlined,
                  isEnabled: false,
                  icon: const Icon(Icons.lock_rounded),
                  onDelete: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
