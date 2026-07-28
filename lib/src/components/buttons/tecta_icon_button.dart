import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium circular icon-only button.
///
/// Features:
/// - Supports all four visual variants: `text` (default), `contained`, `outlined`, `soft`.
/// - Nine color themes including semantic and brand colors.
/// - Four size presets with full dynamic override for diameter and icon size.
/// - Micro-animations for hover/press scale transitions when `animate: true`.
/// - Fully dynamic style overrides: backgroundColor, iconColor, borderColor,
///   borderWidth, diameter, iconSize, splashColor, tooltip.
class TectaIconButton extends StatefulWidget {
  /// The icon widget to display.
  final Widget icon;

  /// Callback when button is pressed. If null, the button is disabled.
  final VoidCallback? onPressed;

  /// Theme color of the icon button. Defaults to [TectaColors.grey800].
  final Color color;

  /// Size of the button. Defaults to [TectaButtonSize.medium].
  final TectaButtonSize size;

  /// Visual variant. Defaults to [TectaButtonVariant.text].
  final TectaButtonVariant variant;

  /// Whether to enable custom micro-animations (e.g. scale feedback on hover/press).
  final bool animate;

  // ===========================================================================
  // DYNAMIC STYLING OVERRIDES
  // ===========================================================================

  /// Custom background color override.
  final Color? backgroundColor;

  /// Custom icon color override.
  final Color? iconColor;

  /// Custom border color override.
  final Color? borderColor;

  /// Custom border width. Defaults to `1.0`.
  final double? borderWidth;

  /// Custom diameter override (the total width/height of the circular button).
  final double? diameter;

  /// Custom icon size override (the icon's intrinsic size inside the circle).
  final double? iconSizeOverride;

  /// Custom splash color override.
  final Color? splashColor;

  /// Optional tooltip shown on long-press.
  final String? tooltip;

  /// Creates a [TectaIconButton] component.
  const TectaIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color = TectaColors.grey800,
    this.size = TectaButtonSize.medium,
    this.variant = TectaButtonVariant.text,
    this.animate = false,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.borderWidth,
    this.diameter,
    this.iconSizeOverride,
    this.splashColor,
    this.tooltip,
  });

  @override
  State<TectaIconButton> createState() => _TectaIconButtonState();
}

class _TectaIconButtonState extends State<TectaIconButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  bool get _isEnabled => widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    final double resolvedDiameter = widget.diameter ?? _getDefaultDiameter();
    final double resolvedIconSize = widget.iconSizeOverride ?? _getDefaultIconSize();
    final double resolvedBorderWidth = widget.borderWidth ?? 1.0;

    // 1. Resolve Colors
    final bgColor = widget.backgroundColor ?? _getBgColor(context);
    final contentColor = widget.iconColor ?? _getContentColor(context);
    final borderCol = widget.borderColor ?? _getBorderColor(contentColor);
    final resolvedSplashColor = widget.splashColor ?? contentColor.withValues(alpha: 0.12);

    Widget innerIcon = IconTheme(
      data: IconThemeData(color: contentColor, size: resolvedIconSize),
      child: widget.icon,
    );

    // Apply scale animation if animated
    if (widget.animate && _isEnabled) {
      double scale = 1.0;
      if (_isPressed) {
        scale = 0.92;
      } else if (_isHovered) {
        scale = 1.08;
      }
      innerIcon = AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        child: innerIcon,
      );
    }

    Widget buttonContent = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: resolvedDiameter,
      height: resolvedDiameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _isEnabled ? bgColor : _getDisabledBgColor(),
        border: borderCol != null ? Border.all(color: borderCol, width: resolvedBorderWidth) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          customBorder: const CircleBorder(),
          splashColor: resolvedSplashColor,
          highlightColor: Colors.transparent,
          child: Center(child: innerIcon),
        ),
      ),
    );

    if (widget.tooltip != null) {
      buttonContent = Tooltip(message: widget.tooltip!, child: buttonContent);
    }

    return Semantics(
      button: true,
      enabled: _isEnabled,
      child: FocusableActionDetector(
        onShowHoverHighlight: (hover) {
          if (widget.animate) {
            setState(() {
              _isHovered = hover;
            });
          }
        },
        child: GestureDetector(
          onTapDown: (_) {
            if (widget.animate && _isEnabled) {
              setState(() {
                _isPressed = true;
              });
            }
          },
          onTapUp: (_) {
            if (widget.animate && _isEnabled) {
              setState(() {
                _isPressed = false;
              });
            }
          },
          onTapCancel: () {
            if (widget.animate && _isEnabled) {
              setState(() {
                _isPressed = false;
              });
            }
          },
          child: buttonContent,
        ),
      ),
    );
  }

  // ===========================================================================
  // STYLING RESOLVERS
  // ===========================================================================

  double _getDefaultDiameter() {
    switch (widget.size) {
      case TectaButtonSize.small:
        return 30.0;
      case TectaButtonSize.medium:
        return 38.0;
      case TectaButtonSize.large:
        return 44.0;
      case TectaButtonSize.xLarge:
        return 50.0;
    }
  }

  double _getDefaultIconSize() {
    switch (widget.size) {
      case TectaButtonSize.small:
        return 16.0;
      case TectaButtonSize.medium:
        return 20.0;
      case TectaButtonSize.large:
        return 24.0;
      case TectaButtonSize.xLarge:
        return 28.0;
    }
  }

  Color _getBgColor(BuildContext context) {
    if (widget.variant == TectaButtonVariant.text ||
        widget.variant == TectaButtonVariant.outlined) {
      return Colors.transparent;
    }

    final resolvedColor = TectaColors.resolve(context, widget.color);

    if (widget.variant == TectaButtonVariant.soft) {
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

    // Contained style background
    return resolvedColor;
  }

  Color _getContentColor(BuildContext context) {
    if (!_isEnabled) {
      return TectaColors.grey500;
    }

    final resolvedColor = TectaColors.resolve(context, widget.color);

    if (widget.variant == TectaButtonVariant.contained) {
      if (resolvedColor == TectaColors.warningMain) {
        return TectaColors.warningDarker;
      }
      if (resolvedColor == TectaColors.white) {
        return TectaColors.grey800;
      }
      return resolvedColor.computeLuminance() > 0.5 ? TectaColors.grey800 : TectaColors.white;
    }

    if (widget.variant == TectaButtonVariant.soft) {
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

    // Outlined / Text style text colors
    if (resolvedColor == TectaColors.grey800 || resolvedColor == TectaColors.grey700) {
      return Theme.of(context).brightness == Brightness.dark ? TectaColors.white : TectaColors.grey800;
    }
    return resolvedColor;
  }

  Color? _getBorderColor(Color contentColor) {
    if (widget.variant != TectaButtonVariant.outlined) {
      return null;
    }
    if (!_isEnabled) {
      return TectaColors.grey300;
    }
    if (widget.color == TectaColors.grey800) {
      return TectaColors.grey300;
    }
    return contentColor.withValues(alpha: 0.48);
  }

  Color _getDisabledBgColor() {
    if (widget.variant == TectaButtonVariant.text ||
        widget.variant == TectaButtonVariant.outlined) {
      return Colors.transparent;
    }
    return TectaColors.grey200;
  }
}
