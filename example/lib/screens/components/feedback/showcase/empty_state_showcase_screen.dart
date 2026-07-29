import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class EmptyStateShowcasePage extends StatelessWidget {
  const EmptyStateShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Empty State',
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
            title: 'Search Not Found',
            note: 'TectaEmptyState provides a ready-made placeholder layout when database queries, filters, or search items yield no results.',
            code: '''TectaEmptyState(
  title: 'No Results Found',
  description: 'Try checking spelling or keywords.',
  iconData: Icons.search_off_rounded,
)''',
            overview: const TectaEmptyState(
              title: 'No Results Found',
              description: 'We couldn\'t find any records matching your search queries. Try checking spelling or using different keywords.',
              iconData: Icons.search_off_rounded,
            ),
          ),
          ShowcaseSection(
            title: 'Connection Error with Action CTA',
            note: 'Easily append actions or buttons inside the bottom slot of the placeholder layout to prompt user recovery.',
            code: '''TectaEmptyState(
  title: 'Connection Lost',
  iconData: Icons.wifi_off_rounded,
  action: TectaButton(
    label: 'Try Again',
    onPressed: () {},
  ),
)''',
            overview: TectaEmptyState(
              title: 'Connection Lost',
              description: 'Unable to connect to the cloud database. Please verify your internet connection settings and try again.',
              iconData: Icons.wifi_off_rounded,
              action: TectaButton(
                label: 'Try Again',
                color: TectaColors.primaryMain,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Retrying connection...')),
                  );
                },
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Customized Empty State Styling',
            note: 'Override backgrounds, typography styles, icon sizing, colors, and internal padding structures freely.',
            code: '''TectaEmptyState(
  title: 'Customized UI',
  iconColor: Colors.amber,
  iconSize: 72.0,
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [...]),
  ),
)''',
            overview: TectaEmptyState(
              title: 'Premium Customized UI',
              description: 'This empty state has a custom gradient background, custom text styling, custom icon size & color, and different layout constraints.',
              iconData: Icons.star_rounded,
              iconColor: Colors.amber,
              iconSize: 72.0,
              spacing: 12.0,
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    TectaColors.primaryLighter.withValues(alpha: 0.15),
                    TectaColors.secondaryLighter.withValues(alpha: 0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              titleStyle: TectaTypography.h5.copyWith(
                color: isDark ? Colors.white : TectaColors.primaryDark,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
              descriptionStyle: TectaTypography.body1.copyWith(
                color: isDark ? Colors.white60 : TectaColors.grey700,
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
}
