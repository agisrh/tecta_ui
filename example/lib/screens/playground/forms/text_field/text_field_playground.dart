import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'text_field_playground_parser.dart';
import 'text_field_playground_docs.dart';

class TextFieldPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const TextFieldPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<TextFieldPlayground> createState() => _TextFieldPlaygroundState();
}

class _TextFieldPlaygroundState extends State<TextFieldPlayground> {
  String _tfLabel = 'Email Address';
  String _tfHint = 'Enter your email...';
  String _tfHelper = 'We will never share your email.';
  String _tfError = '';

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';

Widget build(BuildContext context) {
  return TectaTextField(
    label: 'Email Address',
    placeholder: 'Enter your email...',
    helperText: 'We will never share your email.',
    errorText: '',
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _tfLabel = TextFieldPlaygroundParser.parseLabel(code, 'Email Address');
      _tfHint = TextFieldPlaygroundParser.parsePlaceholder(code, '');
      _tfHelper = TextFieldPlaygroundParser.parseHelperText(code, '');
      _tfError = TextFieldPlaygroundParser.parseErrorText(code, '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'TextField',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const TextFieldPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: SizedBox(
        width: 340,
        child: TectaTextField(
          label: _tfLabel,
          placeholder: _tfHint,
          helperText: _tfHelper,
          errorText: _tfError.isEmpty ? null : _tfError,
        ),
      ),
    );
  }
}
