import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import 'home_screen.dart'; // To access ShowcaseItem and ShowcaseCategory

class ShowcaseMobileView extends StatefulWidget {
  final List<ShowcaseCategory> categories;
  final ValueNotifier<ThemeMode> themeNotifier;

  const ShowcaseMobileView({
    super.key,
    required this.categories,
    required this.themeNotifier,
  });

  @override
  State<ShowcaseMobileView> createState() => _ShowcaseMobileViewState();
}

class _ShowcaseMobileViewState extends State<ShowcaseMobileView> {
  bool _isGridView = false;

  Widget _buildMobileCategorySection(ShowcaseCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
          child: Text(
            category.title,
            style: TectaTypography.caption.copyWith(
              color: TectaColors.grey500,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
        ),
        _isGridView
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: category.items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final item = category.items[index];
                  return _buildGridCard(context, item);
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: category.items.length,
                itemBuilder: (context, index) {
                  final item = category.items[index];
                  return _buildListCard(context, item);
                },
              ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildGridCard(BuildContext context, ShowcaseItem item) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item.builder(context)),
            );
          },
          borderRadius: BorderRadius.circular(16.0),
          splashColor: TectaColors.primaryLighter.withValues(alpha: 0.3),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: item.iconColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Icon(
                        item.icon,
                        color: item.iconColor,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  item.title,
                  style: (theme.textTheme.titleSmall ?? TectaTypography.subtitle2).copyWith(
                    color: TectaColors.grey800,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: (theme.textTheme.bodySmall ?? TectaTypography.caption).copyWith(
                    color: TectaColors.grey500,
                    fontSize: 11,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListCard(BuildContext context, ShowcaseItem item) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item.builder(context)),
            );
          },
          borderRadius: BorderRadius.circular(12.0),
          splashColor: TectaColors.primaryLighter.withValues(alpha: 0.3),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: item.iconColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: (theme.textTheme.titleSmall ?? TectaTypography.subtitle2).copyWith(
                          color: TectaColors.grey800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.description,
                        style: (theme.textTheme.bodySmall ?? TectaTypography.caption).copyWith(
                          color: TectaColors.grey500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: TectaColors.grey400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tecta Design System',
          style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
              color: TectaColors.grey800,
            ),
            tooltip: _isGridView ? 'Switch to List View' : 'Switch to Grid View',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: Icon(
              widget.themeNotifier.value == ThemeMode.dark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: TectaColors.grey800,
            ),
            onPressed: () {
              setState(() {
                widget.themeNotifier.value =
                    widget.themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: widget.categories.map<Widget>((category) {
          return _buildMobileCategorySection(category);
        }).toList(),
      ),
    );
  }
}
