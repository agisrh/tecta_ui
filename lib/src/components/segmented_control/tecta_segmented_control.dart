import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Data model representing a single segment option in [TectaSegmentedControl].
class TectaSegmentedOption {
  /// The text label.
  final String label;

  /// Optional icon.
  final IconData? icon;

  /// Optional trailing widget (such as a badge, count label, or indicator).
  final Widget? trailing;

  /// Custom inner padding for this specific segment option.
  /// Overrides [TectaSegmentedControl.itemPadding].
  final EdgeInsetsGeometry? padding;

  /// Custom text style for this segment option when inactive.
  /// Overrides [TectaSegmentedControl.textStyle].
  final TextStyle? textStyle;

  /// Custom text style for this segment option when active/selected.
  /// Overrides [TectaSegmentedControl.selectedTextStyle].
  final TextStyle? selectedTextStyle;

  /// Custom text/icon color for this specific option when inactive.
  /// Overrides [TectaSegmentedControl.textColor].
  final Color? textColor;

  /// Custom text/icon color for this specific option when active/selected.
  /// Overrides [TectaSegmentedControl.selectedTextColor].
  final Color? selectedTextColor;

  const TectaSegmentedOption({
    required this.label,
    this.icon,
    this.trailing,
    this.padding,
    this.textStyle,
    this.selectedTextStyle,
    this.textColor,
    this.selectedTextColor,
  });
}

/// A premium, highly customizable Segmented Control component with smooth sliding animations.
class TectaSegmentedControl extends StatelessWidget {
  /// List of segment options.
  final List<TectaSegmentedOption> options;

  /// The index of the currently selected segment.
  final int selectedIndex;

  /// Callback when a segment is selected.
  final ValueChanged<int> onValueChanged;

  /// Custom background color of the outer container.
  final Color? backgroundColor;

  /// Custom background color of the active sliding indicator.
  final Color? indicatorColor;

  /// Custom text/icon color of inactive segments.
  final Color? textColor;

  /// Custom text/icon color of the active/selected segment.
  final Color? selectedTextColor;

  /// Custom text style for inactive labels.
  final TextStyle? textStyle;

  /// Custom text style for the active/selected label.
  final TextStyle? selectedTextStyle;

  /// Border radius of the segmented control. Defaults to 12.0.
  final BorderRadiusGeometry? borderRadius;

  /// Whether the segmented control is interactive. Defaults to true.
  final bool isEnabled;

  /// Custom height of each segment option. Defaults to 38.0.
  final double? height;

  /// Custom padding around the segmented control. Defaults to 4.0.
  final double? outerPadding;

  /// Custom inner padding for each segment option item.
  final EdgeInsetsGeometry? itemPadding;

  /// Custom border radius of the active sliding indicator.
  /// If not specified, falls back to [borderRadius] or 8.0.
  final BorderRadiusGeometry? indicatorBorderRadius;

  const TectaSegmentedControl({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onValueChanged,
    this.backgroundColor,
    this.indicatorColor,
    this.textColor,
    this.selectedTextColor,
    this.textStyle,
    this.selectedTextStyle,
    this.borderRadius,
    this.isEnabled = true,
    this.height,
    this.outerPadding,
    this.itemPadding,
    this.indicatorBorderRadius,
  }) : assert(options.length >= 2, 'TectaSegmentedControl requires at least 2 options.');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Default theme fallback colors
    final defaultBgColor = isDark ? TectaColors.grey800 : TectaColors.grey200;
    final defaultIndicatorColor = isDark ? TectaColors.grey700 : Colors.white;
    final defaultTextColor = isDark ? TectaColors.grey400 : TectaColors.grey600;
    final defaultSelectedTextColor = isDark ? Colors.white : TectaColors.grey900;

    final resolvedBg = TectaColors.resolve(context, backgroundColor ?? defaultBgColor);
    final resolvedIndicator = TectaColors.resolve(context, indicatorColor ?? defaultIndicatorColor);

    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(12.0);
    final resolvedIndicatorBorderRadius = indicatorBorderRadius ?? borderRadius ?? BorderRadius.circular(8.0);
    final double paddingVal = outerPadding ?? 4.0;

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: Container(
        decoration: BoxDecoration(
          color: resolvedBg,
          borderRadius: resolvedBorderRadius,
        ),
        padding: EdgeInsets.all(paddingVal),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double totalWidth = constraints.maxWidth;
            final double segmentWidth = totalWidth / options.length;
            final double indicatorWidth = segmentWidth;

            return Stack(
              children: [
                // Sliding Active Background Card
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOutCubic,
                  left: selectedIndex * segmentWidth,
                  top: 0,
                  bottom: 0,
                  width: indicatorWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: resolvedIndicator,
                      borderRadius: resolvedIndicatorBorderRadius,
                      boxShadow: isDark ? null : TectaShadows.z1,
                    ),
                  ),
                ),
                // Segments Content Row
                Row(
                  children: List.generate(options.length, (index) {
                    final option = options[index];
                    final isSelected = selectedIndex == index;

                    final optionTextColor = option.textColor ?? textColor ?? defaultTextColor;
                    final optionSelectedTextColor = option.selectedTextColor ?? selectedTextColor ?? defaultSelectedTextColor;

                    final resolvedTextLoc = TectaColors.resolve(context, optionTextColor);
                    final resolvedSelectedTextLoc = TectaColors.resolve(context, optionSelectedTextColor);
                    final itemColor = isSelected ? resolvedSelectedTextLoc : resolvedTextLoc;

                    final defaultStyle = TectaTypography.subtitle2.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: itemColor,
                    );

                    final optionTextStyle = option.textStyle ?? textStyle;
                    final optionSelectedTextStyle = option.selectedTextStyle ?? selectedTextStyle;
                    final resolvedTextStyle = (isSelected ? optionSelectedTextStyle : optionTextStyle) ?? defaultStyle;

                    return Expanded(
                      child: GestureDetector(
                        onTap: isEnabled ? () => onValueChanged(index) : null,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: height ?? 38.0,
                          padding: option.padding ?? itemPadding,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (option.icon != null) ...[
                                Icon(
                                  option.icon,
                                  size: 16.0,
                                  color: itemColor,
                                ),
                                const SizedBox(width: 6.0),
                              ],
                              Text(
                                option.label,
                                style: resolvedTextStyle.copyWith(color: itemColor),
                              ),
                              if (option.trailing != null) ...[
                                const SizedBox(width: 6.0),
                                option.trailing!,
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
