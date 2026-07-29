import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'dialog_playground_parser.dart';
import 'dialog_playground_docs.dart';

class DialogPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const DialogPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<DialogPlayground> createState() => _DialogPlaygroundState();
}

class _DialogPlaygroundState extends State<DialogPlayground> {
  String _titleText = 'Confirm Delete';
  String _contentText = 'Are you sure you want to permanently delete this item?';

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaButton(
    label: 'Show Dialog',
    onPressed: () {
      showTectaDialog(
        context,
        child: TectaDialog(
          title: 'Confirm Delete',
          content: Text('Are you sure you want to permanently delete this item?'),
          actions: [
            TectaButton(label: 'Cancel', onPressed: () {}),
            TectaButton(label: 'Confirm', onPressed: () {}),
          ],
        ),
      );
    },
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _titleText = DialogPlaygroundParser.parseTitle(code, 'Confirm Delete');
      _contentText = DialogPlaygroundParser.parseContent(code, 'Are you sure you want to permanently delete this item?');
    });
  }

  void _showDialog() {
    showTectaDialog(
      context,
      child: TectaDialog(
        title: _titleText,
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(_contentText),
        ),
        actions: [
          TectaButton(
            label: 'Cancel',
            color: TectaColors.grey300,
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          TectaButton(
            label: 'Confirm',
            color: TectaColors.primaryMain,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Dialog',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const DialogPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Center(
        child: TectaButton(
          label: 'Show Dialog',
          color: TectaColors.primaryMain,
          onPressed: _showDialog,
        ),
      ),
    );
  }
}
