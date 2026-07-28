import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class SliderShowcasePage extends StatefulWidget {
  const SliderShowcasePage({super.key});

  @override
  State<SliderShowcasePage> createState() => _SliderShowcasePageState();
}

class _SliderShowcasePageState extends State<SliderShowcasePage> {
  double _val1 = 0.4;
  double _val2 = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Slider',
          style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: TectaColors.grey100,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          // ---------------------------------------------------------
          // CONTINUOUS SLIDER
          // ---------------------------------------------------------
          _buildSectionHeader('Continuous Slider (0.0 to 1.0)'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Value: ${(_val1 * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TectaSlider(
                  value: _val1,
                  onChanged: (val) {
                    setState(() {
                      _val1 = val;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ---------------------------------------------------------
          // DISCRETE SLIDER
          // ---------------------------------------------------------
          _buildSectionHeader('Discrete Slider (Steps 1 to 5)'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Value Step: ${_val2.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TectaSlider(
                  value: _val2,
                  min: 1.0,
                  max: 5.0,
                  divisions: 4,
                  label: _val2.toStringAsFixed(0),
                  activeColor: TectaColors.successMain,
                  onChanged: (val) {
                    setState(() {
                      _val2 = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
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
    return Material(
      color: TectaColors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: TectaColors.grey200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: child,
      ),
    );
  }
}
