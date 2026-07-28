import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class ChipShowcasePage extends StatefulWidget {
  const ChipShowcasePage({super.key});

  @override
  State<ChipShowcasePage> createState() => _ChipShowcasePageState();
}

class _ChipShowcasePageState extends State<ChipShowcasePage> {
  // Click handlers to show action feedback
  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
          title: Text(
            'Chip',
            style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: TectaColors.grey200,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TabBar(
                  labelColor: TectaColors.grey900,
                  unselectedLabelColor: TectaColors.grey500,
                  labelStyle: TectaTypography.subtitle2.copyWith(fontWeight: FontWeight.w600),
                  unselectedLabelStyle: TectaTypography.subtitle2.copyWith(fontWeight: FontWeight.w500),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: TectaColors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: TectaShadows.z1,
                  ),
                  tabs: const [
                    Tab(text: 'Filled'),
                    Tab(text: 'Outlined'),
                    Tab(text: 'Soft'),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: TectaColors.grey100,
        body: TabBarView(
          children: [
            _buildVariantTab(TectaChipVariant.filled),
            _buildVariantTab(TectaChipVariant.outlined),
            _buildVariantTab(TectaChipVariant.soft),
          ],
        ),
      ),
    );
  }

  static final List<Color?> _showcaseColors = [
    null,
    TectaColors.primaryMain,
    TectaColors.secondaryMain,
    TectaColors.infoMain,
    TectaColors.successMain,
    TectaColors.warningMain,
    TectaColors.errorMain,
    TectaColors.grey900,
    Colors.purple,
    Colors.teal,
  ];

  String _getColorName(Color? color) {
    if (color == null) return 'Default';
    if (color == TectaColors.primaryMain) return 'Primary';
    if (color == TectaColors.secondaryMain) return 'Secondary';
    if (color == TectaColors.infoMain) return 'Info';
    if (color == TectaColors.successMain) return 'Success';
    if (color == TectaColors.warningMain) return 'Warning';
    if (color == TectaColors.errorMain) return 'Error';
    if (color == TectaColors.grey900) return 'Dark';
    if (color == Colors.purple) return 'Purple';
    if (color == Colors.teal) return 'Teal';
    return 'Custom';
  }

  Widget _buildVariantTab(TectaChipVariant variant) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      children: [
        // Colors Section
        _buildSectionHeader('COLORS'),
        const SizedBox(height: 16),
        _buildCard(
          labelText: 'Colors',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Clickable Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _showcaseColors.map((color) {
                    final name = _getColorName(color);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TectaChip(
                        label: 'Clickable',
                        color: color,
                        variant: variant,
                        avatar: const TectaAvatar(text: 'M'),
                        onTap: () => _showFeedback('Clicked $name chip'),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 16),
              // Deletable Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _showcaseColors.map((color) {
                    final name = _getColorName(color);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TectaChip(
                        label: 'Deletable',
                        color: color,
                        variant: variant,
                        avatar: const TectaAvatar(text: 'M'),
                        onDelete: () => _showFeedback('Deleted $name chip'),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Custom Icons Section
        _buildSectionHeader('CUSTOM ICONS'),
        const SizedBox(height: 16),
        _buildCard(
          labelText: 'Custom icons',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              TectaChip(
                label: 'Custom icon',
                variant: variant,
                color: null,
                icon: const Icon(Icons.mood),
                onDelete: () => _showFeedback('Deleted custom icon chip'),
                deleteIcon: const Icon(Icons.check, size: 16),
              ),
              TectaChip(
                label: 'Custom icon',
                variant: variant,
                color: TectaColors.infoMain,
                avatar: const TectaAvatar(text: 'M'),
                onDelete: () => _showFeedback('Deleted custom icon chip'),
                deleteIcon: const Icon(
                  SolarBoldIcons.trashBin,
                  size: 16,
                  color: TectaColors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Disabled Section
        _buildSectionHeader('DISABLED'),
        const SizedBox(height: 16),
        _buildCard(
          labelText: 'Disabled',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              TectaChip(
                label: 'Disabled',
                variant: variant,
                isEnabled: false,
                icon: const Icon(Icons.mood),
                onDelete: () {},
              ),
              TectaChip(
                label: 'Disabled',
                variant: variant,
                isEnabled: false,
                avatar: const TectaAvatar(image: NetworkImage('https://i.pravatar.cc/100')),
                onDelete: () {},
              ),
              TectaChip(
                label: 'Disabled',
                variant: variant,
                isEnabled: false,
                avatar: const TectaAvatar(text: 'M'),
                onDelete: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Sizes Section
        _buildSectionHeader('SIZES'),
        const SizedBox(height: 16),
        _buildCard(
          labelText: 'Sizes',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TectaChip(
                label: 'Small',
                variant: variant,
                color: TectaColors.infoMain,
                size: TectaChipSize.small,
                avatar: const TectaAvatar(text: 'M'),
                onDelete: () => _showFeedback('Deleted small chip'),
              ),
              TectaChip(
                label: 'Medium',
                variant: variant,
                color: TectaColors.infoMain,
                size: TectaChipSize.medium,
                icon: const Icon(Icons.mood),
                onDelete: () => _showFeedback('Deleted medium chip'),
              ),
            ],
          ),
        ),
      ],
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

  Widget _buildSubLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
      decoration: BoxDecoration(
        color: TectaColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: Text(
        text,
        style: TectaTypography.subtitle2.copyWith(
          color: TectaColors.grey800,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child, String? labelText}) {
    final cardContent = Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 32.0, bottom: 24.0),
      decoration: BoxDecoration(
        color: TectaColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: child,
    );

    if (labelText == null) return cardContent;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        cardContent,
        Positioned(top: -16, left: 24, child: _buildSubLabel(labelText)),
      ],
    );
  }
}
