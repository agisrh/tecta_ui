import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class AvatarShowcasePage extends StatelessWidget {
  const AvatarShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    const List<String> imageUrls = [
      'https://i.pravatar.cc/150?img=11',
      'https://i.pravatar.cc/150?img=12',
      'https://i.pravatar.cc/150?img=33',
      'https://i.pravatar.cc/150?img=47',
      'https://i.pravatar.cc/150?img=60',
    ];

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Avatar',
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
            title: 'Avatar Types',
            note: 'TectaAvatar supports three types of content representations: Image (Network/Asset), Icon symbols, and fallback Letters.',
            code: '''// Image Avatar
TectaAvatar(image: NetworkImage('url'))

// Icon Avatar
TectaAvatar(icon: Icon(Icons.person))

// Text / Letter Avatar
TectaAvatar(text: 'JD')''',
            overview: Wrap(
              spacing: 16,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TectaAvatar(image: NetworkImage(imageUrls[0])),
                const TectaAvatar(icon: Icon(SolarLinearIcons.folder)),
                const TectaAvatar(text: 'JD'),
                TectaAvatar(
                  backgroundColor: TectaColors.successMain.withValues(alpha: 0.2),
                  textColor: TectaColors.successDarker,
                  text: 'OK',
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Visual Shapes',
            note: 'Avatars can be rendered in three distinct shape variants: circle, rounded corner box, or absolute square.',
            code: '''TectaAvatar(shape: TectaAvatarShape.circle)
TectaAvatar(shape: TectaAvatarShape.rounded)
TectaAvatar(shape: TectaAvatarShape.square)''',
            overview: Row(
              children: [
                const TectaAvatar(
                  shape: TectaAvatarShape.circle,
                  backgroundColor: TectaColors.successMain,
                  textColor: Colors.white,
                  icon: Icon(SolarLinearIcons.user),
                ),
                const SizedBox(width: 16),
                const TectaAvatar(
                  shape: TectaAvatarShape.rounded,
                  backgroundColor: TectaColors.successMain,
                  textColor: Colors.white,
                  icon: Icon(SolarLinearIcons.user),
                ),
                const SizedBox(width: 16),
                const TectaAvatar(
                  shape: TectaAvatarShape.square,
                  backgroundColor: TectaColors.successMain,
                  textColor: Colors.white,
                  icon: Icon(SolarLinearIcons.user),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Grouped Overlaps',
            note: 'Use TectaAvatarGroup to overlap avatars. It includes a built-in max capping counter that groups overflow items automatically.',
            code: '''TectaAvatarGroup(
  max: 3,
  children: [
    TectaAvatar(text: 'A'),
    TectaAvatar(text: 'B'),
    TectaAvatar(text: 'C'),
    TectaAvatar(text: 'D'),
  ],
)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TectaAvatarGroup(
                  max: 3,
                  placeholderBackgroundColor: TectaColors.successLighter,
                  children: const [
                    TectaAvatar(text: 'D'),
                    TectaAvatar(text: 'H'),
                    TectaAvatar(text: 'R'),
                    TectaAvatar(text: 'P'),
                    TectaAvatar(text: 'S'),
                  ],
                ),
                const SizedBox(height: 20),
                TectaAvatarGroup(
                  max: 3,
                  children: imageUrls
                      .map((url) => TectaAvatar(image: NetworkImage(url)))
                      .toList(),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'With Status Badges',
            note: 'Attach decorative online, away, busy, offline indicators, or even nested sub-avatars as notification overlay badges.',
            code: '''TectaAvatar(
  image: NetworkImage('url'),
  badge: TectaAvatarBadge.online(),
)''',
            overview: Wrap(
              spacing: 20,
              runSpacing: 16,
              children: [
                TectaAvatar(
                  image: NetworkImage(imageUrls[0]),
                  badge: TectaAvatar(size: 16, image: NetworkImage(imageUrls[1])),
                ),
                TectaAvatar(
                  image: NetworkImage(imageUrls[1]),
                  badge: TectaAvatarBadge.online(),
                ),
                TectaAvatar(
                  image: NetworkImage(imageUrls[2]),
                  badge: TectaAvatarBadge.away(),
                ),
                TectaAvatar(
                  image: NetworkImage(imageUrls[3]),
                  badge: TectaAvatarBadge.busy(),
                ),
                TectaAvatar(
                  image: NetworkImage(imageUrls[4]),
                  badge: TectaAvatarBadge.offline(),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Sizing scale',
            note: 'Freely override the avatar dimension values. Standard sizes scale dynamically while maintaining icon ratio balance.',
            code: '''TectaAvatar(
  size: 80,
  image: NetworkImage('url'),
)''',
            overview: Wrap(
              spacing: 16,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TectaAvatar(size: 24, image: NetworkImage(imageUrls[0])),
                TectaAvatar(size: 32, image: NetworkImage(imageUrls[1])),
                TectaAvatar(size: 48, image: NetworkImage(imageUrls[2])),
                TectaAvatar(size: 64, image: NetworkImage(imageUrls[3])),
                TectaAvatar(size: 80, image: NetworkImage(imageUrls[4])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
