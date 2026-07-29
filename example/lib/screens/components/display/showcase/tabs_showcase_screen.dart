import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class TabsShowcasePage extends StatefulWidget {
  const TabsShowcasePage({super.key});

  @override
  State<TabsShowcasePage> createState() => _TabsShowcasePageState();
}

class _TabsShowcasePageState extends State<TabsShowcasePage> {
  int _tabIndex1 = 0;
  int _tabIndex2 = 0;
  int _tabIndex3 = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Tabs',
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
            title: 'Line Tabs (Default)',
            note: 'TectaTabs line variant displays an underline marker. Supports icons, labels, and numeric/text badges.',
            code: '''TectaTabs(
  selectedIndex: _tabIndex,
  variant: TectaTabsVariant.line,
  isScrollable: true,
  tabs: const [
    TectaTab(label: 'Profile', icon: Icons.person_outline),
    TectaTab(label: 'Messages', icon: Icons.chat_bubble_outline, badge: '5'),
    TectaTab(label: 'Settings', icon: Icons.settings_outlined),
  ],
  onTabChanged: (index) => setState(() => _tabIndex = index),
)''',
            overview: SizedBox(
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TectaTabs(
                    selectedIndex: _tabIndex1,
                    variant: TectaTabsVariant.line,
                    isScrollable: true,
                    tabs: const [
                      TectaTab(label: 'Profile', icon: Icons.person_outline),
                      TectaTab(label: 'Messages', icon: Icons.chat_bubble_outline, badge: '5'),
                      TectaTab(label: 'Settings', icon: Icons.settings_outlined),
                      TectaTab(label: 'Activity', icon: Icons.notifications_none_outlined),
                    ],
                    onTabChanged: (index) {
                      setState(() {
                        _tabIndex1 = index;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Active index view: $_tabIndex1',
                    style: TextStyle(color: isDark ? Colors.white60 : TectaColors.grey600),
                  ),
                ],
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Pill Capsule Tabs',
            note: 'Renders tabs as standalone rounded capsules, useful for sub-navigation or dashboard filter toggles.',
            code: '''TectaTabs(
  selectedIndex: _tabIndex,
  variant: TectaTabsVariant.pill,
  tabs: const [
    TectaTab(label: 'Home'),
    TectaTab(label: 'Stats', badge: 'New'),
  ],
)''',
            overview: SizedBox(
              width: 440,
              child: Column(
                children: [
                  TectaTabs(
                    selectedIndex: _tabIndex2,
                    variant: TectaTabsVariant.pill,
                    tabs: const [
                      TectaTab(label: 'Home'),
                      TectaTab(label: 'Stats', badge: 'New'),
                      TectaTab(label: 'Info'),
                    ],
                    onTabChanged: (index) {
                      setState(() {
                        _tabIndex2 = index;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Active index view: $_tabIndex2',
                    style: TextStyle(color: isDark ? Colors.white60 : TectaColors.grey600),
                  ),
                ],
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Contained Tabs',
            note: 'Wrap options inside a solid segmented border box layout. Ideal for layouts where space constraints are high.',
            code: '''TectaTabs(
  selectedIndex: _tabIndex,
  variant: TectaTabsVariant.contained,
  tabs: const [
    TectaTab(label: 'Daily'),
    TectaTab(label: 'Weekly'),
  ],
)''',
            overview: SizedBox(
              width: 400,
              child: Column(
                children: [
                  TectaTabs(
                    selectedIndex: _tabIndex3,
                    variant: TectaTabsVariant.contained,
                    tabs: const [
                      TectaTab(label: 'Daily'),
                      TectaTab(label: 'Weekly'),
                      TectaTab(label: 'Monthly'),
                    ],
                    onTabChanged: (index) {
                      setState(() {
                        _tabIndex3 = index;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Active index view: $_tabIndex3',
                    style: TextStyle(color: isDark ? Colors.white60 : TectaColors.grey600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
