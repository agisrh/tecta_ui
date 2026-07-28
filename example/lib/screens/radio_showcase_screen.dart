import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class RadioShowcasePage extends StatefulWidget {
  const RadioShowcasePage({super.key});

  @override
  State<RadioShowcasePage> createState() => _RadioShowcasePageState();
}

class _RadioShowcasePageState extends State<RadioShowcasePage> {
  // Basic group state
  String _basicVal = 'A';

  // Sizing group state
  String _sizeVal = 'medium';

  // Placement group state
  String _placementVal = 'top';

  // Colors group state
  Color _colorVal = TectaColors.primaryMain;

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
          'Radio Button',
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
          // BASIC RADIOS
          // ===========================================================================
          _buildSectionHeader('BASIC'),
          const SizedBox(height: 16),
          _buildCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TectaRadio<String>(
                  value: 'A',
                  groupValue: _basicVal,
                  color: TectaColors.successMain,
                  onChanged: (v) => setState(() => _basicVal = v!),
                ),
                const SizedBox(width: 16),
                TectaRadio<String>(
                  value: 'B',
                  groupValue: _basicVal,
                  color: TectaColors.successMain,
                  onChanged: (v) => setState(() => _basicVal = v!),
                ),
                const SizedBox(width: 16),
                TectaRadio<String>(
                  value: 'C',
                  groupValue: _basicVal,
                  color: TectaColors.successMain,
                  onChanged: (v) => setState(() => _basicVal = v!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ===========================================================================
          // SIZES RADIOS
          // ===========================================================================
          _buildSectionHeader('SIZES'),
          const SizedBox(height: 16),
          _buildCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TectaRadio<String>(
                  value: 'medium',
                  groupValue: _sizeVal,
                  label: 'Medium',
                  size: TectaRadioSize.medium,
                  color: TectaColors.successMain,
                  onChanged: (v) => setState(() => _sizeVal = v!),
                ),
                const SizedBox(width: 24),
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
          const SizedBox(height: 32),

          // ===========================================================================
          // PLACEMENTS RADIOS
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
          const SizedBox(height: 32),

          // ===========================================================================
          // COLORS RADIOS
          // ===========================================================================
          _buildSectionHeader('COLORS'),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Colors',
                    style: TextStyle(fontWeight: FontWeight.w500, color: TectaColors.grey500),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._colors.map((col) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildColorRow(col, _getColorName(col)),
                          );
                        }),
                        const TectaRadio<Color>(
                          value: Colors.transparent,
                          groupValue: Colors.black,
                          label: 'Disabled',
                          onChanged: null,
                        ),
                      ],
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

  Widget _buildColorRow(Color color, String label) {
    return TectaRadio<Color>(
      value: color,
      groupValue: _colorVal,
      color: color,
      label: label,
      onChanged: (v) => setState(() => _colorVal = v!),
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
