import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Slider',
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
            title: 'Continuous Slider',
            note: 'Allows selection of values along a continuous line from 0.0 to 1.0. TectaSlider wraps Material Slider styling with customized default track tokens.',
            code: '''TectaSlider(
  value: _val1,
  onChanged: (val) {
    setState(() => _val1 = val);
  },
)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Value: ${(_val1 * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : TectaColors.grey700,
                  ),
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
          ShowcaseSection(
            title: 'Discrete Slider',
            note: 'Divides the slider track into equal increments. Displays optional labels above the thumb indicating current selected step.',
            code: '''TectaSlider(
  value: _val2,
  min: 1.0,
  max: 5.0,
  divisions: 4,
  label: _val2.toStringAsFixed(0),
  activeColor: TectaColors.successMain,
  onChanged: (val) {
    setState(() => _val2 = val);
  },
)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Value Step: ${_val2.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : TectaColors.grey700,
                  ),
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
}
