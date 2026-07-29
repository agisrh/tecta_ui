import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'bottom_sheet_playground_parser.dart';
import 'bottom_sheet_playground_docs.dart';

class BottomSheetPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const BottomSheetPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<BottomSheetPlayground> createState() => _BottomSheetPlaygroundState();
}

class _BottomSheetPlaygroundState extends State<BottomSheetPlayground> {
  String _titleText = 'Select Option';

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaButton(
    label: 'Open Bottom Sheet',
    onPressed: () {
      showTectaBottomSheet(
        context,
        child: TectaBottomSheet(
          title: 'Select Option',
          showHandle: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: Text('Share Link')),
              ListTile(title: Text('Get QR Code')),
            ],
          ),
        ),
      );
    },
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _titleText = BottomSheetPlaygroundParser.parseTitle(code, 'Select Option');
    });
  }

  void _showBottomSheet() {
    showTectaBottomSheet(
      context,
      child: TectaBottomSheet(
        title: _titleText,
        showHandle: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Link'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Get QR Code'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'BottomSheet',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const BottomSheetPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Center(
        child: TectaButton(
          label: 'Open Bottom Sheet',
          color: TectaColors.primaryMain,
          onPressed: _showBottomSheet,
        ),
      ),
    );
  }
}
