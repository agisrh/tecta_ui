import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class SkeletonShowcasePage extends StatelessWidget {
  const SkeletonShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Skeleton',
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
            title: 'Individual Placeholders',
            note: 'TectaSkeleton provides a premium shimmering layout mockup indicator to mock circles, lines, or specific boundary frames.',
            code: '''// Circle
TectaSkeleton(
  width: 48,
  height: 48,
  shape: BoxShape.circle,
)

// Line / Block
TectaSkeleton(width: 200, height: 16)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Circle / Avatar Mock:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : TectaColors.grey600),
                ),
                const SizedBox(height: 8),
                const TectaSkeleton(
                  width: 48,
                  height: 48,
                  shape: BoxShape.circle,
                ),
                const SizedBox(height: 24),
                Text(
                  'Text / Content Mock:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : TectaColors.grey600),
                ),
                const SizedBox(height: 8),
                const TectaSkeleton(width: double.infinity, height: 16),
                const SizedBox(height: 8),
                const TectaSkeleton(width: 240, height: 16),
                const SizedBox(height: 8),
                const TectaSkeleton(width: 140, height: 16),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Structural Content Mock (Card Loading)',
            note: 'Compose multiple individual skeleton elements inside layout structures (such as Cards or Lists) to simulate actual data loading templates.',
            code: '''Card(
  child: Column(
    children: [
      Row(
        children: [
          TectaSkeleton(width: 40, height: 40, shape: BoxShape.circle),
          TectaSkeleton(width: 120, height: 12),
        ],
      ),
      TectaSkeleton(width: double.infinity, height: 120),
    ],
  ),
)''',
            overview: TectaCard(
              header: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
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
                        TectaSkeleton(width: 120, height: 12),
                        SizedBox(height: 6),
                        TectaSkeleton(width: 80, height: 10),
                      ],
                    ),
                  ],
                ),
              ),
              content: const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TectaSkeleton(
                      width: double.infinity,
                      height: 140,
                    ),
                    SizedBox(height: 16),
                    TectaSkeleton(width: double.infinity, height: 12),
                    SizedBox(height: 8),
                    TectaSkeleton(width: 180, height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
