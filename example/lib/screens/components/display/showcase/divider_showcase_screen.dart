import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class DividerShowcasePage extends StatelessWidget {
  const DividerShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Divider',
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
            title: 'Horizontal Dividers',
            note: 'TectaDivider supports horizontal separating lines with three styles: solid (default), dashed, and dotted.',
            code: '''// Solid
TectaDivider()

// Dashed
TectaDivider(style: TectaDividerStyle.dashed)

// Dotted with custom color and thickness
TectaDivider(
  style: TectaDividerStyle.dotted,
  thickness: 3.0,
  color: Colors.blue,
)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Solid Divider (Default)', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : TectaColors.grey700)),
                const SizedBox(height: 8),
                const TectaDivider(),
                const SizedBox(height: 24),
                Text('Dashed Divider', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : TectaColors.grey700)),
                const SizedBox(height: 8),
                const TectaDivider(style: TectaDividerStyle.dashed),
                const SizedBox(height: 24),
                Text('Dotted Divider (Thick)', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : TectaColors.grey700)),
                const SizedBox(height: 8),
                const TectaDivider(style: TectaDividerStyle.dotted, thickness: 3.0),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Vertical Dividers',
            note: 'Switch orientation parameter to Axis.vertical to divide child rows inside Row/Flex layouts.',
            code: '''TectaDivider(
  orientation: Axis.vertical,
  style: TectaDividerStyle.dashed,
)''',
            overview: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Item A', style: TextStyle(color: isDark ? Colors.white70 : TectaColors.grey700)),
                  const TectaDivider(orientation: Axis.vertical),
                  Text('Item B', style: TextStyle(color: isDark ? Colors.white70 : TectaColors.grey700)),
                  const TectaDivider(
                    orientation: Axis.vertical,
                    style: TectaDividerStyle.dashed,
                    color: TectaColors.errorMain,
                  ),
                  Text('Item C', style: TextStyle(color: isDark ? Colors.white70 : TectaColors.grey700)),
                ],
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Dividers with Labels',
            note: 'Pass widget elements to label slot to embed text or icon markers, and set alignments to start, center (default), or end.',
            code: '''TectaDivider(
  label: Text('OR'),
)

TectaDivider(
  labelAlignment: TectaDividerLabelAlignment.start,
  label: Text('Start Label'),
)''',
            overview: Column(
              children: [
                TectaDivider(
                  label: Text(
                    'OR',
                    style: TectaTypography.caption.copyWith(
                      color: isDark ? Colors.white38 : TectaColors.grey500,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TectaDivider(
                  labelAlignment: TectaDividerLabelAlignment.start,
                  label: Text(
                    'Section Header',
                    style: TectaTypography.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white70 : TectaColors.grey800,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TectaDivider(
                  labelAlignment: TectaDividerLabelAlignment.end,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: TectaColors.infoMain,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Details',
                        style: TectaTypography.caption.copyWith(
                          color: TectaColors.infoMain,
                        ),
                      ),
                    ],
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
