import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'tooltip_playground_parser.dart';
import 'tooltip_playground_docs.dart';

class TooltipPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const TooltipPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<TooltipPlayground> createState() => _TooltipPlaygroundState();
}

class _TooltipPlaygroundState extends State<TooltipPlayground> {
  String _message = 'Helpful Tooltip message info!';
  TectaTooltipPosition _position = TectaTooltipPosition.top;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaTooltip(
    message: 'Helpful Tooltip message info!',
    position: TectaTooltipPosition.top,
    child: Text('Hover or Press Me'),
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _message = TooltipPlaygroundParser.parseMessage(code, 'Helpful Tooltip message info!');
      _position = TooltipPlaygroundParser.parsePosition(code, TectaTooltipPosition.top);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Tooltip',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const TooltipPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Center(
        child: TectaTooltip(
          message: _message,
          position: _position,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: TectaColors.primaryMain,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Long Press Me',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
