import 'package:flutter/material.dart';
import '../main.dart'; // To access themeNotifier

import 'components/foundation/data/foundation_data.dart';
import 'components/forms/data/forms_data.dart';
import 'components/display/data/display_data.dart';
import 'components/feedback/data/feedback_data.dart';
import 'components/overlays/data/overlays_data.dart';

import 'home_screen_desktop.dart';
import 'home_screen_mobile.dart';

class ShowcaseItem {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final WidgetBuilder builder;

  const ShowcaseItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.builder,
  });
}

class ShowcaseCategory {
  final String title;
  final List<ShowcaseItem> items;

  const ShowcaseCategory({
    required this.title,
    required this.items,
  });
}

class ShowcaseHomeScreen extends StatefulWidget {
  const ShowcaseHomeScreen({super.key});

  @override
  State<ShowcaseHomeScreen> createState() => _ShowcaseHomeScreenState();
}

class _ShowcaseHomeScreenState extends State<ShowcaseHomeScreen> {
  late ShowcaseItem _selectedItem;
  String _currentTab = 'Components';
  late List<ShowcaseCategory> _categories;

  @override
  void initState() {
    super.initState();
    _categories = [
      buildFoundationCategory(),
      buildFormsCategory(),
      buildDisplayCategory(),
      buildFeedbackCategory(),
      buildOverlaysCategory(),
    ];
    _selectedItem = _categories.first.items.first;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    if (isDesktop) {
      return ShowcaseDesktopView(
        categories: _categories,
        selectedItem: _selectedItem,
        currentTab: _currentTab,
        themeNotifier: themeNotifier,
        onSelectedItemChanged: (item) {
          setState(() {
            _selectedItem = item;
          });
        },
        onTabChanged: (tab) {
          setState(() {
            _currentTab = tab;
          });
        },
      );
    }

    return ShowcaseMobileView(
      categories: _categories,
      themeNotifier: themeNotifier,
    );
  }
}
