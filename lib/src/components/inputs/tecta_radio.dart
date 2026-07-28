import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Sizing options for the Radio Button.
enum TectaRadioSize { small, medium }

/// Label placement relative to the Radio Button.
enum TectaRadioLabelPlacement { top, bottom, start, end }

/// A premium, highly customizable Radio Button widget matching Minimals style.
class TectaRadio<T> extends StatelessWidget {
  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for this group of radio buttons.
  final T? groupValue;

  /// Callback when the radio button is selected.
  /// If null, the radio button is disabled.
  final ValueChanged<T?>? onChanged;

  /// The active color of the radio button (accepts any Flutter [Color]). Defaults to [TectaColors.primaryMain].
  final Color? color;

  /// The size of the radio button.
  final TectaRadioSize size;

  /// Optional label text to show next to the radio button.
  final String? label;

  /// The placement of the label.
  final TectaRadioLabelPlacement labelPlacement;

  /// Optional custom style for the label text.
  final TextStyle? labelStyle;

  // ===========================================================================
  // DYNAMIC STYLE OVERRIDES
  // ===========================================================================

  /// Custom active color override.
  final Color? activeColorOverride;

  /// Custom inactive border color override.
  final Color? inactiveColorOverride;

  /// Custom border width override.
  final double? borderWidthOverride;

  /// Custom outer box/circle size override.
  final double? boxSizeOverride;

  /// Custom inner dot size override.
  final double? innerCircleSizeOverride;

  /// Custom spacing between radio button and label.
  final double? spacingOverride;

  /// Creates a [TectaRadio] radio component.
  const TectaRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.color,
    this.size = TectaRadioSize.medium,
    this.label,
    this.labelPlacement = TectaRadioLabelPlacement.end,
    this.labelStyle,
    this.activeColorOverride,
    this.inactiveColorOverride,
    this.borderWidthOverride,
    this.boxSizeOverride,
    this.innerCircleSizeOverride,
    this.spacingOverride,
  });

  bool get _isSelected => value == groupValue;

  Color _getColor(BuildContext context) {
    final Color activeColor = color ?? TectaColors.primaryMain;
    return TectaColors.resolve(context, activeColor);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onChanged == null;

    // Sizing attributes (with optional overrides)
    final double boxSize = boxSizeOverride ?? (size == TectaRadioSize.small ? 18.0 : 22.0);
    final double innerCircleSize =
        innerCircleSizeOverride ?? (size == TectaRadioSize.small ? 8.0 : 10.0);
    final double borderWidth = borderWidthOverride ?? 2.0;
    final double spacing = spacingOverride ?? 8.0;

    // State Colors
    Color border;
    Color? dotColor;

    if (_isSelected) {
      if (isDisabled) {
        border = TectaColors.grey400;
        dotColor = TectaColors.grey400;
      } else {
        border = activeColorOverride ?? _getColor(context);
        dotColor = border;
      }
    } else {
      border = isDisabled
          ? TectaColors.grey300
          : (inactiveColorOverride ?? TectaColors.grey500);
      dotColor = null;
    }

    // Outer Radio circle
    final Widget radioWidget = Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: border, width: borderWidth),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          width: _isSelected ? innerCircleSize : 0.0,
          height: _isSelected ? innerCircleSize : 0.0,
          decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor ?? Colors.transparent),
        ),
      ),
    );

    // InkResponse for ripple feedback
    final activeThemeColor = activeColorOverride ?? _getColor(context);
    final Widget radioButton = Theme(
      data: Theme.of(context).copyWith(
        splashColor: activeThemeColor.withValues(alpha: 0.1),
        hoverColor: activeThemeColor.withValues(alpha: 0.05),
      ),
      child: InkResponse(
        onTap: isDisabled ? null : () => onChanged!(value),
        radius: boxSize * 1.1,
        child: radioWidget,
      ),
    );

    final Widget labelWidget = label != null
        ? Text(
            label!,
            style:
                (labelStyle ??
                        (size == TectaRadioSize.small
                            ? TectaTypography.body2.copyWith(fontSize: 13)
                            : TectaTypography.body2))
                    .copyWith(color: isDisabled ? TectaColors.grey500 : TectaColors.grey800),
          )
        : const SizedBox.shrink();

    Widget content;
    if (label == null) {
      content = radioButton;
    } else {
      switch (labelPlacement) {
        case TectaRadioLabelPlacement.start:
          content = Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labelWidget,
              SizedBox(width: spacing),
              radioButton,
            ],
          );
          break;
        case TectaRadioLabelPlacement.top:
          content = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labelWidget,
              SizedBox(height: spacing),
              radioButton,
            ],
          );
          break;
        case TectaRadioLabelPlacement.bottom:
          content = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              radioButton,
              SizedBox(height: spacing),
              labelWidget,
            ],
          );
          break;
        case TectaRadioLabelPlacement.end:
          content = Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              radioButton,
              SizedBox(width: spacing),
              labelWidget,
            ],
          );
          break;
      }
    }

    return GestureDetector(
      onTap: isDisabled ? null : () => onChanged!(value),
      behavior: HitTestBehavior.opaque,
      child: content,
    );
  }
}
