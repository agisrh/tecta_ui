import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'colors_playground_parser.dart';
import 'colors_playground_docs.dart';

class ColorsPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const ColorsPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<ColorsPlayground> createState() => _ColorsPlaygroundState();
}

class _ColorsPlaygroundState extends State<ColorsPlayground> {
  // Parsed Visual States
  Color _colorValue = TectaColors.primaryMain;
  String _colorName = 'primaryMain';
  double _colorWidth = 200.0;
  double _colorHeight = 200.0;
  double _colorRadius = 16.0;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: TectaColors.primaryMain,
      borderRadius: BorderRadius.circular(16),
    ),
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _colorWidth = ColorsPlaygroundParser.parseWidth(code, 200.0);
      _colorHeight = ColorsPlaygroundParser.parseHeight(code, 200.0);
      _colorRadius = ColorsPlaygroundParser.parseRadius(code, 16.0);
      
      final colorName = ColorsPlaygroundParser.parseColorName(code, 'primaryMain');
      _colorName = colorName;
      _colorValue = ColorsPlaygroundParser.getColorFromName(colorName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Color',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const ColorsPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Container(
        width: _colorWidth,
        height: _colorHeight,
        decoration: BoxDecoration(
          color: _colorValue,
          borderRadius: BorderRadius.circular(_colorRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TectaColors.$_colorName',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 1)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  '#${_colorValue.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    shadows: [
                      Shadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 1)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
