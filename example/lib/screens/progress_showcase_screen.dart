import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class ProgressShowcasePage extends StatelessWidget {
  const ProgressShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final googleColors = [
      TectaColors.infoMain,
      TectaColors.errorMain,
      TectaColors.warningMain,
      TectaColors.successMain,
    ];

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Progress',
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
          // GOOGLE MULTI-COLOR PROGRESS (NEW)
          // ---------------------------------------------------------
          _buildSectionHeader('Google Multi-Color Spinners (Cycles Colors)'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Smooth Multi-Color Transitions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    TectaCircularProgress(size: 40, strokeWidth: 4, colors: googleColors),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Google-style rotating linear track:',
                            style: TextStyle(fontSize: 12, color: TectaColors.grey500),
                          ),
                          const SizedBox(height: 8),
                          TectaLinearProgress(height: 6, colors: googleColors),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ---------------------------------------------------------
          // CIRCULAR PROGRESS
          // ---------------------------------------------------------
          _buildSectionHeader('Circular Indicators'),
          const SizedBox(height: 12),
          _buildCard(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Indeterminate Spinners', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Row(
                  children: [
                    TectaCircularProgress(size: 24, strokeWidth: 3),
                    SizedBox(width: 24),
                    TectaCircularProgress(
                      size: 40,
                      strokeWidth: 4,
                      color: TectaColors.infoMain,
                    ),
                    SizedBox(width: 24),
                    TectaCircularProgress(
                      size: 56,
                      strokeWidth: 5,
                      color: TectaColors.successMain,
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text('Determinate Spinner (75%)', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                TectaCircularProgress(
                  value: 0.75,
                  size: 44,
                  strokeWidth: 4.5,
                  color: TectaColors.warningMain,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ---------------------------------------------------------
          // LINEAR PROGRESS
          // ---------------------------------------------------------
          _buildSectionHeader('Linear Indicators'),
          const SizedBox(height: 12),
          _buildCard(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Indeterminate Tracks', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                TectaLinearProgress(),
                SizedBox(height: 12),
                TectaLinearProgress(color: TectaColors.infoMain, height: 4),
                SizedBox(height: 24),
                Text('Determinate Tracks', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text(
                  'Download Progress: 40%',
                  style: TextStyle(fontSize: 12, color: TectaColors.grey500),
                ),
                SizedBox(height: 6),
                TectaLinearProgress(value: 0.40, color: TectaColors.successMain),
                SizedBox(height: 16),
                Text(
                  'Upload Progress: 90%',
                  style: TextStyle(fontSize: 12, color: TectaColors.grey500),
                ),
                SizedBox(height: 6),
                TectaLinearProgress(value: 0.90, color: TectaColors.errorMain, height: 8),
              ],
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
    return Material(
      color: TectaColors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: TectaColors.grey200),
      ),
      child: Padding(padding: const EdgeInsets.all(20.0), child: child),
    );
  }
}
