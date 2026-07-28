import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import 'home_screen.dart'; // To access ShowcaseItem and ShowcaseCategory
import 'docs_tab_screen.dart';
import 'templates_tab_screen.dart';
import 'playground_tab_screen.dart';

class ShowcaseDesktopView extends StatelessWidget {
  final List<ShowcaseCategory> categories;
  final ShowcaseItem selectedItem;
  final String currentTab;
  final ValueNotifier<ThemeMode> themeNotifier;
  final ValueChanged<ShowcaseItem> onSelectedItemChanged;
  final ValueChanged<String> onTabChanged;

  const ShowcaseDesktopView({
    super.key,
    required this.categories,
    required this.selectedItem,
    required this.currentTab,
    required this.themeNotifier,
    required this.onSelectedItemChanged,
    required this.onTabChanged,
  });

  Widget _buildMainContent(BuildContext context) {
    switch (currentTab) {
      case 'Docs':
        return const DocsTabScreen();
      case 'Templates':
        return const TemplatesTabScreen();
      case 'Playground':
        return const PlaygroundTabScreen();
      case 'Components':
      default:
        final formattedCategory = _getCategoryTitle(selectedItem);

        // Header widget (breadcrumb + title + description) — scrolls with content
        final headerWidget = Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              Row(
                children: [
                  Text(
                    formattedCategory,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : TectaColors.grey800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '›',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white30
                            : TectaColors.grey400,
                      ),
                    ),
                  ),
                  Text(
                    selectedItem.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: TectaColors.secondaryMain,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Title
              Text(
                selectedItem.title,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : TectaColors.grey800,
                  letterSpacing: -1.0,
                ),
              ),
              // Short description below title
              if (selectedItem.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  selectedItem.description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white54
                        : TectaColors.grey500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ],
          ),
        );

        // Pass header via InheritedWidget — ShowcasePageLayout reads it from context
        return ShowcaseHeaderScope(
          header: headerWidget,
          child: KeyedSubtree(
            key: ValueKey('${selectedItem.title}_${themeNotifier.value}'),
            child: Builder(
              builder: (context) => selectedItem.builder(context),
            ),
          ),
        );
    }
  }

  String _getCategoryTitle(ShowcaseItem item) {
    String categoryTitle = 'Foundation';
    for (final cat in categories) {
      if (cat.items.contains(item)) {
        categoryTitle = cat.title;
        break;
      }
    }
    return categoryTitle[0].toUpperCase() + categoryTitle.substring(1).toLowerCase();
  }

  Widget _buildTopNavigationBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : TectaColors.grey800;

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo Tecta UI
          Row(
            children: [
              const Icon(
                SolarLinearIcons.star,
                color: TectaColors.primaryMain,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Tecta UI',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: TectaColors.primaryMain.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'v1.0.0',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: TectaColors.primaryMain,
                  ),
                ),
              ),
            ],
          ),
          // Navigation Tabs
          Row(
            children: ['Docs', 'Components', 'Templates', 'Playground'].map((tab) {
              final isSelected = currentTab == tab;
              return GestureDetector(
                onTap: () => onTabChanged(tab),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(),
                    child: Text(
                      tab,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? TectaColors.secondaryMain
                            : (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white70
                                : TectaColors.grey700),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          // Right Theme Control
          IconButton(
            icon: Icon(
              themeNotifier.value == ThemeMode.dark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: TectaColors.grey800,
            ),
            onPressed: () {
              themeNotifier.value =
                  themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(right: BorderSide(color: theme.dividerColor)),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Text(
                  category.title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: TectaColors.grey500,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              ...category.items.map((item) {
                final isSelected = selectedItem.title == item.title;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: InkWell(
                    onTap: () => onSelectedItemChanged(item),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? TectaColors.primaryMain.withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: 18,
                            color: isSelected ? TectaColors.primaryMain : TectaColors.grey500,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                color: isSelected
                                    ? TectaColors.primaryMain
                                    : (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white70
                                        : TectaColors.grey800),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildTopNavigationBar(context),
          Expanded(
            child: Row(
              children: [
                if (currentTab == 'Components') _buildSidebar(context),
                Expanded(
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF161616)
                        : TectaColors.grey50,
                    child: _buildMainContent(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// InheritedWidget to pass a header widget down to ShowcasePageLayout
class ShowcaseHeaderScope extends InheritedWidget {
  final Widget header;

  const ShowcaseHeaderScope({
    super.key,
    required this.header,
    required super.child,
  });

  static ShowcaseHeaderScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShowcaseHeaderScope>();
  }

  @override
  bool updateShouldNotify(ShowcaseHeaderScope oldWidget) => header != oldWidget.header;
}
