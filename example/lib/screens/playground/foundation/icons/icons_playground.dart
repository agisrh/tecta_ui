import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'icons_playground_parser.dart';
import 'icons_playground_docs.dart';

class IconsPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const IconsPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<IconsPlayground> createState() => _IconsPlaygroundState();
}

class _IconsPlaygroundState extends State<IconsPlayground> {
  IconData _iconData = SolarLinearIcons.star;
  double _iconSize = 48.0;
  String _iconName = 'SolarLinearIcons.star';
  Color _iconColor = TectaColors.primaryMain;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Icon(
    SolarLinearIcons.star,
    size: 48,
    color: TectaColors.primaryMain,
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _iconData = IconsPlaygroundParser.parseIcon(code, SolarLinearIcons.star);
      _iconSize = IconsPlaygroundParser.parseSize(code, 48.0);
      _iconName = IconsPlaygroundParser.parseIconName(code, 'SolarLinearIcons.star');
      _iconColor = IconsPlaygroundParser.parseColor(code, TectaColors.primaryMain);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Icons',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const IconsPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _iconData,
            size: _iconSize,
            color: _iconColor,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Active Icon: $_iconName | Size: ${_iconSize.toInt()}px',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
