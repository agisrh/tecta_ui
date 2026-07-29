import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'progress_playground_parser.dart';
import 'progress_playground_docs.dart';

class ProgressPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const ProgressPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<ProgressPlayground> createState() => _ProgressPlaygroundState();
}

class _ProgressPlaygroundState extends State<ProgressPlayground> {
  double? _progressValue = 0.6;
  String _progressType = 'linear';

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaLinearProgress(
    value: 0.6,
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _progressValue = ProgressPlaygroundParser.parseValue(code, 0.6);
      _progressType = ProgressPlaygroundParser.parseProgressType(code, 'linear');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Progress',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const ProgressPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: _progressType == 'linear'
                ? TectaLinearProgress(value: _progressValue)
                : TectaCircularProgress(value: _progressValue),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Progress Mode: ${_progressType.toUpperCase()} | Value: ${_progressValue != null ? "${(_progressValue! * 100).toInt()}%" : "Indeterminate"}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
