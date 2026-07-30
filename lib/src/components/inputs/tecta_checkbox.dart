import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Sizing options for the Checkbox.
enum TectaCheckboxSize { small, medium }

/// Label placement relative to the Checkbox.
enum TectaCheckboxLabelPlacement { top, bottom, start, end }

/// A premium and highly customizable Checkbox widget matching Minimals style.
class TectaCheckbox extends StatelessWidget {
  /// The current state of the checkbox.
  /// If null, the checkbox is in an indeterminate state.
  final bool? value;

  /// Callback when the state changes.
  /// If null, the checkbox is disabled.
  final ValueChanged<bool?>? onChanged;

  /// The active color of the checkbox (accepts any Flutter [Color]). Defaults to [TectaColors.primaryMain].
  final Color? color;

  /// The size of the checkbox.
  final TectaCheckboxSize size;

  /// Optional label text to show next to the checkbox.
  final String? label;

  /// The placement of the label.
  final TectaCheckboxLabelPlacement labelPlacement;

  /// Optional custom style for the label text.
  final TextStyle? labelStyle;

  // ===========================================================================
  // DYNAMIC STYLE OVERRIDES
  // ===========================================================================

  /// Custom corner rounded override.
  final double? borderRadiusOverride;

  /// Custom border width override.
  final double? borderWidthOverride;

  /// Custom active background color override.
  final Color? activeBgColorOverride;

  /// Custom active border color override.
  final Color? activeBorderColorOverride;

  /// Custom inactive border color override.
  final Color? inactiveBorderColorOverride;

  /// Custom check mark icon color override.
  final Color? checkMarkColorOverride;

  /// Custom box size override.
  final double? boxSizeOverride;

  /// Custom icon size override.
  final double? iconSizeOverride;

  /// Custom spacing between checkbox and label.
  final double? spacingOverride;

  /// Creates a [TectaCheckbox] component.
  const TectaCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.color,
    this.size = TectaCheckboxSize.medium,
    this.label,
    this.labelPlacement = TectaCheckboxLabelPlacement.end,
    this.labelStyle,
    this.borderRadiusOverride,
    this.borderWidthOverride,
    this.activeBgColorOverride,
    this.activeBorderColorOverride,
    this.inactiveBorderColorOverride,
    this.checkMarkColorOverride,
    this.boxSizeOverride,
    this.iconSizeOverride,
    this.spacingOverride,
  });

  Color _getColor(BuildContext context) {
    final Color activeColor = color ?? Theme.of(context).colorScheme.primary;
    return TectaColors.resolve(context, activeColor);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onChanged == null;

    // Sizing attributes (with optional overrides)
    final double boxSize = boxSizeOverride ?? (size == TectaCheckboxSize.small ? 18.0 : 22.0);
    final double borderRadius =
        borderRadiusOverride ?? (size == TectaCheckboxSize.small ? 4.0 : 6.0);
    final double iconSize = iconSizeOverride ?? (size == TectaCheckboxSize.small ? 12.0 : 16.0);
    final double borderWidth = borderWidthOverride ?? 2.0;
    final double spacing = spacingOverride ?? 8.0;

    // State Colors (with optional overrides)
    Color bg;
    Color border;
    final Color checkMarkColor = checkMarkColorOverride ?? TectaColors.white;

    if (value == null || value == true) {
      if (isDisabled) {
        bg = TectaColors.grey400;
        border = TectaColors.grey400;
      } else {
        bg = activeBgColorOverride ?? _getColor(context);
        border = activeBorderColorOverride ?? bg;
      }
    } else {
      bg = Colors.transparent;
      border = isDisabled
          ? TectaColors.grey300
          : (inactiveBorderColorOverride ?? TectaColors.grey500);
    }

    // Outer check box box
    final Widget checkWidget = Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: border, width: borderWidth),
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: value == true
              ? Icon(
                  Icons.check,
                  size: iconSize,
                  color: checkMarkColor,
                  key: const ValueKey('check'),
                )
              : value == null
              ? Icon(
                  Icons.remove,
                  size: iconSize,
                  color: checkMarkColor,
                  key: const ValueKey('indeterminate'),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );

    // Wrap in material InkResponse for hover/splash feedback on the box itself
    final Widget checkbox = Theme(
      data: Theme.of(context).copyWith(
        splashColor: (activeBgColorOverride ?? _getColor(context)).withValues(alpha: 0.1),
        hoverColor: (activeBgColorOverride ?? _getColor(context)).withValues(alpha: 0.05),
      ),
      child: InkResponse(
        onTap: isDisabled
            ? null
            : () {
                if (value == true) {
                  onChanged!(false);
                } else {
                  onChanged!(true);
                }
              },
        radius: boxSize * 1.1,
        child: checkWidget,
      ),
    );

    final Widget labelWidget = label != null
        ? Text(
            label!,
            style:
                (labelStyle ??
                        (size == TectaCheckboxSize.small
                            ? TectaTypography.body2.copyWith(fontSize: 13)
                            : TectaTypography.body2))
                    .copyWith(color: isDisabled ? TectaColors.grey500 : TectaColors.grey800),
          )
        : const SizedBox.shrink();

    Widget content;
    if (label == null) {
      content = checkbox;
    } else {
      switch (labelPlacement) {
        case TectaCheckboxLabelPlacement.start:
          content = Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labelWidget,
              SizedBox(width: spacing),
              checkbox,
            ],
          );
          break;
        case TectaCheckboxLabelPlacement.top:
          content = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labelWidget,
              SizedBox(height: spacing),
              checkbox,
            ],
          );
          break;
        case TectaCheckboxLabelPlacement.bottom:
          content = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              checkbox,
              SizedBox(height: spacing),
              labelWidget,
              ],
          );
          break;
        case TectaCheckboxLabelPlacement.end:
          content = Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              checkbox,
              SizedBox(width: spacing),
              labelWidget,
            ],
          );
          break;
      }
    }

    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
              if (value == true) {
                onChanged!(false);
              } else {
                onChanged!(true);
              }
            },
      behavior: HitTestBehavior.opaque,
      child: content,
    );
  }
}
