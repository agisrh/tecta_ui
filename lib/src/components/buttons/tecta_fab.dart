import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium Floating Action Button (FAB) supporting circular and extended variants.
///
/// Features:
/// - Circular (icon-only) and Extended (icon + label) modes.
/// - Four visual variants: `contained` (default), `outlined`, `soft`, `text`.
/// - Nine color themes including semantic and brand colors.
/// - Three size presets with full dynamic overrides for dimensions.
/// - Fully dynamic style overrides: backgroundColor, contentColor, borderColor,
///   borderWidth, borderRadius, labelStyle, iconSize, elevation, shadow.
class TectaFab extends StatelessWidget {
  /// The icon widget.
  final Widget icon;

  /// Optional text label. If provided, renders as an Extended FAB.
  final String? label;

  /// Callback when pressed. If null, the button is disabled.
  final VoidCallback? onPressed;

  /// Style variant. Defaults to [TectaButtonVariant.contained].
  final TectaButtonVariant variant;

  /// Theme color. Defaults to Theme.of(context).colorScheme.primary.
  final Color? color;

  /// Sizing scale of the FAB. Defaults to [TectaButtonSize.large].
  final TectaButtonSize size;

  // ===========================================================================
  // DYNAMIC STYLING OVERRIDES
  // ===========================================================================

  /// Custom background color override.
  final Color? backgroundColor;

  /// Custom content (icon + text) color override.
  final Color? contentColor;

  /// Custom border color override.
  final Color? borderColor;

  /// Custom border width. Defaults to `1.0`.
  final double? borderWidth;

  /// Custom border radius for extended FAB. Ignored for circular.
  final BorderRadiusGeometry? borderRadius;

  /// Custom label text style override.
  final TextStyle? labelStyle;

  /// Custom icon size override.
  final double? iconSizeOverride;

  /// Custom FAB height override.
  final double? fabHeight;

  /// Custom horizontal padding for extended FAB.
  final double? horizontalPadding;

  /// Custom spacing between icon and label in extended mode.
  final double? spacingOverride;

  /// Custom elevation / shadow blur. 0 disables shadow.
  final double? elevation;

  /// Creates a [TectaFab] floating action button component.
  const TectaFab({
    super.key,
    required this.icon,
    this.label,
    this.onPressed,
    this.variant = TectaButtonVariant.contained,
    this.color,
    this.size = TectaButtonSize.large,
    this.backgroundColor,
    this.contentColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.labelStyle,
    this.iconSizeOverride,
    this.fabHeight,
    this.horizontalPadding,
    this.spacingOverride,
    this.elevation,
  });

  bool get _isEnabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final double height = fabHeight ?? _getDefaultHeight();
    final double iconSize = iconSizeOverride ?? _getDefaultIconSize();
    final double spacing = spacingOverride ?? _getDefaultSpacing();
    final double hPadding = horizontalPadding ?? _getDefaultHorizontalPadding();
    final double fontSize = _getDefaultFontSize();
    final double resolvedBorderWidth = borderWidth ?? 1.0;
    final isExtended = label != null;

    final bgColor = backgroundColor ?? _getBgColor(context);
    final resolvedContentColor = contentColor ?? _getContentColor(context);
    final borderCol = borderColor ?? _getBorderColor(resolvedContentColor);

    Widget body = IconTheme(
      data: IconThemeData(color: resolvedContentColor, size: iconSize),
      child: icon,
    );

