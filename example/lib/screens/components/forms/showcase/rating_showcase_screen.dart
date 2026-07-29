import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Rating',
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
            title: 'Read-Only Rating Display',
            note: 'Pass a fixed rating and disable rating callbacks to show feedback or reviews. Supports partial ratings using half stars.',
            code: '''const TectaRating(
  rating: 4.5,
  allowHalfRating: true,
  size: 32,
)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rating: 4.5 Stars',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : TectaColors.grey700,
                  ),
                ),
                const SizedBox(height: 12),
                const TectaRating(
                  rating: 4.5,
                  allowHalfRating: true,
                  size: 32,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Interactive Selection (Full Stars)',
            note: 'Pass a callback to listen to user selections. By default, interactions will step values in full integers.',
            code: '''TectaRating(
  rating: _rating,
  size: 32,
  onRatingChanged: (val) => setState(() => _rating = val),
)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selection: $_rating1 Stars',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : TectaColors.grey700,
                  ),
                ),
                const SizedBox(height: 12),
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
          ShowcaseSection(
            title: 'Interactive Selection (Half Stars & Custom Color)',
            note: 'Set allowHalfRating to true to enable precise mouse hovering selection down to 0.5 decimal steps, and customize star colors.',
            code: '''TectaRating(
  rating: _rating,
  allowHalfRating: true,
  size: 32,
  color: TectaColors.infoMain,
  onRatingChanged: (val) => setState(() => _rating = val),
)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selection: $_rating2 Stars',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : TectaColors.grey700,
                  ),
                ),
                const SizedBox(height: 12),
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
}
