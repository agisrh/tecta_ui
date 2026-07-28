import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Style variants for [TectaChip].
enum TectaChipVariant {
  /// Solid background with white or dark text.
  filled,
  /// Transparent background with colored border.
  outlined,
  /// Translucent colored background with matching text color.
  soft
}

/// Sizing options for [TectaChip].
enum TectaChipSize {
  /// Small compact chip.
  small,
  /// Medium standard chip.
  medium
}

/// A premium, highly customizable Chip / Label component for the Tecta Design System.
///
/// Features:
/// - Three visual variants: [TectaChipVariant.filled] (default), [TectaChipVariant.outlined], and [TectaChipVariant.soft].
/// - Accept standard Flutter [Color] or pre-defined [TectaColors].
/// - Two size presets: [TectaChipSize.medium] (default) and [TectaChipSize.small].
/// - Support for optional leading [avatar] and [icon] widgets.
/// - Optional delete action ([onDelete]) showing a close button.
/// - Optional click/tap action ([onTap]) with premium ink ripple feedback.
/// - State configurations: [isEnabled] to enable/disable interaction.
class TectaChip extends StatelessWidget {
  /// The main text label displayed inside the chip.
  final String label;

  /// Callback when the chip itself is tapped. If null, the chip is non-clickable.
  final VoidCallback? onTap;

  /// Callback when the delete icon is tapped. Shows the delete icon if provided.
  final VoidCallback? onDelete;

  /// Optional custom delete icon widget.
  final Widget? deleteIcon;

  /// Optional leading icon widget (typically an Icon using SolarIcons).
  final Widget? icon;

  /// Optional leading avatar widget (typically [TectaAvatar] or [CircleAvatar]).
  final Widget? avatar;

  /// The visual variant style. Defaults to [TectaChipVariant.filled].
  final TectaChipVariant variant;

  /// Custom theme color for the chip (accepts any Flutter [Color]). If null, falls back to neutral default grey colors.
  final Color? color;

  /// The size variant. Defaults to [TectaChipSize.medium].
  final TectaChipSize size;

  /// Whether the chip is active and interactive. Defaults to true.
  final bool isEnabled;

  // ===========================================================================
  // DYNAMIC STYLE OVERRIDES
  // ===========================================================================

  /// Custom background color override.
  final Color? backgroundColor;

  /// Custom text and icon color override.
  final Color? textColor;

  /// Custom border color override.
  final Color? borderColor;

  /// Custom delete icon color override.
  final Color? deleteIconColor;

  /// Custom border radius override. Defaults to pill shape.
  final BorderRadiusGeometry? borderRadius;

  /// Custom padding inside the chip.
  final EdgeInsetsGeometry? padding;

  /// Custom text style override for the label.
  final TextStyle? labelStyle;

  /// Custom height override.
  final double? height;

  /// Custom border width override.
  final double? borderWidth;

  /// Custom spacing between elements inside the chip.
  final double? spacing;

  /// Creates a [TectaChip] tag or input chip.
  const TectaChip({
    super.key,
    required this.label,
    this.onTap,
    this.onDelete,
    this.deleteIcon,
    this.avatar,
    this.icon,
    this.variant = TectaChipVariant.filled,
    this.color,
    this.size = TectaChipSize.medium,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.deleteIconColor,
    this.borderRadius,
    this.padding,
    this.labelStyle,
    this.height,
    this.borderWidth,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBgColor = _getBgColor(context);
    final defaultTextColor = _getTextColor(context);
    final defaultBorder = _getBorder(context, defaultTextColor);

    final finalBgColor = backgroundColor ?? defaultBgColor;
    final finalTextColor = textColor ?? defaultTextColor;
    final finalBorder = (borderColor != null || borderWidth != null || defaultBorder != null)
        ? Border.all(
            color: borderColor ?? (defaultBorder?.top.color ?? finalTextColor),
            width: borderWidth ?? (defaultBorder?.top.width ?? 1.0),
          )
        : null;
    final finalBorderRadius = borderRadius ?? BorderRadius.circular(50.0);

    // Height & Padding scale
    final double defaultHeight = size == TectaChipSize.small ? 24.0 : 32.0;
    final finalHeight = height ?? defaultHeight;

    final double startPadding = avatar != null
        ? 4.0
        : (icon != null ? 8.0 : (size == TectaChipSize.small ? 8.0 : 12.0));
    final double endPadding = onDelete != null ? 4.0 : (size == TectaChipSize.small ? 8.0 : 12.0);

    final finalPadding = padding ?? EdgeInsets.only(left: startPadding, right: endPadding);

    // Label Font Size
    final TextStyle defaultLabelStyle = size == TectaChipSize.small
        ? TectaTypography.caption.copyWith(fontWeight: FontWeight.w500)
        : TectaTypography.body2.copyWith(fontWeight: FontWeight.w500);

    final finalLabelStyle = (labelStyle ?? defaultLabelStyle).copyWith(color: finalTextColor);

    // Render leading widget
    Widget? leadingWidget;
    if (avatar != null) {
      Widget finalAvatar = avatar!;
      if (finalAvatar is TectaAvatar) {
        final avatarBg =
            finalAvatar.backgroundColor ?? _getAvatarBgColor(context, finalBgColor, finalTextColor);
        final avatarText =
            finalAvatar.textColor ?? _getAvatarTextColor(context, finalBgColor, finalTextColor);
        finalAvatar = TectaAvatar(
          key: finalAvatar.key,
          image: finalAvatar.image,
          text: finalAvatar.text,
          icon: finalAvatar.icon,
          size: size == TectaChipSize.small ? 18.0 : 24.0,
          shape: finalAvatar.shape,
          badge: finalAvatar.badge,
          backgroundColor: avatarBg,
          textColor: avatarText,
          border: finalAvatar.border,
          borderRadius: finalAvatar.borderRadius,
          textStyle: finalAvatar.textStyle,
        );
      }
      leadingWidget = SizedBox(
        width: size == TectaChipSize.small ? 18.0 : 24.0,
        height: size == TectaChipSize.small ? 18.0 : 24.0,
        child: ClipOval(child: finalAvatar),
      );
    } else if (icon != null) {
      leadingWidget = IconTheme.merge(
        data: IconThemeData(
          color: finalTextColor,
          size: size == TectaChipSize.small ? 14.0 : 18.0,
        ),
        child: icon!,
      );
    }

    final Color activeColor = color != null ? TectaColors.resolve(context, color!) : TectaColors.primaryMain;

    // Render delete action
    Widget? trailingWidget;
    if (onDelete != null) {
      trailingWidget = Semantics(
        button: true,
        label: 'Delete $label',
        child: GestureDetector(
          onTap: isEnabled ? onDelete : null,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child:
                deleteIcon ??
                Container(
                  width: size == TectaChipSize.small ? 14.0 : 16.0,
                  height: size == TectaChipSize.small ? 14.0 : 16.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: variant == TectaChipVariant.filled
                        ? (color == null
                            ? Colors.black.withValues(alpha: 0.12)
                            : (activeColor.computeLuminance() > 0.5
                                ? Colors.black.withValues(alpha: 0.12)
                                : Colors.white.withValues(alpha: 0.2)))
                        : finalTextColor.withValues(alpha: 0.12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.close,
                      size: size == TectaChipSize.small ? 8.0 : 10.0,
                      color: variant == TectaChipVariant.filled
                          ? (activeColor.computeLuminance() > 0.5 ? finalTextColor : Colors.white)
                          : finalTextColor,
                    ),
                  ),
                ),
          ),
        ),
      );
    }

