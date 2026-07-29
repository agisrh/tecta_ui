import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'typography_playground_parser.dart';
import 'typography_playground_docs.dart';

class TypographyPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const TypographyPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<TypographyPlayground> createState() => _TypographyPlaygroundState();
}

class _TypographyPlaygroundState extends State<TypographyPlayground> {
  TextStyle _textStyle = TectaTypography.h1;
  String _textString = 'The quick brown fox jumps over the lazy dog';
  String _styleName = 'TectaTypography.h1';

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Text(
    text: 'The quick brown fox jumps over the lazy dog',
    style: TectaTypography.h1,
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _textStyle = TypographyPlaygroundParser.parseStyle(code, TectaTypography.h1);
      _textString = TypographyPlaygroundParser.parseText(code, 'The quick brown fox jumps over the lazy dog');
      _styleName = TypographyPlaygroundParser.parseStyleName(code, 'TectaTypography.h1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Typography',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const TypographyPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Builder(
        builder: (innerCtx) {
          final primary = Theme.of(innerCtx).colorScheme.primary;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _textString,
                style: _textStyle.copyWith(color: primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Active Style: $_styleName',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
