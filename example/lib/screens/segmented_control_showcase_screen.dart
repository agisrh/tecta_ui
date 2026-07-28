import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class SegmentedControlShowcasePage extends StatefulWidget {
  const SegmentedControlShowcasePage({super.key});

  @override
  State<SegmentedControlShowcasePage> createState() => _SegmentedControlShowcasePageState();
}

class _SegmentedControlShowcasePageState extends State<SegmentedControlShowcasePage> {
  int _standardIndex = 0;
  int _iconIndex = 1;
  int _customIndex = 0;
  int _disabledIndex = 0;
  int _badgeIndex = 0;
  int _customSizeIndex = 0;

  Widget _buildBadge(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? TectaColors.primaryMain : TectaColors.grey200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TectaTypography.caption.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : TectaColors.grey600,
        ),
      ),
    );
  }

  final List<TectaSegmentedOption> _standardOptions = const [
    TectaSegmentedOption(label: 'Day'),
    TectaSegmentedOption(label: 'Week'),
    TectaSegmentedOption(label: 'Month'),
  ];

  final List<TectaSegmentedOption> _iconOptions = const [
    TectaSegmentedOption(label: 'List', icon: Icons.format_list_bulleted),
    TectaSegmentedOption(label: 'Grid', icon: Icons.grid_view_rounded),
  ];

  final List<TectaSegmentedOption> _customOptions = const [
    TectaSegmentedOption(label: 'Personal'),
    TectaSegmentedOption(label: 'Work'),
    TectaSegmentedOption(label: 'Shared'),
  ];

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Segmented Control',
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
          _buildSectionHeader('STANDARD SEGMENTED CONTROL'),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TectaSegmentedControl(
                  options: _standardOptions,
                  selectedIndex: _standardIndex,
                  onValueChanged: (index) {
                    setState(() => _standardIndex = index);
                    _showFeedback('Selected Period: ${_standardOptions[index].label}');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          _buildSectionHeader('WITH ICONS'),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TectaSegmentedControl(
                  options: _iconOptions,
                  selectedIndex: _iconIndex,
                  onValueChanged: (index) {
                    setState(() => _iconIndex = index);
                    _showFeedback('Selected View: ${_iconOptions[index].label}');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          _buildSectionHeader('CUSTOM COLOR (PURPLE / ORANGE)'),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TectaSegmentedControl(
                  options: _customOptions,
                  selectedIndex: _customIndex,
                  backgroundColor: Colors.deepPurple.shade50,
                  indicatorColor: Colors.deepPurple,
                  textColor: Colors.deepPurple.shade300,
                  selectedTextColor: Colors.white,
                  onValueChanged: (index) {
                    setState(() => _customIndex = index);
                    _showFeedback('Selected Category: ${_customOptions[index].label}');
                  },
                ),
                const SizedBox(height: 24),
                TectaSegmentedControl(
                  options: _standardOptions,
                  selectedIndex: _standardIndex,
                  backgroundColor: Colors.orange.shade50,
                  indicatorColor: Colors.orange,
                  textColor: Colors.orange.shade300,
                  selectedTextColor: Colors.white,
                  onValueChanged: (index) {
                    setState(() => _standardIndex = index);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          _buildSectionHeader('DISABLED STATE'),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TectaSegmentedControl(
                  options: _standardOptions,
                  selectedIndex: _disabledIndex,
                  isEnabled: false,
                  onValueChanged: (index) {
                    setState(() => _disabledIndex = index);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          _buildSectionHeader('WITH COUNT BADGES'),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TectaSegmentedControl(
                  options: [
                    TectaSegmentedOption(
                      label: 'All',
                      trailing: _buildBadge('10', _badgeIndex == 0),
                    ),
                    TectaSegmentedOption(
                      label: 'Searcheye Ai',
                      trailing: _buildBadge('10', _badgeIndex == 1),
                    ),
                    TectaSegmentedOption(
                      label: 'System',
                      trailing: _buildBadge('4', _badgeIndex == 2),
                    ),
                  ],
                  selectedIndex: _badgeIndex,
                  onValueChanged: (index) {
                    setState(() => _badgeIndex = index);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          _buildSectionHeader('FULLY CUSTOMIZABLE SIZES'),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TectaSegmentedControl(
                  options: _customOptions,
                  selectedIndex: _customSizeIndex,
                  onValueChanged: (index) {
                    setState(() => _customSizeIndex = index);
                  },
                  height: 48.0, // Taller height
                  outerPadding: 6.0, // More spacious outer boundary
                  itemPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  borderRadius: BorderRadius.circular(24.0), // Rounded pill container
                  indicatorBorderRadius: BorderRadius.circular(20.0), // Rounded pill active indicator
                  backgroundColor: TectaColors.primaryMain.withValues(alpha: 0.1),
                  indicatorColor: TectaColors.primaryMain,
                  selectedTextColor: Colors.white,
                  textColor: TectaColors.primaryMain,
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
