import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class ProgressShowcasePage extends StatelessWidget {
  const ProgressShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final googleColors = [
      TectaColors.infoMain,
      TectaColors.errorMain,
      TectaColors.warningMain,
      TectaColors.successMain,
    ];

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Progress',
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
            title: 'Google Multi-Color Spinners',
            note: 'Pass a list of colors to cycle track colors smoothly during continuous animation rotations.',
            code: '''TectaCircularProgress(
  size: 40,
  strokeWidth: 4,
  colors: [Colors.blue, Colors.red, Colors.yellow, Colors.green],
)''',
            overview: Row(
              children: [
                TectaCircularProgress(size: 40, strokeWidth: 4, colors: googleColors),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cycling linear progress bar track:',
                        style: TextStyle(fontSize: 12, color: isDark ? Colors.white54 : TectaColors.grey500),
                      ),
                      const SizedBox(height: 8),
                      TectaLinearProgress(height: 6, colors: googleColors),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Circular Indicators',
            note: 'Support custom sizes, stroke thickness, solid colors, and determinate values.',
            code: '''// Indeterminate
TectaCircularProgress(size: 40, color: Colors.blue)

// Determinate (75%)
TectaCircularProgress(value: 0.75, size: 40)''',
            overview: Wrap(
              spacing: 24,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TectaCircularProgress(size: 24, strokeWidth: 3),
                const TectaCircularProgress(
                  size: 40,
                  strokeWidth: 4,
                  color: TectaColors.infoMain,
                ),
                const TectaCircularProgress(
                  size: 56,
                  strokeWidth: 5,
                  color: TectaColors.successMain,
                ),
                TectaCircularProgress(
                  value: 0.75,
                  size: 44,
                  strokeWidth: 4.5,
                  color: TectaColors.warningMain,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Linear Indicators',
            note: 'Linear tracks with standard or custom heights and optional determinate values to track process completion.',
            code: '''// Indeterminate linear
TectaLinearProgress(height: 4)

// Determinate linear (40%)
TectaLinearProgress(value: 0.40, color: Colors.green)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TectaLinearProgress(),
                const SizedBox(height: 16),
                const TectaLinearProgress(color: TectaColors.infoMain, height: 4),
                const SizedBox(height: 24),
                Text(
                  'Upload progress: 85%',
                  style: TextStyle(fontSize: 12, color: isDark ? Colors.white54 : TectaColors.grey500),
                ),
                const SizedBox(height: 8),
                const TectaLinearProgress(value: 0.85, color: TectaColors.successMain, height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
