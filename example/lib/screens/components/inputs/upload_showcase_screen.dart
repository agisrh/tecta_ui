import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

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
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Upload',
          style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: TectaColors.grey100,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          // ---------------------------------------------------------
          // BOX / DRAG & DROP MULTI-FILE UPLOAD
          // ---------------------------------------------------------
          _buildSectionHeader('Multi File Upload'),
          const SizedBox(height: 12),
          TectaUploadBox(
            onTap: () => _showSimulatedPicker('TectaUploadBox'),
          ),
          const SizedBox(height: 36),

          // ---------------------------------------------------------
          // AVATAR UPLOAD
          // ---------------------------------------------------------
          _buildSectionHeader('Upload Avatar'),
          const SizedBox(height: 12),
          _buildCard(
            child: Center(
              child: Column(
                children: [
                  TectaUploadAvatar(
                    image: _selectedAvatar,
                    onTap: () {
                      _showSimulatedPicker('TectaUploadAvatar');
                      // Simulate selecting an image by showing a fallback network image or mock
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        title,
        style: TectaTypography.overline.copyWith(
          color: TectaColors.grey500,
          fontSize: 12,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
      decoration: BoxDecoration(
        color: TectaColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: child,
    );
  }
}
