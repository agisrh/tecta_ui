import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'tabs_playground_parser.dart';
import 'tabs_playground_docs.dart';

class TabsPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const TabsPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<TabsPlayground> createState() => _TabsPlaygroundState();
}

class _TabsPlaygroundState extends State<TabsPlayground> {
  TectaTabsVariant _variant = TectaTabsVariant.line;
  int _selectedIndex = 0;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaTabs(
    variant: TectaTabsVariant.line,
    selectedIndex: 0,
    tabs: [
      TectaTab(label: 'Dashboard'),
      TectaTab(label: 'Profile'),
      TectaTab(label: 'Billing'),
    ],
    onTabChanged: (index) {},
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _variant = TabsPlaygroundParser.parseVariant(code, TectaTabsVariant.line);
      _selectedIndex = TabsPlaygroundParser.parseSelectedIndex(code, 0).clamp(0, 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Tabs',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const TabsPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TectaTabs(
          variant: _variant,
          selectedIndex: _selectedIndex,
          tabs: const [
            TectaTab(label: 'Dashboard'),
            TectaTab(label: 'Profile'),
            TectaTab(label: 'Billing'),
          ],
          onTabChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
