import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'slider_playground_parser.dart';
import 'slider_playground_docs.dart';

class SliderPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const SliderPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<SliderPlayground> createState() => _SliderPlaygroundState();
}

class _SliderPlaygroundState extends State<SliderPlayground> {
  double _sliderValue = 0.5;
  double _minValue = 0.0;
  double _maxValue = 1.0;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaSlider(
    value: 0.5,
    min: 0.0,
    max: 1.0,
    onChanged: (val) {},
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _minValue = SliderPlaygroundParser.parseMin(code, 0.0);
      _maxValue = SliderPlaygroundParser.parseMax(code, 1.0);
      _sliderValue = SliderPlaygroundParser.parseValue(code, 0.5).clamp(_minValue, _maxValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Slider',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const SliderPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TectaSlider(
              value: _sliderValue,
              min: _minValue,
              max: _maxValue,
              onChanged: (val) {
                setState(() {
                  _sliderValue = val;
                });
              },
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Active Value: ${_sliderValue.toStringAsFixed(2)} [Min: $_minValue, Max: $_maxValue]',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
