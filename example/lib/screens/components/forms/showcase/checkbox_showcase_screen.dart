import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class CheckboxShowcasePage extends StatefulWidget {
  const CheckboxShowcasePage({super.key});

  @override
  State<CheckboxShowcasePage> createState() => _CheckboxShowcasePageState();
}

class _CheckboxShowcasePageState extends State<CheckboxShowcasePage> {
  // State variables for various checkboxes
  bool? _basicUnchecked = false;
  bool? _basicChecked = true;
  bool? _basicIndeterminate;

  bool? _sizeMedium = true;
  bool? _sizeSmall = true;

  bool? _placementTop = false;
  bool? _placementStart = false;
  bool? _placementBottom = false;
  bool? _placementEnd = false;

  bool? _customRound = true;
  bool? _customThick = true;
  bool? _customColor = true;
  bool? _customSizeSpacing = true;

  bool _buttonStyleSelected1 = false;
  bool _buttonStyleSelected2 = true;

  static final List<Color> _colors = [
    TectaColors.primaryMain,
    TectaColors.secondaryMain,
    TectaColors.infoMain,
    TectaColors.successMain,
    TectaColors.warningMain,
    TectaColors.errorMain,
  ];

  final Map<Color, bool?> _colorsChecked = {
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
                'Checkbox',
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
            title: 'Basic Checkboxes',
            note: 'TectaCheckbox supports checked, unchecked, and indeterminate (null) states, along with standard interactive and disabled variations.',
            code: '''// Basic states
TectaCheckbox(
  value: _basicUnchecked,
  onChanged: (val) => setState(() => _basicUnchecked = val),
)

TectaCheckbox(
  value: _basicChecked,
  onChanged: (val) => setState(() => _basicChecked = val),
)

TectaCheckbox(
  value: null, // Indeterminate
  onChanged: (val) => {},
)

// Disabled
const TectaCheckbox(
  value: true,
  onChanged: null,
)''',
            overview: Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                TectaCheckbox(
                  value: _basicUnchecked,
                  onChanged: (val) => setState(() => _basicUnchecked = val),
                ),
                TectaCheckbox(
                  value: _basicChecked,
                  onChanged: (val) => setState(() => _basicChecked = val),
                ),
                TectaCheckbox(
                  value: _basicIndeterminate,
                  onChanged: (val) => setState(() => _basicIndeterminate = val),
                ),
                const TectaCheckbox(
                  value: false,
                  onChanged: null,
                ),
                const TectaCheckbox(
                  value: true,
                  onChanged: null,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Sizes',
            note: 'TectaCheckbox is available in medium and small size options to fit into different density requirements.',
            code: '''TectaCheckbox(
  value: _sizeMedium,
  size: TectaCheckboxSize.medium,
  label: 'Medium Size',
  onChanged: (val) => setState(() => _sizeMedium = val),
)

TectaCheckbox(
  value: _sizeSmall,
  size: TectaCheckboxSize.small,
  label: 'Small Size',
  onChanged: (val) => setState(() => _sizeSmall = val),
)''',
            overview: Row(
              children: [
                TectaCheckbox(
                  value: _sizeMedium,
                  onChanged: (val) => setState(() => _sizeMedium = val),
                  size: TectaCheckboxSize.medium,
                  label: 'Medium',
                ),
                const SizedBox(width: 32),
                TectaCheckbox(
                  value: _sizeSmall,
                  onChanged: (val) => setState(() => _sizeSmall = val),
                  size: TectaCheckboxSize.small,
                  label: 'Small',
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Button Style Checkbox',
            note: 'A button-like checkbox target. Perfect for multi-selection layout cards, configuration panels, or modern filter flows.',
            code: '''// Layout Checkbox like an interactive button
InkWell(
  onTap: () => setState(() => _buttonStyle = !_buttonStyle),
  borderRadius: BorderRadius.circular(10.0),
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: _buttonStyle 
          ? TectaColors.primaryMain.withValues(alpha: 0.08) 
          : Colors.transparent,
      border: Border.all(
        color: _buttonStyle ? TectaColors.primaryMain : TectaColors.grey300,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _buttonStyle ? Icons.check_box_outlined : Icons.check_box_outline_blank,
          color: _buttonStyle ? TectaColors.primaryMain : TectaColors.grey500,
        ),
        const SizedBox(width: 10.0),
        Text('Option'),
      ],
    ),
  ),
)''',
            overview: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                InkWell(
                  onTap: () => setState(() => _buttonStyleSelected1 = !_buttonStyleSelected1),
                  borderRadius: BorderRadius.circular(10.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                    decoration: BoxDecoration(
                      color: _buttonStyleSelected1
                          ? TectaColors.primaryMain.withValues(alpha: isDark ? 0.12 : 0.08)
                          : (isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white),
                      border: Border.all(
                        color: _buttonStyleSelected1
                            ? TectaColors.primaryMain
                            : (isDark ? Colors.white.withValues(alpha: 0.1) : TectaColors.grey300),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _buttonStyleSelected1 ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                          color: _buttonStyleSelected1 ? TectaColors.primaryMain : TectaColors.grey500,
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Standard Option',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: _buttonStyleSelected1 ? FontWeight.w700 : FontWeight.w500,
                            color: _buttonStyleSelected1
                                ? TectaColors.primaryMain
                                : (isDark ? Colors.white70 : TectaColors.grey800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => setState(() => _buttonStyleSelected2 = !_buttonStyleSelected2),
                  borderRadius: BorderRadius.circular(10.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                    decoration: BoxDecoration(
                      color: _buttonStyleSelected2
                          ? TectaColors.primaryMain.withValues(alpha: isDark ? 0.12 : 0.08)
                          : (isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white),
                      border: Border.all(
                        color: _buttonStyleSelected2
                            ? TectaColors.primaryMain
                            : (isDark ? Colors.white.withValues(alpha: 0.1) : TectaColors.grey300),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _buttonStyleSelected2 ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                          color: _buttonStyleSelected2 ? TectaColors.primaryMain : TectaColors.grey500,
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Selected Option',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: _buttonStyleSelected2 ? FontWeight.w700 : FontWeight.w500,
                            color: _buttonStyleSelected2
                                ? TectaColors.primaryMain
                                : (isDark ? Colors.white70 : TectaColors.grey800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Label Placement',
            note: 'Configure where the label text is placed relative to the checkbox (top, start, bottom, end).',
            code: '''TectaCheckbox(
  value: _placementStart,
  label: 'Start Placement',
  labelPlacement: TectaCheckboxLabelPlacement.start,
  onChanged: (val) => {},
)''',
            overview: Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                TectaCheckbox(
                  value: _placementTop,
                  onChanged: (val) => setState(() => _placementTop = val),
                  label: 'Top',
                  labelPlacement: TectaCheckboxLabelPlacement.top,
                ),
                TectaCheckbox(
                  value: _placementStart,
                  onChanged: (val) => setState(() => _placementStart = val),
                  label: 'Start',
                  labelPlacement: TectaCheckboxLabelPlacement.start,
                ),
                TectaCheckbox(
                  value: _placementBottom,
                  onChanged: (val) => setState(() => _placementBottom = val),
                  label: 'Bottom',
                  labelPlacement: TectaCheckboxLabelPlacement.bottom,
                ),
                TectaCheckbox(
                  value: _placementEnd,
                  onChanged: (val) => setState(() => _placementEnd = val),
                  label: 'End',
                  labelPlacement: TectaCheckboxLabelPlacement.end,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Custom Styles',
            note: 'Override border radius, border thickness, colors, and specific dimensions freely to align with custom branding guidelines.',
            code: '''TectaCheckbox(
  value: _customRound,
  borderRadiusOverride: 50.0, // Circle
  label: 'Rounded (Circle)',
  onChanged: (val) => {},
)

TectaCheckbox(
  value: _customColor,
  activeBgColorOverride: Colors.amber,
  activeBorderColorOverride: Colors.orange,
  checkMarkColorOverride: Colors.black,
  label: 'Amber Theme',
  onChanged: (val) => {},
)''',
            overview: Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                TectaCheckbox(
                  value: _customRound,
                  onChanged: (val) => setState(() => _customRound = val),
                  borderRadiusOverride: 50.0,
                  label: 'Rounded',
                ),
                TectaCheckbox(
                  value: _customThick,
                  onChanged: (val) => setState(() => _customThick = val),
                  borderWidthOverride: 3.0,
                  color: TectaColors.errorMain,
                  label: 'Thick Border',
                ),
                TectaCheckbox(
                  value: _customColor,
                  onChanged: (val) => setState(() => _customColor = val),
                  activeBgColorOverride: Colors.amber,
                  activeBorderColorOverride: Colors.orange,
                  checkMarkColorOverride: Colors.black,
                  label: 'Custom Colors',
                ),
                TectaCheckbox(
                  value: _customSizeSpacing,
                  onChanged: (val) => setState(() => _customSizeSpacing = val),
                  boxSizeOverride: 28.0,
                  iconSizeOverride: 20.0,
                  spacingOverride: 16.0,
                  color: TectaColors.infoMain,
                  label: 'Custom Size',
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Color Palettes',
            note: 'TectaCheckbox is fully integrated with semantic theme color palettes including Primary, Secondary, Info, Success, Warning, and Error.',
            code: '''TectaCheckbox(
  value: true,
  color: TectaColors.successMain,
  label: 'Success Color',
  onChanged: (val) => {},
)''',
            overview: Wrap(
              spacing: 20,
              runSpacing: 16,
              children: _colors.map((col) {
                return TectaCheckbox(
                  value: _colorsChecked[col],
                  onChanged: (val) => setState(() => _colorsChecked[col] = val),
                  color: col,
                  label: _getColorName(col),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
