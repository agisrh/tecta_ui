import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Segmented Control',
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
            title: 'Standard Segmented Control',
            note: 'A clean tab switch replacement that lets users choose between options dynamically. TectaSegmentedControl includes premium sliding layouts.',
            code: '''TectaSegmentedControl(
  options: const [
    TectaSegmentedOption(label: 'Day'),
    TectaSegmentedOption(label: 'Week'),
    TectaSegmentedOption(label: 'Month'),
  ],
  selectedIndex: _standardIndex,
  onValueChanged: (index) => setState(() => _standardIndex = index),
)''',
            overview: SizedBox(
              width: 320,
              child: TectaSegmentedControl(
                options: _standardOptions,
                selectedIndex: _standardIndex,
                onValueChanged: (index) {
                  setState(() => _standardIndex = index);
                  _showFeedback('Selected Period: ${_standardOptions[index].label}');
                },
              ),
            ),
          ),
          ShowcaseSection(
            title: 'With Icons',
            note: 'Add icons to clarify options or create pure icon switches with modern indicators.',
            code: '''TectaSegmentedControl(
  options: const [
    TectaSegmentedOption(label: 'List', icon: Icons.format_list_bulleted),
    TectaSegmentedOption(label: 'Grid', icon: Icons.grid_view_rounded),
  ],
  selectedIndex: _iconIndex,
  onValueChanged: (index) => setState(() => _iconIndex = index),
)''',
            overview: SizedBox(
              width: 240,
              child: TectaSegmentedControl(
                options: _iconOptions,
                selectedIndex: _iconIndex,
                onValueChanged: (index) {
                  setState(() => _iconIndex = index);
                  _showFeedback('Selected View: ${_iconOptions[index].label}');
                },
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Custom Palette (Purple & Orange)',
            note: 'Easily override standard styling tokens: background, indicator, text, and active text colors.',
            code: '''TectaSegmentedControl(
  options: _options,
  selectedIndex: _index,
  backgroundColor: Colors.deepPurple.shade50,
  indicatorColor: Colors.deepPurple,
  textColor: Colors.deepPurple.shade300,
  selectedTextColor: Colors.white,
  onValueChanged: (index) => {},
)''',
            overview: Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: 300,
                  child: TectaSegmentedControl(
                    options: _customOptions,
                    selectedIndex: _customIndex,
                    backgroundColor: isDark ? Colors.deepPurple.withValues(alpha: 0.15) : Colors.deepPurple.shade50,
                    indicatorColor: Colors.deepPurple,
                    textColor: isDark ? Colors.deepPurple.shade100 : Colors.deepPurple.shade300,
                    selectedTextColor: Colors.white,
                    onValueChanged: (index) {
                      setState(() => _customIndex = index);
                      _showFeedback('Selected Category: ${_customOptions[index].label}');
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TectaSegmentedControl(
                    options: _standardOptions,
                    selectedIndex: _standardIndex,
                    backgroundColor: isDark ? Colors.orange.withValues(alpha: 0.15) : Colors.orange.shade50,
                    indicatorColor: Colors.orange,
                    textColor: isDark ? Colors.orange.shade100 : Colors.orange.shade300,
                    selectedTextColor: Colors.white,
                    onValueChanged: (index) {
                      setState(() => _standardIndex = index);
                    },
                  ),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'With Count Badges',
            note: 'Incorporate custom trailing or leading widgets (like numerical badges) inside segmented options.',
            code: '''TectaSegmentedOption(
  label: 'All',
  trailing: Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    child: Text('10'),
  ),
)''',
            overview: SizedBox(
              width: 420,
              child: TectaSegmentedControl(
                options: [
                  TectaSegmentedOption(
                    label: 'All',
                    trailing: _buildBadge('10', _badgeIndex == 0),
                  ),
                  TectaSegmentedOption(
                    label: 'Active',
                    trailing: _buildBadge('6', _badgeIndex == 1),
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
            ),
          ),
          ShowcaseSection(
            title: 'Fully Custom Pill Size',
            note: 'Pass height, padding, border radius, and indicator corner geometry configuration to create pill switches.',
            code: '''TectaSegmentedControl(
  options: _options,
  height: 48.0,
  outerPadding: 6.0,
  borderRadius: BorderRadius.circular(24.0),
  indicatorBorderRadius: BorderRadius.circular(20.0),
  onValueChanged: (index) => {},
)''',
            overview: SizedBox(
              width: 360,
              child: TectaSegmentedControl(
                options: _customOptions,
                selectedIndex: _customSizeIndex,
                onValueChanged: (index) {
                  setState(() => _customSizeIndex = index);
                },
                height: 48.0,
                outerPadding: 6.0,
                itemPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                borderRadius: BorderRadius.circular(24.0),
                indicatorBorderRadius: BorderRadius.circular(20.0),
                backgroundColor: TectaColors.primaryMain.withValues(alpha: 0.1),
                indicatorColor: TectaColors.primaryMain,
                selectedTextColor: Colors.white,
                textColor: TectaColors.primaryMain,
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Disabled State',
            note: 'Set isEnabled flag to false to freeze interaction overlays while preserving active selection highlights.',
            code: '''TectaSegmentedControl(
  options: _options,
  isEnabled: false,
  onValueChanged: (index) => {},
)''',
            overview: SizedBox(
              width: 320,
              child: TectaSegmentedControl(
                options: _standardOptions,
                selectedIndex: _disabledIndex,
                isEnabled: false,
                onValueChanged: (index) {
                  setState(() => _disabledIndex = index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
