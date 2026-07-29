import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'switch_playground_parser.dart';
import 'switch_playground_docs.dart';

class SwitchPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const SwitchPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<SwitchPlayground> createState() => _SwitchPlaygroundState();
}

class _SwitchPlaygroundState extends State<SwitchPlayground> {
  String _labelText = 'Enable Dark Mode';
  bool _checkedValue = false;
  bool _disabledValue = false;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaSwitch(
    label: 'Enable Dark Mode',
    value: false,
    onChanged: (val) {},
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _labelText = SwitchPlaygroundParser.parseLabel(code, 'Enable Dark Mode');
      _checkedValue = SwitchPlaygroundParser.parseChecked(code, false);
      _disabledValue = SwitchPlaygroundParser.parseDisabled(code, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Switch',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const SwitchPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TectaSwitch(
            label: _labelText,
            value: _checkedValue,
            onChanged: _disabledValue
                ? null
                : (val) {
                    setState(() {
                      _checkedValue = val;
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
              'Toggle Switch: ${_checkedValue ? "ON" : "OFF"} ${_disabledValue ? "(Disabled)" : ""}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
