import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class SwitchShowcasePage extends StatefulWidget {
  const SwitchShowcasePage({super.key});

  @override
  State<SwitchShowcasePage> createState() => _SwitchShowcasePageState();
}

class _SwitchShowcasePageState extends State<SwitchShowcasePage> {
  bool _basicActive = true;
  bool _basicInactive1 = false;
  bool _basicInactive2 = false;
  bool _basicDefaultActive = true;

  bool _sizeSmall = false;
  bool _sizeMedium = false;

  bool _placementTop = false;
  bool _placementStart = false;
  bool _placementBottom = false;
  bool _placementEnd = false;

  static final List<Color> _colors = [
    TectaColors.primaryMain,
    TectaColors.secondaryMain,
    TectaColors.infoMain,
    TectaColors.successMain,
    TectaColors.warningMain,
    TectaColors.errorMain,
  ];

  final Map<Color, bool> _colorsActive = {
    TectaColors.primaryMain: true,
    TectaColors.secondaryMain: true,
    TectaColors.infoMain: true,
    TectaColors.successMain: true,
    TectaColors.warningMain: true,
    TectaColors.errorMain: true,
  };

  String _getColorName(Color color) {
    if (color == TectaColors.primaryMain) return 'Primary';
    if (color == TectaColors.secondaryMain) return 'Secondary';
    if (color == TectaColors.infoMain) return 'Info';
    if (color == TectaColors.successMain) return 'Success';
    if (color == TectaColors.warningMain) return 'Warning';
    if (color == TectaColors.errorMain) return 'Error';
    return 'Custom';
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
                'Switch',
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
            title: 'Basic Switches',
            note: 'TectaSwitch represents a binary toggle selector with responsive animations. Supports active, inactive, and disabled variations.',
            code: '''// Basic toggles
TectaSwitch(
  value: _active,
  color: TectaColors.successMain,
  onChanged: (val) => setState(() => _active = val),
)

// Disabled
const TectaSwitch(
  value: true,
  onChanged: null,
)''',
            overview: Row(
              children: [
                TectaSwitch(
                  value: _basicActive,
                  color: TectaColors.successMain,
                  onChanged: (val) => setState(() => _basicActive = val),
                ),
                const SizedBox(width: 16),
                TectaSwitch(
                  value: _basicInactive1,
                  color: TectaColors.successMain,
                  onChanged: (val) => setState(() => _basicInactive1 = val),
                ),
                const SizedBox(width: 16),
                TectaSwitch(
                  value: _basicInactive2,
                  color: TectaColors.successMain,
                  onChanged: (val) => setState(() => _basicInactive2 = val),
                ),
                const SizedBox(width: 16),
                const TectaSwitch(
                  value: true,
                  color: TectaColors.successMain,
                  onChanged: null,
                ),
                const SizedBox(width: 16),
                TectaSwitch(
                  value: _basicDefaultActive,
                  color: TectaColors.grey800,
                  onChanged: (val) => setState(() => _basicDefaultActive = val),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Sizes',
            note: 'TectaSwitch comes in small and medium sizes to handle different spatial density requirements.',
            code: '''TectaSwitch(
  value: _small,
  size: TectaSwitchSize.small,
  label: 'Small',
  onChanged: (val) => setState(() => _small = val),
)''',
            overview: Row(
              children: [
                TectaSwitch(
                  value: _sizeSmall,
                  label: 'Small',
                  size: TectaSwitchSize.small,
                  onChanged: (val) => setState(() => _sizeSmall = val),
                ),
                const SizedBox(width: 24),
                TectaSwitch(
                  value: _sizeMedium,
                  label: 'Medium',
                  size: TectaSwitchSize.medium,
                  onChanged: (val) => setState(() => _sizeMedium = val),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Label Placement',
            note: 'Easily adjust the layout placement of labels in relation to the switch control (top, bottom, start, end).',
            code: '''TectaSwitch(
  value: _placement,
  label: 'Label',
  labelPlacement: TectaSwitchLabelPlacement.start,
  onChanged: (val) => {},
)''',
            overview: Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                TectaSwitch(
                  value: _placementTop,
                  label: 'Top',
                  labelPlacement: TectaSwitchLabelPlacement.top,
                  onChanged: (val) => setState(() => _placementTop = val),
                ),
                TectaSwitch(
                  value: _placementStart,
                  label: 'Start',
                  labelPlacement: TectaSwitchLabelPlacement.start,
                  onChanged: (val) => setState(() => _placementStart = val),
                ),
                TectaSwitch(
                  value: _placementBottom,
                  label: 'Bottom',
                  labelPlacement: TectaSwitchLabelPlacement.bottom,
                  onChanged: (val) => setState(() => _placementBottom = val),
                ),
                TectaSwitch(
                  value: _placementEnd,
                  label: 'End',
                  labelPlacement: TectaSwitchLabelPlacement.end,
                  onChanged: (val) => setState(() => _placementEnd = val),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Semantic Colors',
            note: 'Integrates natively with design system color tokens like Primary, Secondary, Info, Success, Warning, and Error.',
            code: '''TectaSwitch(
  value: true,
  color: TectaColors.warningMain,
  label: 'Warning Option',
  onChanged: (val) => {},
)''',
            overview: Wrap(
              spacing: 24,
              runSpacing: 16,
              children: _colors.map((col) {
                return TectaSwitch(
                  value: _colorsActive[col]!,
                  color: col,
                  label: _getColorName(col),
                  onChanged: (val) => setState(() => _colorsActive[col] = val),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
