import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'alert_playground_parser.dart';
import 'alert_playground_docs.dart';

class AlertPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const AlertPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<AlertPlayground> createState() => _AlertPlaygroundState();
}

class _AlertPlaygroundState extends State<AlertPlayground> {
  String _alertTitle = 'Notice';
  String _alertDesc = 'This is an example notification widget.';
  TectaAlertSeverity _alertSeverity = TectaAlertSeverity.info;
  TectaAlertVariant _alertVariant = TectaAlertVariant.soft;
  bool _alertIsClosable = true;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';

Widget build(BuildContext context) {
  return TectaAlert(
    title: 'Notice',
    message: 'This is an example notification widget.',
    severity: TectaAlertSeverity.info,
    variant: TectaAlertVariant.soft,
    isClosable: true,
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _alertSeverity = AlertPlaygroundParser.parseSeverity(code, TectaAlertSeverity.info);
      _alertVariant = AlertPlaygroundParser.parseVariant(code, TectaAlertVariant.soft);
      _alertTitle = AlertPlaygroundParser.parseTitle(code, 'Notice');
      _alertIsClosable = AlertPlaygroundParser.parseIsClosable(code, true);
      _alertDesc = AlertPlaygroundParser.parseMessage(code, 'This is an example notification widget.');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Alert',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const AlertPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: TectaAlert(
        title: _alertTitle,
        message: _alertDesc,
        severity: _alertSeverity,
        variant: _alertVariant,
        onClose: _alertIsClosable ? () {} : null,
      ),
    );
  }
}
