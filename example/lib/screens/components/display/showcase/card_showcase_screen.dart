import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class CardShowcasePage extends StatelessWidget {
  const CardShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Card',
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
            title: 'Interactive Card (Hover Lift)',
            note: 'TectaCard features automatic smooth translation and drop-shadow elevations when hovered over. Supports header, media, content, and action widgets.',
            code: '''TectaCard(
  onTap: () => handleTap(),
  header: ListTile(...),
  media: Image.network(...),
  content: Text(...),
  actions: [IconButton(...)],
)''',
            overview: SizedBox(
              width: 480,
              child: TectaCard(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Card tapped!')),
                  );
                },
                header: ListTile(
                  leading: const TectaAvatar(text: 'JC'),
                  title: Text('Jaydon Carter', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : TectaColors.grey800)),
                  subtitle: Text('2 hours ago', style: TextStyle(color: isDark ? Colors.white54 : TectaColors.grey500)),
                  trailing: Icon(Icons.more_vert_rounded, color: isDark ? Colors.white54 : TectaColors.grey500),
                ),
                media: Image.network(
                  'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=600&auto=format&fit=crop&q=60',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: TectaColors.grey300,
                      alignment: Alignment.center,
                      child: const Icon(Icons.image, size: 40, color: TectaColors.grey500),
                    );
                  },
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unsplash Abstract Background',
                      style: TectaTypography.subtitle1.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : TectaColors.grey800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hover over this card to see it lift slightly with an animated offset translate and a deeper shadow cast.',
                      style: TectaTypography.body2.copyWith(color: isDark ? Colors.white60 : TectaColors.grey600),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border_rounded, color: TectaColors.errorMain),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_outlined, color: TectaColors.primaryMain),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Outlined Flat Card',
            note: 'Disable the hover lifting animation effects and set custom border colors to achieve a flat outlined look.',
            code: '''TectaCard(
  borderColor: TectaColors.grey300,
  enableHoverEffect: false,
  content: Text('Flat outline design'),
)''',
            overview: SizedBox(
              width: 480,
              child: TectaCard(
                borderColor: isDark ? Colors.white.withValues(alpha: 0.1) : TectaColors.grey300,
                enableHoverEffect: false,
                padding: const EdgeInsets.all(20.0),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Flat Outline Style',
                      style: TectaTypography.subtitle2.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : TectaColors.grey800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'This card utilizes flat outlines with borders and disables the hover-lifting animations.',
                      style: TectaTypography.body2.copyWith(color: isDark ? Colors.white60 : TectaColors.grey600),
                    ),
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
