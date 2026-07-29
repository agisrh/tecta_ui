import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class UploadShowcasePage extends StatefulWidget {
  const UploadShowcasePage({super.key});

  @override
  State<UploadShowcasePage> createState() => _UploadShowcasePageState();
}

class _UploadShowcasePageState extends State<UploadShowcasePage> {
  ImageProvider? _selectedAvatar;

  void _showSimulatedPicker(String widgetName) {
    TectaSnackbar.show(
      context,
      message: 'Simulated file picker triggered for $widgetName!',
      variant: TectaSnackbarVariant.info,
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Upload',
                style: TectaTypography.h4.copyWith(
                  color: isDark ? Colors.white : TectaColors.grey800,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: theme.dividerColor,
                  height: 1.0,
                ),
              ),
            ),
      body: ShowcasePageLayout(
        sections: [
          ShowcaseSection(
            title: 'Dropzone Box Upload',
            note: 'TectaUploadBox provides a dashed dropzone boundary layout with interactive hover/click triggers designed for multi-file attachments.',
            code: '''TectaUploadBox(
  onTap: () => triggerFilePicker(),
)''',
            overview: TectaUploadBox(
              onTap: () => _showSimulatedPicker('TectaUploadBox'),
            ),
          ),
          ShowcaseSection(
            title: 'Avatar Upload Picker',
            note: 'Upload avatar widget designed for profile configuration layouts. Supports inline previews, action hover rings, and easy reset states.',
            code: '''TectaUploadAvatar(
  image: _selectedAvatar,
  onTap: () {
    setState(() {
      _selectedAvatar = NetworkImage('url');
    });
  },
)''',
            overview: Center(
              child: Column(
                children: [
                  TectaUploadAvatar(
                    image: _selectedAvatar,
                    onTap: () {
                      _showSimulatedPicker('TectaUploadAvatar');
                      setState(() {
                        _selectedAvatar = const NetworkImage(
                          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
                        );
                      });
                    },
                  ),
                  if (_selectedAvatar != null) ...[
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedAvatar = null;
                        });
                      },
                      child: Text(
                        'Reset Avatar',
                        style: TectaTypography.caption.copyWith(
                          color: TectaColors.errorMain,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
