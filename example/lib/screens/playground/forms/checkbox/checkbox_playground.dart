import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'checkbox_playground_parser.dart';
import 'checkbox_playground_docs.dart';

class CheckboxPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const CheckboxPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<CheckboxPlayground> createState() => _CheckboxPlaygroundState();
}

class _CheckboxPlaygroundState extends State<CheckboxPlayground> {
  String _labelText = 'Subscribe to Newsletter';
  bool _checkedValue = true;
  bool _disabledValue = false;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaCheckbox(
    label: 'Subscribe to Newsletter',
    value: true,
    onChanged: (val) {},
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _labelText = CheckboxPlaygroundParser.parseLabel(code, 'Subscribe to Newsletter');
      _checkedValue = CheckboxPlaygroundParser.parseChecked(code, true);
      _disabledValue = CheckboxPlaygroundParser.parseDisabled(code, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Checkbox',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const CheckboxPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TectaCheckbox(
            label: _labelText,
            value: _checkedValue,
            onChanged: _disabledValue
                ? null
                : (val) {
                    setState(() {
                      _checkedValue = val ?? false;
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
              'Interactive State: ${_checkedValue ? "Checked" : "Unchecked"} ${_disabledValue ? "(Disabled)" : ""}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
