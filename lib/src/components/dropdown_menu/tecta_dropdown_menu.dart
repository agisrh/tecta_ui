import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Representation of a single dropdown menu item or visual divider.
class TectaDropdownItem {
  /// The text label. Set to null if this is a divider.
  final String? label;

  /// Optional icon.
  final IconData? icon;

  /// Custom text color for this item.
  final Color? textColor;

  /// Custom icon color for this item.
  final Color? iconColor;

  /// If true, renders the item in a destructive styling (red). Defaults to false.
  final bool isDestructive;

  /// If true, this item renders as a horizontal separator line instead of a menu option.
  final bool isDivider;

  /// Whether this specific item is enabled. Defaults to true.
  final bool isEnabled;

  const TectaDropdownItem({
    this.label,
    this.icon,
    this.textColor,
    this.iconColor,
    this.isDestructive = false,
    this.isDivider = false,
    this.isEnabled = true,
  });

  /// Factory helper to easily construct a divider.
  factory TectaDropdownItem.divider() => const TectaDropdownItem(isDivider: true);
}

/// A premium, highly customizable Dropdown Overlay Popup Menu component.
class TectaDropdownMenu extends StatelessWidget {
  /// The trigger widget (e.g. Button, Icon, Avatar) that opens the dropdown.
  final Widget child;

  /// List of items to show in the dropdown menu.
  final List<TectaDropdownItem> items;

  /// Callback when a non-divider enabled item is selected, returns the index in the items list.
  final ValueChanged<int> onItemSelected;

  /// Custom background color of the popup menu.
  final Color? backgroundColor;

  /// Custom border radius of the popup menu. Defaults to 12.0.
  final BorderRadiusGeometry? borderRadius;

  /// Elevation shadow depth of the popup menu. Defaults to 4.0.
  final double? elevation;

  /// Offset position relative to the child widget. Defaults to Offset(0, 40).
  final Offset offset;

  /// Custom text style for items.
  final TextStyle? textStyle;

  const TectaDropdownMenu({
    super.key,
    required this.child,
    required this.items,
    required this.onItemSelected,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.offset = const Offset(0, 40),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final resolvedBg = TectaColors.resolve(context, backgroundColor ?? (isDark ? TectaColors.grey800 : Colors.white));
    final double resolvedElevation = elevation ?? 4.0;

    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(12.0);

    return PopupMenuButton<int>(
      offset: offset,
      elevation: resolvedElevation,
      color: resolvedBg,
      shape: RoundedRectangleBorder(borderRadius: resolvedBorderRadius),
      shadowColor: isDark ? Colors.transparent : TectaColors.grey200.withValues(alpha: 0.5),
      onSelected: onItemSelected,
      itemBuilder: (BuildContext context) {
        return List.generate(items.length, (index) {
          final item = items[index];

          if (item.isDivider) {
            return PopupMenuItem<int>(
              value: index,
              enabled: false,
              height: 10.0,
              child: const TectaDivider(thickness: 1.0),
            );
          }

          final Color defaultColor = item.isDestructive
              ? TectaColors.errorMain
              : (isDark ? TectaColors.grey300 : TectaColors.grey700);

          final Color resolvedTextColor = item.textColor ?? defaultColor;
          final Color resolvedIconColor = item.iconColor ?? resolvedTextColor;

          final TextStyle defaultStyle = TectaTypography.subtitle2.copyWith(
            color: item.isEnabled ? resolvedTextColor : TectaColors.grey400,
            fontWeight: item.isDestructive ? FontWeight.w600 : FontWeight.normal,
          );

          return PopupMenuItem<int>(
            value: index,
            enabled: item.isEnabled,
            height: 38.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.icon != null) ...[
                  Icon(
                    item.icon,
                    size: 16.0,
                    color: item.isEnabled ? resolvedIconColor : TectaColors.grey400,
                  ),
                  const SizedBox(width: 10.0),
                ],
                Text(
                  item.label ?? '',
                  style: textStyle ?? defaultStyle,
                ),
              ],
            ),
          );
        });
      },
      child: child,
    );
  }
}
