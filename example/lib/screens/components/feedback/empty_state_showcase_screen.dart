import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class EmptyStateShowcasePage extends StatelessWidget {
  const EmptyStateShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Empty State',
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
          // SEARCH NOT FOUND
          // ---------------------------------------------------------
          _buildSectionHeader('Search Not Found'),
          const SizedBox(height: 12),
          _buildCard(
            child: const TectaEmptyState(
              title: 'No Results Found',
              description: 'We couldn\'t find any records matching your search queries. Try checking spelling or using different keywords.',
              iconData: Icons.search_off_rounded,
            ),
          ),
          const SizedBox(height: 24),

          // ---------------------------------------------------------
          // CONNECTION ERROR WITH RETRY
          // ---------------------------------------------------------
          _buildSectionHeader('Connection Error with Action CTA'),
          const SizedBox(height: 12),
          _buildCard(
            child: TectaEmptyState(
              title: 'Connection Lost',
              description: 'Unable to connect to the cloud database. Please verify your internet connection settings and try again.',
              iconData: Icons.wifi_off_rounded,
              action: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TectaColors.primaryMain,
                  foregroundColor: TectaColors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Retrying connection...')),
                  );
                },
                child: const Text('Try Again', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ---------------------------------------------------------
          // FULLY CUSTOMIZED EMPTY STATE
          // ---------------------------------------------------------
          _buildSectionHeader('Fully Customized Empty State'),
          const SizedBox(height: 12),
          _buildCard(
            child: TectaEmptyState(
              title: 'Premium Customized UI',
              description: 'This empty state has a custom gradient background, custom text styling, custom icon size & color, and different layout constraints.',
              iconData: Icons.star_rounded,
              iconColor: Colors.amber,
              iconSize: 84.0,
              spacing: 12.0,
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    TectaColors.primaryLighter.withValues(alpha: 0.3),
                    TectaColors.secondaryLighter.withValues(alpha: 0.3),
                  ],
                ),
              ),
              titleStyle: TectaTypography.h5.copyWith(
                color: TectaColors.primaryDark,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
              descriptionStyle: TectaTypography.body1.copyWith(
                color: TectaColors.grey700,
                fontStyle: FontStyle.italic,
              ),
              action: TectaButton(
                label: 'Action Button',
                color: TectaColors.primaryMain,
                onPressed: () {},
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
      child: child,
    );
  }
}
