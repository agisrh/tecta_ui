import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class IconsShowcasePage extends StatelessWidget {
  const IconsShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Define a list of default Solar Icons to showcase in both Outline (Linear) and Bold styles.
    final outlineIcons = [
      _IconItem('home', SolarLinearIcons.home),
      _IconItem('box', SolarLinearIcons.box),
      _IconItem('delivery', SolarLinearIcons.delivery),
      _IconItem('bell', SolarLinearIcons.bell),
      _IconItem('settings', SolarLinearIcons.settings),
      _IconItem('user', SolarLinearIcons.user),
      _IconItem('mapPoint', SolarLinearIcons.mapPoint),
      _IconItem('bill', SolarLinearIcons.bill),
    ];

    final boldIcons = [
      _IconItem('home', SolarBoldIcons.home),
      _IconItem('box', SolarBoldIcons.box),
      _IconItem('delivery', SolarBoldIcons.delivery),
      _IconItem('bell', SolarBoldIcons.bell),
      _IconItem('settings', SolarBoldIcons.settings),
      _IconItem('user', SolarBoldIcons.user),
      _IconItem('mapPoint', SolarBoldIcons.mapPoint),
      _IconItem('bill', SolarBoldIcons.bill),
    ];

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Icons',
          style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: theme.dividerColor, height: 1.0),
        ),
      ),
      body: ShowcasePageLayout(
        sections: [
          ShowcaseSection(
            title: 'Solar Icons - Outline',
            note: 'Linear solar icons are standard outline representation vector glyphs optimized for secondary action tags, inputs, and regular app navigations.',
            code: '''Icon(
  SolarLinearIcons.home,
  color: TectaColors.secondaryMain,
)''',
            overview: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.05)
                        : TectaColors.primaryLighter.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: theme.brightness == Brightness.dark
                          ? Colors.white.withValues(alpha: 0.1)
                          : TectaColors.primaryLighter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Note:',
                        style: TectaTypography.subtitle2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.brightness == Brightness.dark
                              ? Colors.white
                              : TectaColors.primaryDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'A standardized set of visual symbols designed to clarify meaning, speed up navigation, and provide immediate context for actions or information without relying solely on text. The icons are based on Solar Icon Set from Figma Community:',
                        style: TectaTypography.body2.copyWith(
                          color: theme.brightness == Brightness.dark
                              ? Colors.white60
                              : TectaColors.grey700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'https://www.figma.com/community/file/1396367368966571051',
                        style: TectaTypography.body2.copyWith(
                          color: TectaColors.primaryMain,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildIconsGrid(context, outlineIcons),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Solar Icons - Bold',
            note: 'Bold filled solar icons represent active states, primary selections, or emphasized alerts.',
            code: '''Icon(
  SolarBoldIcons.home,
  color: TectaColors.secondaryMain,
)''',
            overview: _buildIconsGrid(context, boldIcons),
          ),
        ],
      ),
    );
  }

  Widget _buildIconsGrid(BuildContext context, List<_IconItem> items) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        
        int crossAxisCount = 2;
        double childAspectRatio = 1.2;

        if (width > 900) {
          crossAxisCount = 6;
          childAspectRatio = 1.1;
        } else if (width > 600) {
          crossAxisCount = 4;
          childAspectRatio = 1.1;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.iconData, size: 28, color: TectaColors.secondaryMain),
                  const SizedBox(height: 12),
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: (theme.textTheme.labelMedium ?? TectaTypography.subtitle2).copyWith(
                      color: TectaColors.grey800,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _IconItem {
  final String name;
  final IconData iconData;

  const _IconItem(this.name, this.iconData);
}
