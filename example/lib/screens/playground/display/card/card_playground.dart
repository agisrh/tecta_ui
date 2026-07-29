import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'card_playground_parser.dart';
import 'card_playground_docs.dart';

class CardPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const CardPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<CardPlayground> createState() => _CardPlaygroundState();
}

class _CardPlaygroundState extends State<CardPlayground> {
  String _cardTitle = 'Welcome';
  String _cardContent = 'Try out components in the code editor, open a ready-made template, and build your own theme in the theme editor — all in one place.';
  String _cardButtonLabel = 'Get started';
  bool _cardHasDivider = true;
  double _cardPadding = 24.0;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaCard(
    padding: const EdgeInsets.all(24),
    header: Text(
      'Welcome',
      style: TectaTypography.h5,
    ),
    content: Text(
      'Try out components in the code editor, open a ready-made template, and build your own theme in the theme editor — all in one place.',
    ),
    actions: [
      TectaButton(
        label: 'Get started',
        variant: TectaButtonVariant.contained,
        onPressed: () {},
      ),
    ],
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _cardPadding = CardPlaygroundParser.parsePadding(code, 24.0);
      _cardHasDivider = CardPlaygroundParser.parseHasDivider(code);
      _cardTitle = CardPlaygroundParser.parseTitle(code, 'Welcome');
      _cardContent = CardPlaygroundParser.parseContent(code, '');
      _cardButtonLabel = CardPlaygroundParser.parseButtonLabel(code, 'Get started');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Card',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const CardPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: SizedBox(
        width: 400.0,
        child: TectaCard(
          header: Padding(
            padding: EdgeInsets.fromLTRB(
                _cardPadding,
                _cardPadding,
                _cardPadding,
                _cardHasDivider ? 16 : _cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _cardTitle,
                  style: TectaTypography.h5.copyWith(fontWeight: FontWeight.bold),
                ),
                if (_cardHasDivider) ...[
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                ],
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: _cardPadding, vertical: _cardPadding / 2),
          content: Text(
            _cardContent,
            style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(_cardPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TectaButton(
                    label: _cardButtonLabel,
                    variant: TectaButtonVariant.contained,
                    color: TectaColors.primaryMain,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
