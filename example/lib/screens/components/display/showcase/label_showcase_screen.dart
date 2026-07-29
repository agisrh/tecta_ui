import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class LabelShowcasePage extends StatelessWidget {
  const LabelShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Label',
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
            note: 'TectaLabel is a badge indicator available in four variants: Filled (high contrast), Outlined (clean borders), Soft (tinted opacity background), and Inverted.',
            code: '''// Filled
TectaLabel(variant: TectaLabelVariant.filled, label: 'Filled')

// Outlined
TectaLabel(variant: TectaLabelVariant.outlined, label: 'Outlined')

// Soft
TectaLabel(variant: TectaLabelVariant.soft, label: 'Soft')

// Inverted
TectaLabel(variant: TectaLabelVariant.inverted, label: 'Inverted')''',
            overview: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TectaLabel(text: 'Primary Filled', variant: TectaLabelVariant.filled, color: TectaColors.primaryMain),
                const TectaLabel(text: 'Primary Outlined', variant: TectaLabelVariant.outlined, color: TectaColors.primaryMain),
                const TectaLabel(text: 'Primary Soft', variant: TectaLabelVariant.soft, color: TectaColors.primaryMain),
                const TectaLabel(text: 'Primary Inverted', variant: TectaLabelVariant.inverted, color: TectaColors.primaryMain),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'With Icons',
            note: 'Prepend startIcon or append endIcon to highlight warnings, statuses, or category indicators.',
            code: '''TectaLabel(
  text: 'Success',
  startIcon: Icon(Icons.check),
)''',
            overview: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                TectaLabel(
                  text: 'Approved',
                  variant: TectaLabelVariant.filled,
                  color: TectaColors.successMain,
                  startIcon: Icon(Icons.check_circle_rounded),
                ),
                TectaLabel(
                  text: 'Alert Triggered',
                  variant: TectaLabelVariant.outlined,
                  color: TectaColors.errorMain,
                  startIcon: Icon(Icons.warning_amber_rounded),
                ),
                TectaLabel(
                  text: 'Share Info',
                  variant: TectaLabelVariant.soft,
                  color: TectaColors.infoMain,
                  endIcon: Icon(Icons.share_outlined),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Semantic Palette Tones',
            note: 'Avail all design system semantic colors: Primary, Secondary, Success, Info, Warning, Error.',
            code: '''TectaLabel(
  text: 'Warning',
  color: TectaColors.warningMain,
)''',
            overview: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                const TectaLabel(text: 'Info Status', variant: TectaLabelVariant.soft, color: TectaColors.infoMain),
                const TectaLabel(text: 'Success Completed', variant: TectaLabelVariant.soft, color: TectaColors.successMain),
                const TectaLabel(text: 'Warning Pending', variant: TectaLabelVariant.soft, color: TectaColors.warningMain),
                const TectaLabel(text: 'Critical Error', variant: TectaLabelVariant.soft, color: TectaColors.errorMain),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
