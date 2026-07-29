import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'dropdown_menu_playground_parser.dart';
import 'dropdown_menu_playground_docs.dart';

class DropdownMenuPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const DropdownMenuPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<DropdownMenuPlayground> createState() => _DropdownMenuPlaygroundState();
}

class _DropdownMenuPlaygroundState extends State<DropdownMenuPlayground> {
  String _triggerLabelText = 'Click Options';

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaDropdownMenu(
    onItemSelected: (index) {},
    items: [
      TectaDropdownItem(label: 'Edit Profile'),
      TectaDropdownItem(label: 'Account Settings'),
      TectaDropdownItem.divider(),
      TectaDropdownItem(label: 'Logout'),
    ],
    child: TectaButton(
      label: 'Click Options',
      onPressed: () {},
    ),
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _triggerLabelText = DropdownMenuPlaygroundParser.parseTriggerLabel(code, 'Click Options');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'DropdownMenu',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const DropdownMenuPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Center(
        child: TectaDropdownMenu(
          onItemSelected: (index) {},
          items: const [
            TectaDropdownItem(
              label: 'Edit Profile',
              icon: Icons.person_outline_rounded,
            ),
            TectaDropdownItem(
              label: 'Account Settings',
              icon: Icons.settings_outlined,
            ),
            TectaDropdownItem(isDivider: true),
            TectaDropdownItem(
              label: 'Logout',
              icon: Icons.logout_rounded,
              isDestructive: true,
            ),
          ],
          child: TectaButton(
            label: _triggerLabelText,
            color: TectaColors.primaryMain,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