    if (isExtended) {
      final resolvedLabelStyle = (labelStyle ?? const TextStyle()).copyWith(
        fontFamily: labelStyle?.fontFamily ?? 'Google Sans',
        fontSize: labelStyle?.fontSize ?? fontSize,
        fontWeight: labelStyle?.fontWeight ?? FontWeight.w700,
        color: labelStyle?.color ?? resolvedContentColor,
      );

      body = Padding(
        padding: EdgeInsets.symmetric(horizontal: hPadding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            body,
            SizedBox(width: spacing),
            Text(label!, style: resolvedLabelStyle),
          ],
        ),
      );
    }

    // Resolve shape/border radius
    final ShapeBorder inkShape;
    final BorderRadiusGeometry? containerRadius;

    if (isExtended) {
      final resolvedRadius = borderRadius ?? BorderRadius.circular(height / 2);
      inkShape = RoundedRectangleBorder(borderRadius: resolvedRadius as BorderRadius);
      containerRadius = resolvedRadius;
    } else {
      inkShape = const CircleBorder();
      containerRadius = null;
    }

    Widget fabWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: height,
      width: isExtended ? null : height,
      decoration: BoxDecoration(
        color: _isEnabled ? bgColor : _getDisabledBgColor(),
        shape: isExtended ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: containerRadius,
        border: borderCol != null ? Border.all(color: borderCol, width: resolvedBorderWidth) : null,
        boxShadow: _getShadow(bgColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isEnabled ? onPressed : null,
          customBorder: inkShape,
          splashColor: resolvedContentColor.withValues(alpha: 0.12),
          highlightColor: Colors.transparent,
          child: Center(child: body),
        ),
      ),
    );

    return Semantics(button: true, enabled: _isEnabled, child: fabWidget);
  }

  // ===========================================================================
  // STYLING & DIMENSION RESOLVERS
  // ===========================================================================

  double _getDefaultHeight() {
    switch (size) {
      case TectaButtonSize.small:
        return 40.0;
      case TectaButtonSize.medium:
        return 48.0;
      case TectaButtonSize.large:
      case TectaButtonSize.xLarge:
        return 56.0;
    }
  }

  double _getDefaultIconSize() {
    switch (size) {
      case TectaButtonSize.small:
        return 18.0;
      case TectaButtonSize.medium:
        return 20.0;
      case TectaButtonSize.large:
      case TectaButtonSize.xLarge:
        return 24.0;
    }
  }

  double _getDefaultHorizontalPadding() {
    switch (size) {
      case TectaButtonSize.small:
        return 12.0;
      case TectaButtonSize.medium:
        return 16.0;
      case TectaButtonSize.large:
      case TectaButtonSize.xLarge:
        return 20.0;
    }
  }

  double _getDefaultSpacing() {
    switch (size) {
      case TectaButtonSize.small:
        return 6.0;
      case TectaButtonSize.medium:
        return 8.0;
      case TectaButtonSize.large:
      case TectaButtonSize.xLarge:
        return 10.0;
    }
  }

  double _getDefaultFontSize() {
    switch (size) {
      case TectaButtonSize.small:
        return 13.0;
      case TectaButtonSize.medium:
        return 14.0;
      case TectaButtonSize.large:
      case TectaButtonSize.xLarge:
        return 15.0;
    }
  }

  Color _getBgColor(BuildContext context) {
    if (variant == TectaButtonVariant.outlined) {
      return Colors.transparent;
    }

    final resolvedColor = TectaColors.resolve(context, color ?? Theme.of(context).colorScheme.primary);

    if (variant == TectaButtonVariant.soft) {
      if (resolvedColor == TectaColors.primaryMain || resolvedColor == Theme.of(context).colorScheme.primary) {
        return TectaColors.primaryLighter;
      } else if (resolvedColor == TectaColors.secondaryMain) {
        return TectaColors.secondaryLighter;
      } else if (resolvedColor == TectaColors.infoMain) {
        return TectaColors.infoLighter;
      } else if (resolvedColor == TectaColors.successMain) {
        return TectaColors.successLighter;
      } else if (resolvedColor == TectaColors.warningMain) {
        return TectaColors.warningLighter;
      } else if (resolvedColor == TectaColors.errorMain) {
        return TectaColors.errorLighter;
      } else if (resolvedColor == TectaColors.white) {
        return TectaColors.white.withValues(alpha: 0.15);
      }
      return resolvedColor.withValues(alpha: 0.12);
    }

    // Contained background
    if (resolvedColor == TectaColors.grey800 || resolvedColor == TectaColors.white) {
      return Theme.of(context).brightness == Brightness.dark ? TectaColors.grey900 : TectaColors.grey50;
    }
    return resolvedColor;
  }

  Color _getDisabledBgColor() {
    if (variant == TectaButtonVariant.outlined) {
      return Colors.transparent;
    }
    return TectaColors.grey200;
  }

  Color _getContentColor(BuildContext context) {
    if (!_isEnabled) {
      return TectaColors.grey500;
    }

    final resolvedColor = TectaColors.resolve(context, color ?? Theme.of(context).colorScheme.primary);

    if (variant == TectaButtonVariant.soft) {
      if (resolvedColor == TectaColors.primaryMain || resolvedColor == Theme.of(context).colorScheme.primary) {
        return TectaColors.primaryDark;
      } else if (resolvedColor == TectaColors.secondaryMain) {
        return TectaColors.secondaryDark;
      } else if (resolvedColor == TectaColors.infoMain) {
        return TectaColors.infoDark;
      } else if (resolvedColor == TectaColors.successMain) {
        return TectaColors.successDark;
      } else if (resolvedColor == TectaColors.warningMain) {
        return TectaColors.warningDarker;
      } else if (resolvedColor == TectaColors.errorMain) {
        return TectaColors.errorDark;
      } else if (resolvedColor == TectaColors.white) {
        return TectaColors.white;
      }
      return resolvedColor;
    }

    if (variant == TectaButtonVariant.outlined) {
      return resolvedColor;
    }

    // Contained
    if (resolvedColor == TectaColors.warningMain) {
      return TectaColors.warningDarker;
    }
    if (resolvedColor == TectaColors.white || resolvedColor == TectaColors.grey800) {
      return TectaColors.grey800;
    }
    return resolvedColor.computeLuminance() > 0.5 ? TectaColors.grey800 : TectaColors.white;
  }

  Color? _getBorderColor(Color contentClr) {
    if (variant != TectaButtonVariant.outlined) {
      return null;
    }
    if (!_isEnabled) {
      return TectaColors.grey300;
    }
    return contentClr.withValues(alpha: 0.24);
  }

  List<BoxShadow>? _getShadow(Color bgColor) {
    // If elevation is explicitly 0, no shadow
    if (elevation != null && elevation! <= 0) return null;
    if (!_isEnabled || variant != TectaButtonVariant.contained) return null;

    final double blurAmount = elevation ?? 16.0;
    final double offsetAmount = elevation != null ? elevation! / 2 : 8.0;

    // Premium floating drop shadow using the base color with soft opacity
    return [
      BoxShadow(
        color: bgColor.withValues(alpha: 0.28),
        blurRadius: blurAmount,
        spreadRadius: 0,
        offset: Offset(0, offsetAmount),
      ),
      BoxShadow(
        color: bgColor.withValues(alpha: 0.12),
        blurRadius: blurAmount / 4,
        spreadRadius: 0,
        offset: Offset(0, offsetAmount / 4),
      ),
    ];
  }
}