    // Main chip layout
    Widget chipContent = Material(
      color: finalBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: finalBorderRadius,
        side: finalBorder != null
            ? BorderSide(
                color: finalBorder.top.color,
                width: finalBorder.top.width,
                style: finalBorder.top.style,
              )
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        child: Container(
          height: finalHeight,
          padding: finalPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leadingWidget != null) ...[leadingWidget, SizedBox(width: spacing ?? 6.0)],
              Text(label, style: finalLabelStyle),
              if (trailingWidget != null) ...[SizedBox(width: spacing ?? 4.0), trailingWidget],
            ],
          ),
        ),
      ),
    );

    return Opacity(opacity: isEnabled ? 1.0 : 0.48, child: chipContent);
  }

  Color _getBgColor(BuildContext context) {
    final Color activeColor = color != null ? TectaColors.resolve(context, color!) : TectaColors.primaryMain;

    switch (variant) {
      case TectaChipVariant.filled:
        if (color == null) {
          return TectaColors.grey200;
        }
        return activeColor;
      case TectaChipVariant.outlined:
        return Colors.transparent;
      case TectaChipVariant.soft:
        if (color == null) {
          return TectaColors.grey500.withValues(alpha: 0.08);
        }
        return activeColor.withValues(alpha: 0.12);
    }
  }

  Color _getTextColor(BuildContext context) {
    final Color activeColor = color != null ? TectaColors.resolve(context, color!) : TectaColors.primaryMain;

    switch (variant) {
      case TectaChipVariant.filled:
        if (color == null) {
          return TectaColors.grey800;
        }
        if (color == TectaColors.warningMain) {
          return TectaColors.warningDarker;
        }
        return activeColor.computeLuminance() > 0.5 ? TectaColors.grey900 : TectaColors.white;
      case TectaChipVariant.outlined:
        if (color == null) {
          return TectaColors.grey800;
        }
        return activeColor;
      case TectaChipVariant.soft:
        if (color == null) {
          return TectaColors.grey800;
        }
        return activeColor.computeLuminance() > 0.5 ? TectaColors.grey900 : activeColor;
    }
  }

  Border? _getBorder(BuildContext context, Color fallbackColor) {
    if (variant == TectaChipVariant.outlined) {
      if (color == null) {
        return Border.all(color: TectaColors.grey300.withValues(alpha: 0.6));
      }
      return Border.all(color: fallbackColor.withValues(alpha: 0.24));
    }
    return null;
  }

  Color _getAvatarBgColor(BuildContext context, Color chipBg, Color chipText) {
    final Color activeColor = color != null ? TectaColors.resolve(context, color!) : TectaColors.primaryMain;

    if (variant == TectaChipVariant.filled) {
      if (color == null) {
        return Colors.black.withValues(alpha: 0.16);
      }
      if (activeColor == TectaColors.grey900 ||
          activeColor == TectaColors.secondaryMain ||
          activeColor == TectaColors.errorMain) {
        return Colors.white.withValues(alpha: 0.24);
      }
      return Colors.black.withValues(alpha: 0.16);
    } else {
      if (color == null) {
        return TectaColors.grey500;
      }
      return activeColor;
    }
  }

  Color _getAvatarTextColor(BuildContext context, Color chipBg, Color chipText) {
    if (variant == TectaChipVariant.filled) {
      return chipText;
    } else {
      if (color == TectaColors.warningMain) {
        return TectaColors.warningDarker;
      }
      return TectaColors.white;
    }
  }
}
