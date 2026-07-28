import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class RatingShowcasePage extends StatefulWidget {
  const RatingShowcasePage({super.key});

  @override
  State<RatingShowcasePage> createState() => _RatingShowcasePageState();
}

class _RatingShowcasePageState extends State<RatingShowcasePage> {
  double _rating1 = 3.0;
  double _rating2 = 4.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Rating',
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
          // READ-ONLY RATING
          // ---------------------------------------------------------
          _buildSectionHeader('Read-Only Display (Half Star Enabled)'),
          const SizedBox(height: 12),
          _buildCard(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rating: 4.5 Stars', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                TectaRating(
                  rating: 4.5,
                  allowHalfRating: true,
                  size: 32,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ---------------------------------------------------------
          // INTERACTIVE FULL STAR
          // ---------------------------------------------------------
          _buildSectionHeader('Interactive Selection (Full Stars Only)'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rating Selection: $_rating1 Stars', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TectaRating(
                  rating: _rating1,
                  size: 32,
                  onRatingChanged: (val) {
                    setState(() {
                      _rating1 = val;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ---------------------------------------------------------
          // INTERACTIVE HALF STAR
          // ---------------------------------------------------------
          _buildSectionHeader('Interactive Selection (Half Stars Allowed)'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rating Selection: $_rating2 Stars', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TectaRating(
                  rating: _rating2,
                  allowHalfRating: true,
                  size: 32,
                  color: TectaColors.infoMain,
                  onRatingChanged: (val) {
                    setState(() {
                      _rating2 = val;
                    });
                  },
                ),
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
