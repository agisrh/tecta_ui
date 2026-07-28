import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium Empty State layout component matching the MUI / Minimals design language.
///
/// Features:
/// - Centers muted icons or custom illustration widgets.
/// - Formatted title and body description text labels.
/// - Supporting optional CTA action widgets (e.g. Refresh, Retry, Create).
/// - Fully customizable: background color, decoration, text styles, alignment, spacing, icon size & color.
class TectaEmptyState extends StatelessWidget {
  /// The main heading title of the empty state.
  final String title;

  /// Subtitle description details explaining why the page is empty or what to do next.
  final String? description;

  /// Custom icon widget or illustration. If null, a default empty icon is drawn.
  final Widget? icon;

  /// Custom IconData representing the placeholder icon. Ignored if [icon] is set.
  final IconData? iconData;

  /// Optional bottom action widget (typically a button).
  final Widget? action;

  /// Vertical spacing between items. Defaults to `16.0`.
  final double spacing;

  /// Inner margin padding around the layout block. Defaults to `EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0)`.
  final EdgeInsetsGeometry? padding;

  /// Custom background color for the empty state container.
  final Color? backgroundColor;

  /// Custom decoration for the empty state container (e.g., borders, shadows, gradients).
  /// Ignored if [backgroundColor] is also provided, unless you want to combine them.
  final BoxDecoration? decoration;

  /// Custom text style for the title text.
  final TextStyle? titleStyle;

  /// Custom text style for the description text.
  final TextStyle? descriptionStyle;

  /// Custom color for the icon. (Applicable if [icon] is null and [iconData] or default icon is used).
  final Color? iconColor;

  /// Custom size for the icon. (Applicable if [icon] is null and [iconData] or default icon is used).
  final double? iconSize;

  /// Alignment of the items horizontally inside the column. Defaults to [CrossAxisAlignment.center].
  final CrossAxisAlignment crossAxisAlignment;

  /// Alignment of the items vertically inside the column. Defaults to [MainAxisAlignment.center].
  final MainAxisAlignment mainAxisAlignment;

  /// The size of the main axis in the layout. Defaults to [MainAxisSize.min].
  final MainAxisSize mainAxisSize;

  /// Creates a [TectaEmptyState] feedback placeholder component.
  const TectaEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.iconData,
    this.action,
    this.spacing = 16.0,
    this.padding,
    this.backgroundColor,
    this.decoration,
    this.titleStyle,
    this.descriptionStyle,
    this.iconColor,
    this.iconSize,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
  });

  @override
  Widget build(BuildContext context) {
    // Render icon
    Widget? activeIcon = icon;
    activeIcon ??= Icon(
      iconData ?? Icons.cloud_off_rounded,
      size: iconSize ?? 72.0,
      color: iconColor ?? TectaColors.grey400,
    );

    final EdgeInsetsGeometry innerPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0);

    final resolvedDecoration =
        decoration ?? (backgroundColor != null ? BoxDecoration(color: backgroundColor) : null);

    return Center(
      child: Container(
        decoration: resolvedDecoration,
        padding: innerPadding,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            // Icon
            activeIcon,
            SizedBox(height: spacing * 1.5),

            // Title
            Text(
              title,
              style: titleStyle ??
                  TectaTypography.h6.copyWith(
                    color: TectaColors.grey800,
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),

            // Description
            if (description != null) ...[
              SizedBox(height: spacing / 2),
              Text(
                description!,
                style: descriptionStyle ??
                    TectaTypography.body2.copyWith(
                      color: TectaColors.grey500,
                    ),
                textAlign: TextAlign.center,
              ),
            ],

            // Action CTA button
            if (action != null) ...[
              SizedBox(height: spacing * 1.5),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
