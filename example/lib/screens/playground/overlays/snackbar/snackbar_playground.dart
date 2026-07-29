import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'snackbar_playground_parser.dart';
import 'snackbar_playground_docs.dart';

class SnackbarPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const SnackbarPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<SnackbarPlayground> createState() => _SnackbarPlaygroundState();
}

class _SnackbarPlaygroundState extends State<SnackbarPlayground> {
  String _message = 'Operation successful!';
  TectaSnackbarVariant _variant = TectaSnackbarVariant.success;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaButton(
    label: 'Show Toast',
    onPressed: () {
      TectaSnackbar.show(
        context,
        message: 'Operation successful!',
        variant: TectaSnackbarVariant.success,
      );
    },
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _message = SnackbarPlaygroundParser.parseMessage(code, 'Operation successful!');
      _variant = SnackbarPlaygroundParser.parseVariant(code, TectaSnackbarVariant.success);
    });
  }

  void _showToast() {
    TectaSnackbar.show(
      context,
      message: _message,
      variant: _variant,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Snackbar',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const SnackbarPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Center(
        child: TectaButton(
          label: 'Show Toast',
          color: TectaColors.primaryMain,
          onPressed: _showToast,
        ),
      ),
    );
  }
}
