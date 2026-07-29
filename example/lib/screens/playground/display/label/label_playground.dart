import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'label_playground_parser.dart';
import 'label_playground_docs.dart';

class LabelPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const LabelPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<LabelPlayground> createState() => _LabelPlaygroundState();
}

class _LabelPlaygroundState extends State<LabelPlayground> {
  String _labelText = 'Active Status';
  TectaLabelVariant _variant = TectaLabelVariant.soft;
  Color _color = TectaColors.successMain;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaLabel(
    text: 'Active Status',
    variant: TectaLabelVariant.soft,
    color: TectaColors.successMain,
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _labelText = LabelPlaygroundParser.parseText(code, 'Active Status');
      _variant = LabelPlaygroundParser.parseVariant(code, TectaLabelVariant.soft);
      _color = LabelPlaygroundParser.parseColor(code, TectaColors.successMain);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Label',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const LabelPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Center(
        child: TectaLabel(
          text: _labelText,
          variant: _variant,
          color: _color,
        ),
      ),
    );
  }
}
