import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Sizing options for the Switch.
enum TectaSwitchSize { small, medium }

/// Label placement relative to the Switch.
enum TectaSwitchLabelPlacement { top, bottom, start, end }

/// A premium, highly customizable Switch widget matching Minimals style.
class TectaSwitch extends StatelessWidget {
  /// The current active state of the switch.
  final bool value;

  /// Callback when the state changes.
  /// If null, the switch is disabled.
  final ValueChanged<bool>? onChanged;

  /// The active color of the switch (accepts any Flutter [Color]). Defaults to [TectaColors.primaryMain].
  final Color? color;

  /// The size of the switch.
  final TectaSwitchSize size;

  /// Optional label text to show next to the switch.
  final String? label;

  /// The placement of the label.
  final TectaSwitchLabelPlacement labelPlacement;

  /// Optional custom style for the label text.
  final TextStyle? labelStyle;

  // ===========================================================================
  // DYNAMIC STYLE OVERRIDES
  // ===========================================================================

  /// Custom active track color override.
  final Color? activeColorOverride;

  /// Custom inactive track color override.
  final Color? inactiveColorOverride;

  /// Custom track width override.
  final double? trackWidthOverride;

  /// Custom track height override.
  final double? trackHeightOverride;

  /// Custom thumb circle size override.
  final double? thumbSizeOverride;

  /// Custom spacing between switch and label.
  final double? spacingOverride;

  /// Creates a [TectaSwitch] toggle switch component.
  const TectaSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.color,
    this.size = TectaSwitchSize.medium,
    this.label,
    this.labelPlacement = TectaSwitchLabelPlacement.end,
    this.labelStyle,
    this.activeColorOverride,
    this.inactiveColorOverride,
    this.trackWidthOverride,
    this.trackHeightOverride,
    this.thumbSizeOverride,
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
    final double defaultWidth = size == TectaSwitchSize.small ? 32.0 : 40.0;
    final double defaultHeight = size == TectaSwitchSize.small ? 16.0 : 20.0;
    final double defaultThumbSize = size == TectaSwitchSize.small ? 10.0 : 14.0;
    final double defaultPadding = size == TectaSwitchSize.small ? 3.0 : 3.0;

    final double trackWidth = trackWidthOverride ?? defaultWidth;
    final double trackHeight = trackHeightOverride ?? defaultHeight;
    final double thumbSize = thumbSizeOverride ?? defaultThumbSize;
    final double spacing = spacingOverride ?? 8.0;

    // State Colors
    Color trackColor;
    final Color thumbColor = TectaColors.white;

    if (value) {
      if (isDisabled) {
        trackColor = (activeColorOverride ?? _getColor(context)).withValues(alpha: 0.48);
      } else {
        trackColor = activeColorOverride ?? _getColor(context);
      }
    } else {
      if (isDisabled) {
        trackColor = TectaColors.grey300.withValues(alpha: 0.48);
      } else {
        trackColor = inactiveColorOverride ?? TectaColors.grey400;
      }
    }

    // Outer track layout
    final Widget switchWidget = Container(
      width: trackWidth,
      height: trackHeight,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(trackHeight),
        color: trackColor,
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: thumbSize,
          height: thumbSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: thumbColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );

    // InkResponse for ripple feedback
    final activeThemeColor = activeColorOverride ?? _getColor(context);
    final Widget switchButton = Theme(
      data: Theme.of(context).copyWith(
        splashColor: activeThemeColor.withValues(alpha: 0.1),
        hoverColor: activeThemeColor.withValues(alpha: 0.05),
      ),
      child: InkResponse(
        onTap: isDisabled ? null : () => onChanged!(!value),
        radius: trackWidth * 0.7,
        child: switchWidget,
      ),
    );

    final Widget labelWidget = label != null
        ? Text(
            label!,
            style:
                (labelStyle ??
                        (size == TectaSwitchSize.small
                            ? TectaTypography.body2.copyWith(fontSize: 13)
                            : TectaTypography.body2))
                    .copyWith(color: isDisabled ? TectaColors.grey500 : TectaColors.grey800),
          )
        : const SizedBox.shrink();

    Widget content;
    if (label == null) {
      content = switchButton;
    } else {
      switch (labelPlacement) {
        case TectaSwitchLabelPlacement.start:
          content = Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labelWidget,
              SizedBox(width: spacing),
              switchButton,
            ],
          );
          break;
        case TectaSwitchLabelPlacement.top:
          content = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labelWidget,
              SizedBox(height: spacing),
              switchButton,
            ],
          );
          break;
        case TectaSwitchLabelPlacement.bottom:
          content = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              switchButton,
              SizedBox(height: spacing),
              labelWidget,
            ],
          );
          break;
        case TectaSwitchLabelPlacement.end:
          content = Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              switchButton,
              SizedBox(width: spacing),
              labelWidget,
            ],
          );
          break;
      }
    }

    return GestureDetector(
      onTap: isDisabled ? null : () => onChanged!(!value),
      behavior: HitTestBehavior.opaque,
      child: content,
    );
  }
}
