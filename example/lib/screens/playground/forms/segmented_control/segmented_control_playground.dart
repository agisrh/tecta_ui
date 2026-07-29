import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'segmented_control_playground_parser.dart';
import 'segmented_control_playground_docs.dart';

class SegmentedControlPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const SegmentedControlPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<SegmentedControlPlayground> createState() => _SegmentedControlPlaygroundState();
}

class _SegmentedControlPlaygroundState extends State<SegmentedControlPlayground> {
  int _selectedIndex = 0;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaSegmentedControl(
    selectedIndex: 0,
    options: [
      TectaSegmentedOption(label: 'Weekly'),
      TectaSegmentedOption(label: 'Monthly'),
      TectaSegmentedOption(label: 'Yearly'),
    ],
    onValueChanged: (index) {},
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _selectedIndex = SegmentedControlPlaygroundParser.parseSelectedIndex(code, 0).clamp(0, 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'SegmentedControl',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const SegmentedControlPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TectaSegmentedControl(
            selectedIndex: _selectedIndex,
            options: const [
              TectaSegmentedOption(label: 'Weekly'),
              TectaSegmentedOption(label: 'Monthly'),
              TectaSegmentedOption(label: 'Yearly'),
            ],
            onValueChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Selected Tab Index: $_selectedIndex',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
