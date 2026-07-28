import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class SkeletonShowcasePage extends StatelessWidget {
  const SkeletonShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Skeleton',
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
          // SKELETON TYPES
          // ---------------------------------------------------------
          _buildSectionHeader('Individual Placeholders'),
          const SizedBox(height: 12),
          _buildCard(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Circle Shape (Avatar Mock)', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                TectaSkeleton(
                  width: 48,
                  height: 48,
                  shape: BoxShape.circle,
                ),
                SizedBox(height: 24),
                Text('Rectangle Shapes (Text Mocks)', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                TectaSkeleton(width: double.infinity, height: 16),
                SizedBox(height: 8),
                TectaSkeleton(width: 200, height: 16),
                SizedBox(height: 8),
                TectaSkeleton(width: 120, height: 16),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ---------------------------------------------------------
          // SKELETON COMPLEX CARD
          // ---------------------------------------------------------
          _buildSectionHeader('Structural Content Loader (Card Mock)'),
          const SizedBox(height: 12),
          Material(
            color: TectaColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: const BorderSide(color: TectaColors.grey200),
            ),
            child: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    children: [
                      TectaSkeleton(
                        width: 40,
                        height: 40,
                        shape: BoxShape.circle,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TectaSkeleton(width: 120, height: 14),
                          SizedBox(height: 6),
                          TectaSkeleton(width: 80, height: 10),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Media Body
                  TectaSkeleton(
                    width: double.infinity,
                    height: 160,
                  ),
                  SizedBox(height: 20),

                  // Footer Text
                  TectaSkeleton(width: double.infinity, height: 12),
                  SizedBox(height: 8),
                  TectaSkeleton(width: 150, height: 12),
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
    return Material(
      color: TectaColors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: TectaColors.grey200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
