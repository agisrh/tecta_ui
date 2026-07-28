import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class AvatarShowcasePage extends StatelessWidget {
  const AvatarShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pravatar mock profile photos
    const List<String> imageUrls = [
      'https://i.pravatar.cc/150?img=11',
      'https://i.pravatar.cc/150?img=12',
      'https://i.pravatar.cc/150?img=33',
      'https://i.pravatar.cc/150?img=47',
      'https://i.pravatar.cc/150?img=60',
    ];

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Avatar',
          style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: TectaColors.grey300.withValues(alpha: 0.5), height: 1.0),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          // ===========================================================================
          // TYPES OF AVATARS
          // ===========================================================================
          _buildSectionHeader('IMAGE'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: imageUrls.map((url) => TectaAvatar(image: NetworkImage(url))).toList(),
            ),
          ),

          const SizedBox(height: 32),

          _buildSectionHeader('ICON'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TectaAvatar(icon: Icon(SolarLinearIcons.folder)),
                const TectaAvatar(
                  backgroundColor: TectaColors.grey900,
                  textColor: TectaColors.white,
                  icon: Icon(SolarLinearIcons.folder),
                ),
                const TectaAvatar(
                  backgroundColor: TectaColors.successMain,
                  textColor: TectaColors.white,
                  icon: Icon(SolarLinearIcons.folder),
                ),
                const TectaAvatar(
                  backgroundColor: TectaColors.secondaryMain,
                  textColor: TectaColors.white,
                  icon: Icon(SolarLinearIcons.folder),
                ),
                const TectaAvatar(
                  backgroundColor: TectaColors.infoMain,
                  textColor: TectaColors.white,
                  icon: Icon(SolarLinearIcons.folder),
                ),
                TectaAvatar(
                  backgroundColor: TectaColors.successMain.withValues(alpha: 0.2),
                  textColor: TectaColors.successDarker,
                  icon: const Icon(SolarLinearIcons.folder),
                ),
                const TectaAvatar(
                  backgroundColor: TectaColors.warningMain,
                  textColor: TectaColors.warningDarker,
                  icon: Icon(SolarLinearIcons.folder),
                ),
                const TectaAvatar(
                  backgroundColor: TectaColors.errorMain,
                  textColor: TectaColors.white,
                  icon: Icon(SolarLinearIcons.folder),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          _buildSectionHeader('LETTER'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TectaAvatar(text: 'A'),
                const TectaAvatar(text: 'B'),
                const TectaAvatar(text: 'C'),
                const TectaAvatar(text: 'D'),
                const TectaAvatar(text: 'E'),
                const TectaAvatar(text: 'F'),
                const TectaAvatar(text: 'G'),
                const TectaAvatar(text: 'H'),
                const TectaAvatar(text: '1'),
                const TectaAvatar(text: '@'),
                const TectaAvatar(text: '#'),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // SHAPES / VARIANTS
          // ===========================================================================
          _buildSectionHeader('VARIANT'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 24,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TectaAvatar(
                  shape: TectaAvatarShape.circle,
                  backgroundColor: TectaColors.successMain,
                  textColor: TectaColors.white,
                  icon: Icon(SolarLinearIcons.folder),
                ),
                const TectaAvatar(
                  shape: TectaAvatarShape.rounded,
                  backgroundColor: TectaColors.successMain,
                  textColor: TectaColors.white,
                  icon: Icon(SolarLinearIcons.folder),
                ),
                const TectaAvatar(
                  shape: TectaAvatarShape.square,
                  backgroundColor: TectaColors.successMain,
                  textColor: TectaColors.white,
                  icon: Icon(SolarLinearIcons.folder),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // GROUPED OVERLAPS
          // ===========================================================================
          _buildSectionHeader('GROUPED'),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              children: [
                // Group of letters
                TectaAvatarGroup(
                  max: 3,
                  placeholderBackgroundColor: TectaColors.successLighter,
                  children: const [
                    TectaAvatar(text: 'D'),
                    TectaAvatar(text: 'H'),
                    TectaAvatar(text: 'R'),
                    TectaAvatar(text: 'P'),
                    TectaAvatar(text: 'S'),
                    TectaAvatar(text: 'K'),
                    TectaAvatar(text: 'N'),
                    TectaAvatar(text: 'Z'),
                  ],
                ),
                const SizedBox(height: 24),
                // Capped group of network images
                TectaAvatarGroup(
                  max: 3,
                  children: imageUrls
                      .map((url) => TectaAvatar(image: NetworkImage(url)))
                      .toList(),
                ),
                const SizedBox(height: 24),
                // Non-capped group of images
                TectaAvatarGroup(
                  children: imageUrls
                      .map((url) => TectaAvatar(image: NetworkImage(url)))
                      .toList(),
                ),
                const SizedBox(height: 24),
                // Giant sizes group
                TectaAvatarGroup(
                  size: 60,
                  max: 4,
                  children: imageUrls
                      .map((url) => TectaAvatar(image: NetworkImage(url)))
                      .toList(),
                ),
                const SizedBox(height: 24),
                // Stack of custom shapes
                TectaAvatarGroup(
                  size: 40,
                  shape: TectaAvatarShape.rounded,
                  max: 3,
                  children: imageUrls
                      .map((url) => TectaAvatar(image: NetworkImage(url)))
                      .toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // WITH BADGES
          // ===========================================================================
          _buildSectionHeader('WITH BADGE'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 20,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Nested double-avatar badge
                TectaAvatar(
                  image: NetworkImage(imageUrls[0]),
                  badge: TectaAvatar(size: 16, image: NetworkImage(imageUrls[1])),
                ),
                // Online badge
                TectaAvatar(
                  image: NetworkImage(imageUrls[1]),
                  badge: TectaAvatarBadge.online(),
                ),
                // Away badge
                TectaAvatar(image: NetworkImage(imageUrls[2]), badge: TectaAvatarBadge.away()),
                // Busy badge
                TectaAvatar(image: NetworkImage(imageUrls[3]), badge: TectaAvatarBadge.busy()),
                // Offline badge
                TectaAvatar(
                  image: NetworkImage(imageUrls[4]),
                  badge: TectaAvatarBadge.offline(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // SIZES SCALE
          // ===========================================================================
          _buildSectionHeader('SIZES'),
          const SizedBox(height: 16),
          _buildCard(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TectaAvatar(size: 24, image: NetworkImage(imageUrls[0])),
                TectaAvatar(size: 32, image: NetworkImage(imageUrls[1])),
                TectaAvatar(size: 40, image: NetworkImage(imageUrls[2])),
                TectaAvatar(size: 48, image: NetworkImage(imageUrls[3])),
                TectaAvatar(size: 56, image: NetworkImage(imageUrls[4])),
                TectaAvatar(size: 64, image: NetworkImage(imageUrls[0])),
                TectaAvatar(size: 80, image: NetworkImage(imageUrls[1])),
                TectaAvatar(size: 120, image: NetworkImage(imageUrls[2])),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
      decoration: BoxDecoration(
        color: TectaColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: child,
    );
  }
}
