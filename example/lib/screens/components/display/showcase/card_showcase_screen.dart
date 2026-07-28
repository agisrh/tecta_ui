import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class CardShowcasePage extends StatelessWidget {
  const CardShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Card',
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
          _buildSectionHeader('Interactive Card (Hover Lift Effect)'),
          const SizedBox(height: 12),
          TectaCard(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Card tapped!')),
              );
            },
            header: const ListTile(
              leading: TectaAvatar(text: 'Jaydon Carter'),
              title: Text('Jaydon Carter', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('2 hours ago'),
              trailing: Icon(Icons.more_vert),
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
                    color: TectaColors.grey800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hover over this card to see it lift slightly with an animated offset translate and a deeper shadow cast.',
                  style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: TectaColors.errorMain),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, color: TectaColors.primaryMain),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 32),

          _buildSectionHeader('Outlined Card (No Shadow)'),
          const SizedBox(height: 12),
          TectaCard(
            borderColor: TectaColors.grey300,
            enableHoverEffect: false,
            padding: const EdgeInsets.all(20.0),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flat Outline Style',
                  style: TectaTypography.subtitle2.copyWith(
                    fontWeight: FontWeight.w700,
                    color: TectaColors.grey800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'This card utilizes flat outlines with borders and disables the hover-lifting animations.',
                  style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
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
}
