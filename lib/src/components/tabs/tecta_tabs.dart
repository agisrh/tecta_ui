import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Visual style variants for [TectaTabs].
enum TectaTabsVariant {
  /// Simple tab line indicator under active tab.
  line,
  /// Rounded capsule slider indicator around active tab.
  pill,
  /// Contained grey tray enclosing all tabs with slider highlight.
  contained,
}

/// Data class representing a single tab item.
class TectaTab {
  /// The textual label of the tab.
  final String label;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional notification badge string (e.g. '12' or 'New').
  final String? badge;

  /// Creates a [TectaTab] model definition.
  const TectaTab({
    required this.label,
    this.icon,
    this.badge,
  });
}

/// A premium Tab selection bar component matching the MUI / Minimals design language.
///
/// Features:
/// - Support for two visual indicators: `line` (classic underline indicator) and `pill` (capsule background slider).
/// - Automatically prevents horizontal overflows using robust layouts.
/// - Option to enable horizontal scrolling (`isScrollable`).
class TectaTabs extends StatefulWidget {
  /// Currently selected tab index.
  final int selectedIndex;

  /// List of tab elements.
  final List<TectaTab> tabs;

  /// Callback triggered when tab selection changes.
  final ValueChanged<int> onTabChanged;

  /// Visual styling variant. Defaults to [TectaTabsVariant.line].
  final TectaTabsVariant variant;

  /// Color of active tab elements. Defaults to [TectaColors.primaryMain].
  final Color? activeColor;

  /// Color of inactive tab elements. Defaults to [TectaColors.grey500].
  final Color? inactiveColor;

  /// Whether tabs can be scrolled horizontally when space is limited. Defaults to `false`.
  final bool isScrollable;

  /// Custom padding inside each tab label.
  final EdgeInsetsGeometry? labelPadding;

  /// Custom padding around the entire tab bar container.
  final EdgeInsetsGeometry? padding;

  /// Custom border radius override. Defaults to circular corner styles appropriate to the variant.
  final BorderRadiusGeometry? borderRadius;

  /// Custom background color override (primarily affects [TectaTabsVariant.contained] background tray).
  final Color? backgroundColor;

  /// Creates a [TectaTabs] bar switcher component.
  const TectaTabs({
    super.key,
    required this.selectedIndex,
    required this.tabs,
    required this.onTabChanged,
    this.variant = TectaTabsVariant.line,
    this.activeColor,
    this.inactiveColor,
    this.isScrollable = false,
    this.labelPadding,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  State<TectaTabs> createState() => _TectaTabsState();
}

class _TectaTabsState extends State<TectaTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging && _tabController.index != widget.selectedIndex) {
      widget.onTabChanged(_tabController.index);
    }
  }

  @override
  void didUpdateWidget(TectaTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabs.length != oldWidget.tabs.length) {
      _tabController.removeListener(_handleTabSelection);
      _tabController.dispose();
      _tabController = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: widget.selectedIndex,
      );
      _tabController.addListener(_handleTabSelection);
    } else if (widget.selectedIndex != _tabController.index) {
      _tabController.animateTo(widget.selectedIndex);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabs.isEmpty) return const SizedBox.shrink();

    final Color active = widget.activeColor ?? Theme.of(context).colorScheme.primary;
    final Color inactive = widget.inactiveColor ?? TectaColors.grey500;

    // Define indicators
    final Decoration activeIndicator;
    final BorderRadiusGeometry activeRadius = widget.borderRadius ?? BorderRadius.circular(8.0);

    if (widget.variant == TectaTabsVariant.line) {
      activeIndicator = UnderlineTabIndicator(
        borderSide: BorderSide(color: active, width: 3.0),
        insets: const EdgeInsets.symmetric(horizontal: 16.0),
      );
    } else if (widget.variant == TectaTabsVariant.pill) {
      activeIndicator = BoxDecoration(
        color: active.withValues(alpha: 0.08),
        borderRadius: activeRadius,
        border: Border.all(color: active.withValues(alpha: 0.15), width: 1.0),
      );
    } else {
      // contained
      activeIndicator = BoxDecoration(
        color: TectaColors.white,
        borderRadius: activeRadius,
        boxShadow: TectaShadows.z1,
      );
    }

    final double defaultContainedRadius = widget.variant == TectaTabsVariant.contained ? 12.0 : 0.0;
    final BorderRadiusGeometry containerRadius = widget.borderRadius ?? BorderRadius.circular(defaultContainedRadius);

    final EdgeInsetsGeometry defaultContainedPadding = widget.variant == TectaTabsVariant.contained
        ? const EdgeInsets.all(4.0)
        : EdgeInsets.zero;

    return Container(
      padding: widget.padding ?? defaultContainedPadding,
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            (widget.variant == TectaTabsVariant.contained ? TectaColors.grey100 : null),
        borderRadius: containerRadius,
        border: widget.variant == TectaTabsVariant.line
            ? const Border(bottom: BorderSide(color: TectaColors.grey200, width: 1.5))
            : null,
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: widget.isScrollable,
        tabAlignment: widget.isScrollable ? TabAlignment.start : TabAlignment.fill,
        labelPadding: widget.labelPadding ??
            (widget.isScrollable
                ? const EdgeInsets.symmetric(horizontal: 16.0)
                : const EdgeInsets.symmetric(horizontal: 4.0)),
        indicator: activeIndicator,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        padding: widget.variant == TectaTabsVariant.pill
            ? const EdgeInsets.symmetric(vertical: 4.0)
            : EdgeInsets.zero,
        tabs: widget.tabs.map((tab) {
          final int index = widget.tabs.indexOf(tab);
          final bool isSelected = index == widget.selectedIndex;

          return Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (tab.icon != null) ...[
                  Icon(
                    tab.icon,
                    size: 18.0,
                    color: isSelected ? active : inactive,
                  ),
                  const SizedBox(width: 8.0),
                ],
                Text(
                  tab.label,
                  style: TectaTypography.subtitle2.copyWith(
                    color: isSelected ? active : inactive,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
                if (tab.badge != null) ...[
                  const SizedBox(width: 6.0),
                  TectaLabel(
                    text: tab.badge!,
                    color: isSelected
                        ? active
                        : TectaColors.grey800,
                    variant: isSelected
                        ? TectaLabelVariant.filled
                        : TectaLabelVariant.soft,
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
