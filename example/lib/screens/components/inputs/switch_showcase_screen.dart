import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class SwitchShowcasePage extends StatefulWidget {
  const SwitchShowcasePage({super.key});

  @override
  State<SwitchShowcasePage> createState() => _SwitchShowcasePageState();
}

class _SwitchShowcasePageState extends State<SwitchShowcasePage> {
  // Basic states
  bool _basicActive = true;
  bool _basicInactive1 = false;
  bool _basicInactive2 = false;
  bool _basicDefaultActive = true;

  // Sizes states
  bool _sizeSmall = false;
  bool _sizeMedium = false;

  // Placement states
  bool _placementTop = false;
  bool _placementStart = false;
  bool _placementBottom = false;
  bool _placementEnd = false;

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

  // Colors states (Default Column)
  final Map<Color, bool> _colorsActive = {
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
  bool _colorsUnchecked = false;

  // Colors states (Disabled Column)
  final Map<Color, bool> _colorsDisabled = {
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
  final bool _colorsDisabledUnchecked = false;

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
          'Switch',
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
          // BASIC SWITCHES
          // ===========================================================================
          _buildSectionHeader('BASIC'),
          const SizedBox(height: 16),
          _buildCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(height: 32),

          // ===========================================================================
          // SIZES
          // ===========================================================================
          _buildSectionHeader('SIZES'),
          const SizedBox(height: 16),
          _buildCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(height: 32),

          // ===========================================================================
          // PLACEMENTS
          // ===========================================================================
          _buildSectionHeader('PLACEMENTS'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 24,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
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
          const SizedBox(height: 32),

          // ===========================================================================
          // COLORS
          // ===========================================================================
          _buildSectionHeader('COLORS'),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Default Column Card
              Expanded(
                child: _buildColumnCard(
                  title: 'Default',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._colors.map((col) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildColorRow(col, _getColorName(col), false),
                        );
                      }),
                      TectaSwitch(
                        value: _colorsUnchecked,
                        label: 'Unchecked',
                        onChanged: (val) => setState(() => _colorsUnchecked = val),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Disabled Column Card
              Expanded(
                child: _buildColumnCard(
                  title: 'Disabled',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._colors.map((col) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildColorRow(col, _getColorName(col), true),
                        );
                      }),
                      TectaSwitch(
                        value: _colorsDisabledUnchecked,
                        label: 'Unchecked',
                        onChanged: null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorRow(Color color, String label, bool isDisabled) {
    if (isDisabled) {
      return TectaSwitch(
        value: _colorsDisabled[color]!,
        color: color,
        label: label,
        onChanged: null,
      );
    }
    return TectaSwitch(
      value: _colorsActive[color]!,
      color: color,
      label: label,
      onChanged: (val) => setState(() => _colorsActive[color] = val),
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

  Widget _buildColumnCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: TectaColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: TectaColors.grey100,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: TectaColors.grey200),
            ),
            child: Text(
              title,
              style: TectaTypography.overline.copyWith(
                color: TectaColors.grey600,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
