import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'picker_playground_parser.dart';
import 'picker_playground_docs.dart';

class PickerPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const PickerPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<PickerPlayground> createState() => _PickerPlaygroundState();
}

class _PickerPlaygroundState extends State<PickerPlayground> {
  String _pickerType = 'date';
  String _selectedValueText = 'No value selected';

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaButton(
    label: 'Open Date Picker',
    onPressed: () async {
      final date = await showTectaDatePicker(
        context: context,
        initialDate: DateTime.now(),
      );
    },
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _pickerType = PickerPlaygroundParser.parsePickerType(code, 'date');
    });
  }

  Future<void> _openPicker() async {
    final now = DateTime.now();
    if (_pickerType == 'date') {
      final res = await showTectaDatePicker(
        context: context,
        initialDate: now,
      );
      if (res != null) {
        setState(() {
          _selectedValueText = 'Selected Date: ${res.day}/${res.month}/${res.year}';
        });
      }
    } else if (_pickerType == 'time') {
      final res = await showTectaTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (res != null) {
        setState(() {
          _selectedValueText = 'Selected Time: ${res.hour}:${res.minute}';
        });
      }
    } else if (_pickerType == 'month') {
      final res = await showTectaMonthPicker(
        context: context,
        initialMonth: now.month,
      );
      if (res != null) {
        setState(() {
          _selectedValueText = 'Selected Month Index: $res';
        });
      }
    } else if (_pickerType == 'year') {
      final res = await showTectaYearPicker(
        context: context,
        initialYear: now.year,
      );
      if (res != null) {
        setState(() {
          _selectedValueText = 'Selected Year: $res';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Picker',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const PickerPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TectaButton(
            label: 'Open ${_pickerType.toUpperCase()} Picker',
            color: TectaColors.primaryMain,
            onPressed: _openPicker,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              _selectedValueText,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
