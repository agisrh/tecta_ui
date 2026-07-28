import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class CheckboxShowcasePage extends StatefulWidget {
  const CheckboxShowcasePage({super.key});

  @override
  State<CheckboxShowcasePage> createState() => _CheckboxShowcasePageState();
}

class _CheckboxShowcasePageState extends State<CheckboxShowcasePage> {
  // State variables for various checkboxes
  bool? _basicUnchecked = false;
  bool? _basicChecked = true;
  bool? _basicIndeterminate; // null

  bool? _sizeMedium = true;
  bool? _sizeSmall = true;

  bool? _placementTop = false;
  bool? _placementStart = false;
  bool? _placementBottom = false;
  bool? _placementEnd = false;

  // Custom styles state
  bool? _customRound = true;
  bool? _customThick = true;
  bool? _customColor = true;
  bool? _customSizeSpacing = true;

  // Colors state mapping
  static final List<Color> _colors = [
    TectaColors.grey800,
    TectaColors.primaryMain,
    TectaColors.secondaryMain,
    TectaColors.infoMain,
    TectaColors.successMain,
    TectaColors.warningMain,
    TectaColors.errorMain,
    Colors.purple,
    Colors.deepOrange,
  ];

  final Map<Color, bool?> _colorsChecked = {
    TectaColors.grey800: true,
    TectaColors.primaryMain: true,
    TectaColors.secondaryMain: true,
    TectaColors.infoMain: true,
    TectaColors.successMain: true,
    TectaColors.warningMain: true,
    TectaColors.errorMain: true,
    Colors.purple: true,
    Colors.deepOrange: true,
  };

  final Map<Color, bool?> _colorsIndeterminate = {
    TectaColors.grey800: null,
    TectaColors.primaryMain: null,
    TectaColors.secondaryMain: null,
    TectaColors.infoMain: null,
    TectaColors.successMain: null,
    TectaColors.warningMain: null,
    TectaColors.errorMain: null,
    Colors.purple: null,
    Colors.deepOrange: null,
  };

  String _getColorName(Color color) {
    if (color == TectaColors.grey800) return 'Default';
    if (color == TectaColors.primaryMain) return 'Primary';
    if (color == TectaColors.secondaryMain) return 'Secondary';
    if (color == TectaColors.infoMain) return 'Info';
    if (color == TectaColors.successMain) return 'Success';
    if (color == TectaColors.warningMain) return 'Warning';
    if (color == TectaColors.errorMain) return 'Error';
    if (color == Colors.purple) return 'Purple';
    if (color == Colors.deepOrange) return 'Orange';
    return 'Custom';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Checkbox',
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
      backgroundColor: TectaColors.grey100,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          // ===========================================================================
          // BASIC CHECKBOXES
          // ===========================================================================
          _buildSectionHeader('BASIC'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 24,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TectaCheckbox(
                  value: _basicUnchecked,
                  onChanged: (val) => setState(() => _basicUnchecked = val),
                  color: TectaColors.successMain,
                ),
                TectaCheckbox(
                  value: _basicChecked,
                  onChanged: (val) => setState(() => _basicChecked = val),
                  color: TectaColors.successMain,
                ),
                TectaCheckbox(
                  value: _basicIndeterminate,
                  onChanged: (val) => setState(() => _basicIndeterminate = val),
                  color: TectaColors.successMain,
                ),
                const TectaCheckbox(
                  value: false,
                  onChanged: null,
                ),
                const TectaCheckbox(
                  value: true,
                  onChanged: null,
                ),
                const TectaCheckbox(
                  value: null,
                  onChanged: null,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // SIZES
          // ===========================================================================
          _buildSectionHeader('SIZES'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 24,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TectaCheckbox(
                  value: _sizeMedium,
                  onChanged: (val) => setState(() => _sizeMedium = val),
                  color: TectaColors.successMain,
                  size: TectaCheckboxSize.medium,
                  label: 'Medium',
                ),
                TectaCheckbox(
                  value: _sizeSmall,
                  onChanged: (val) => setState(() => _sizeSmall = val),
                  color: TectaColors.successMain,
                  size: TectaCheckboxSize.small,
                  label: 'Small',
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // PLACEMENT
          // ===========================================================================
          _buildSectionHeader('PLACEMENT'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 24,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
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

          const SizedBox(height: 32),

          // ===========================================================================
          // CUSTOM STYLES
          // ===========================================================================
          _buildSectionHeader('CUSTOM STYLE'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 24,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
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
                  borderWidthOverride: 4.0,
                  color: TectaColors.errorMain,
                  label: 'Thick Border',
                ),
                TectaCheckbox(
                  value: _customColor,
                  onChanged: (val) => setState(() => _customColor = val),
                  activeBgColorOverride: Colors.amber,
                  activeBorderColorOverride: Colors.orange,
                  checkMarkColorOverride: Colors.black,
                  label: 'Custom Color',
                ),
                TectaCheckbox(
                  value: _customSizeSpacing,
                  onChanged: (val) => setState(() => _customSizeSpacing = val),
                  boxSizeOverride: 28.0,
                  iconSizeOverride: 20.0,
                  spacingOverride: 16.0,
                  color: TectaColors.infoMain,
                  label: 'Custom Size/Spacing',
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // COLORS
          // ===========================================================================
          _buildSectionHeader('COLORS'),
          const SizedBox(height: 16),
          _buildCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Checked Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._colors.map((col) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _buildColorRow(col, _getColorName(col), true),
                      );
                    }),
                    const TectaCheckbox(
                      value: true,
                      onChanged: null,
                      label: 'Disabled',
                    ),
                  ],
                ),
                // Indeterminate Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._colors.map((col) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _buildColorRow(col, _getColorName(col), false),
                      );
                    }),
                    const TectaCheckbox(
                      value: null,
                      onChanged: null,
                      label: 'Disabled',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorRow(Color color, String label, bool isCheckedCol) {
    final Map<Color, bool?> stateMap = isCheckedCol ? _colorsChecked : _colorsIndeterminate;
    return TectaCheckbox(
      value: stateMap[color],
      onChanged: (val) => setState(() => stateMap[color] = val),
      color: color,
      label: label,
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
