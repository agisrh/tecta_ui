import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'button_playground_parser.dart';
import 'button_playground_docs.dart';

class ButtonPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const ButtonPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<ButtonPlayground> createState() => _ButtonPlaygroundState();
}

class _ButtonPlaygroundState extends State<ButtonPlayground> {
  String _btnLabel = 'Get started';
  TectaButtonVariant _btnVariant = TectaButtonVariant.contained;
  TectaButtonSize _btnSize = TectaButtonSize.medium;
  bool _btnLoading = false;
  bool _btnHasIcon = false;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';

Widget build(BuildContext context) {
  return TectaButton(
    label: 'Get started',
    variant: TectaButtonVariant.contained,
    size: TectaButtonSize.medium,
    loading: false,
    hasIcon: false,
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _btnVariant = ButtonPlaygroundParser.parseVariant(code, TectaButtonVariant.contained);
      _btnSize = ButtonPlaygroundParser.parseSize(code, TectaButtonSize.medium);
      _btnLoading = ButtonPlaygroundParser.parseLoading(code, false);
      _btnHasIcon = ButtonPlaygroundParser.parseHasIcon(code, false);
      _btnLabel = ButtonPlaygroundParser.parseLabel(code, 'Get started');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Button',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const ButtonPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: TectaButton(
        label: _btnLabel,
        variant: _btnVariant,
        size: _btnSize,
        loading: _btnLoading,
        color: TectaColors.primaryMain,
        icon: _btnHasIcon ? const Icon(SolarLinearIcons.letter) : null,
        onPressed: () {},
      ),
    );
  }
}
