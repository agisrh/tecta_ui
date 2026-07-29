import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class RadioShowcasePage extends StatefulWidget {
  const RadioShowcasePage({super.key});

  @override
  State<RadioShowcasePage> createState() => _RadioShowcasePageState();
}

class _RadioShowcasePageState extends State<RadioShowcasePage> {
  String _basicVal = 'A';
  String _sizeVal = 'medium';
  String _placementVal = 'top';
  Color _colorVal = TectaColors.primaryMain;

  static final List<Color> _colors = [
    TectaColors.primaryMain,
    TectaColors.secondaryMain,
    TectaColors.infoMain,
    TectaColors.successMain,
    TectaColors.warningMain,
    TectaColors.errorMain,
  ];

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
                'Radio Button',
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
            title: 'Basic Radios',
            note: 'TectaRadio is used for single selection flows. Selecting a radio button automatically deselects other choices in the group.',
            code: '''TectaRadio<String>(
  value: 'A',
  groupValue: _selectedValue,
  onChanged: (val) => setState(() => _selectedValue = val!),
)''',
            overview: Row(
              children: [
                TectaRadio<String>(
                  value: 'A',
                  groupValue: _basicVal,
                  color: TectaColors.successMain,
                  label: 'Option A',
                  onChanged: (v) => setState(() => _basicVal = v!),
                ),
                const SizedBox(width: 24),
                TectaRadio<String>(
                  value: 'B',
                  groupValue: _basicVal,
                  color: TectaColors.successMain,
                  label: 'Option B',
                  onChanged: (v) => setState(() => _basicVal = v!),
                ),
                const SizedBox(width: 24),
                TectaRadio<String>(
                  value: 'C',
                  groupValue: _basicVal,
                  color: TectaColors.successMain,
                  label: 'Option C',
                  onChanged: (v) => setState(() => _basicVal = v!),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Sizes',
            note: 'TectaRadio supports small and medium sizing classes to fit into compact forms or lists.',
            code: '''TectaRadio<String>(
  value: 'small',
  size: TectaRadioSize.small,
  label: 'Small',
  groupValue: _val,
  onChanged: (v) => {},
)''',
            overview: Row(
              children: [
                TectaRadio<String>(
                  value: 'medium',
                  groupValue: _sizeVal,
                  label: 'Medium',
                  size: TectaRadioSize.medium,
                  color: TectaColors.successMain,
                  onChanged: (v) => setState(() => _sizeVal = v!),
                ),
                const SizedBox(width: 32),
                TectaRadio<String>(
                  value: 'small',
                  groupValue: _sizeVal,
                  label: 'Small',
                  size: TectaRadioSize.small,
                  color: TectaColors.successMain,
                  onChanged: (v) => setState(() => _sizeVal = v!),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Label Placement',
            note: 'Arrange label layout placement options (top, start, bottom, end) relative to the radio circular boundary control.',
            code: '''TectaRadio<String>(
  value: 'start',
  label: 'Start Label',
  labelPlacement: TectaRadioLabelPlacement.start,
  groupValue: _val,
  onChanged: (v) => {},
)''',
            overview: Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                TectaRadio<String>(
                  value: 'top',
                  groupValue: _placementVal,
                  label: 'Top',
                  labelPlacement: TectaRadioLabelPlacement.top,
                  color: TectaColors.successMain,
                  onChanged: (v) => setState(() => _placementVal = v!),
                ),
                TectaRadio<String>(
                  value: 'start',
                  groupValue: _placementVal,
                  label: 'Start',
                  labelPlacement: TectaRadioLabelPlacement.start,
                  color: TectaColors.successMain,
                  onChanged: (v) => setState(() => _placementVal = v!),
                ),
                TectaRadio<String>(
                  value: 'bottom',
                  groupValue: _placementVal,
                  label: 'Bottom',
                  labelPlacement: TectaRadioLabelPlacement.bottom,
                  color: TectaColors.successMain,
                  onChanged: (v) => setState(() => _placementVal = v!),
                ),
                TectaRadio<String>(
                  value: 'end',
                  groupValue: _placementVal,
                  label: 'End',
                  labelPlacement: TectaRadioLabelPlacement.end,
                  color: TectaColors.successMain,
                  onChanged: (v) => setState(() => _placementVal = v!),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Semantic Colors',
            note: 'Customize background indicator ring highlight tones using semantic layout tokens.',
            code: '''TectaRadio<Color>(
  value: TectaColors.primaryMain,
  color: TectaColors.primaryMain,
  groupValue: _color,
  onChanged: (v) => {},
)''',
            overview: Wrap(
              spacing: 20,
              runSpacing: 16,
              children: _colors.map((col) {
                return TectaRadio<Color>(
                  value: col,
                  groupValue: _colorVal,
                  color: col,
                  label: _getColorName(col),
                  onChanged: (v) => setState(() => _colorVal = v!),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
