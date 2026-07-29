import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'shadows_playground_parser.dart';
import 'shadows_playground_docs.dart';

class ShadowsPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const ShadowsPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<ShadowsPlayground> createState() => _ShadowsPlaygroundState();
}

class _ShadowsPlaygroundState extends State<ShadowsPlayground> {
  List<BoxShadow> _shadowValue = TectaShadows.z8;
  String _shadowName = 'TectaShadows.z8';

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: TectaShadows.z8,
    ),
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _shadowValue = ShadowsPlaygroundParser.parseShadow(code, TectaShadows.z8);
      _shadowName = ShadowsPlaygroundParser.parseShadowName(code, 'TectaShadows.z8');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Shadows',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const ShadowsPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: _shadowValue,
            ),
            child: const Center(
              child: Text(
                'Box Shadow',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Active Shadow: $_shadowName',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
