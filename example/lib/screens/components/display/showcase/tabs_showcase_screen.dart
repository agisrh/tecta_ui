import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

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
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Tabs',
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
          // ---------------------------------------------------------
          // UNDERLINE TABS
          // ---------------------------------------------------------
          _buildSectionHeader('Scrollable Tabs (Line Variant)'),
          const SizedBox(height: 12),
          _buildCard(
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
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'Active view index: $_tabIndex1',
                    style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ---------------------------------------------------------
          // CAPSULE TABS
          // ---------------------------------------------------------
          _buildSectionHeader('Capsule Tabs (Pill Variant)'),
          const SizedBox(height: 12),
          _buildCard(
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
                const SizedBox(height: 24),
                Text(
                  'Active view index: $_tabIndex2',
                  style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ---------------------------------------------------------
          // CONTAINED SEGMENTED TABS
          // ---------------------------------------------------------
          _buildSectionHeader('Contained Tabs (Segmented Control Variant)'),
          const SizedBox(height: 12),
          _buildCard(
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
                const SizedBox(height: 24),
                Text(
                  'Active view index: $_tabIndex3',
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

  Widget _buildCard({required Widget child}) {
    return Material(
      color: TectaColors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: TectaColors.grey200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
