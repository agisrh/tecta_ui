import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'accordion_playground_parser.dart';
import 'accordion_playground_docs.dart';

class AccordionPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const AccordionPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<AccordionPlayground> createState() => _AccordionPlaygroundState();
}

class _AccordionPlaygroundState extends State<AccordionPlayground> {
  String _titleText = 'Accordion Panel Title';
  String _subtitleText = 'Optional helper caption';

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaAccordion(
    title: 'Accordion Panel Title',
    subtitle: 'Optional helper caption',
    child: Text('Collapsible nested panel description text goes here.'),
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _titleText = AccordionPlaygroundParser.parseTitle(code, 'Accordion Panel Title');
      _subtitleText = AccordionPlaygroundParser.parseSubtitle(code, 'Optional helper caption');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Accordion',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const AccordionPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TectaAccordion(
          title: _titleText,
          subtitle: _subtitleText,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Collapsible nested panel description text goes here.',
              style: TextStyle(fontSize: 13, height: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
