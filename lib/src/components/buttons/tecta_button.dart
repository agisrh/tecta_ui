import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Style variants for [TectaButton].
enum TectaButtonVariant { contained, outlined, text, soft }



/// Sizing options for [TectaButton].
enum TectaButtonSize { small, medium, large, xLarge }

/// Position of the spinner when [TectaButton.loading] is true.
enum TectaButtonLoadingPosition { start, end, center }

/// A premium, highly customizable button component for the Tecta Design System.
///
/// Features:
/// - Four visual variants: [TectaButtonVariant.contained] (default),
///   [TectaButtonVariant.outlined], [TectaButtonVariant.text], [TectaButtonVariant.soft].
/// - Nine color themes including semantic and brand colors.
/// - Four size presets with full override support for padding, font size, icon size, etc.
/// - Loading, icon, and trailing-icon support.
/// - Fully dynamic style overrides: borderRadius, labelStyle, borderWidth,
///   backgroundColor, textColor, borderColor, padding, iconSize, elevation.
class TectaButton extends StatelessWidget {
  /// The text label to display inside the button.
  final String label;

  /// Callback when button is pressed. If null, the button is disabled.
  final VoidCallback? onPressed;

  /// Visual variant of the button. Defaults to [TectaButtonVariant.contained].
  final TectaButtonVariant variant;

  /// Theme color of the button. Defaults to Theme.of(context).colorScheme.primary.
  final Color? color;

  /// Height and padding size of the button. Defaults to [TectaButtonSize.medium].
  final TectaButtonSize size;

  /// Optional leading icon widget.
  final Widget? icon;

  /// Optional trailing icon widget.
  final Widget? trailingIcon;

  /// Whether the button is in a loading state. Disables interaction and shows spinner.
  final bool loading;

  /// Optional label override to show specifically when in a loading state.
  final String? loadingLabel;

  /// Position of the loading spinner. Defaults to [TectaButtonLoadingPosition.start].
  final TectaButtonLoadingPosition loadingPosition;

  /// Whether the button should stretch to fill available horizontal space. Defaults to false.
  final bool fullWidth;

  // ===========================================================================
  // DYNAMIC STYLING OVERRIDES
  // ===========================================================================

  /// Custom background color override.
  final Color? backgroundColor;

  /// Custom text/icon color override.
  final Color? textColor;

  /// Custom border color override.
  final Color? borderColor;

  /// Custom border radius override.
  final BorderRadiusGeometry? borderRadius;

  /// Custom border width override. Defaults to `1.0`.
  final double? borderWidth;

  /// Custom label text style override.
  final TextStyle? labelStyle;

  /// Custom padding inside the button.
  final EdgeInsetsGeometry? padding;

  /// Custom height override.
  final double? height;

  /// Custom icon/loader size override.
  final double? iconSize;

  /// Custom spacing between icon and label.
  final double? spacing;

  /// Custom elevation/shadow override. If 0, no shadow is rendered.
  final double? elevation;

  /// Creates a [TectaButton] button component.
  const TectaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = TectaButtonVariant.contained,
    this.color,
    this.size = TectaButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.loading = false,
    this.loadingLabel,
    this.loadingPosition = TectaButtonLoadingPosition.start,
    this.fullWidth = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.labelStyle,
    this.padding,
    this.height,
    this.iconSize,
    this.spacing,
    this.elevation,
  });

  bool get _isEnabled => onPressed != null && !loading;

  @override
  Widget build(BuildContext context) {
    // 1. Resolve Colors
    final bgColor = backgroundColor ?? _getBgColor(context);
    final contentColor = textColor ?? _getContentColor(context);
    final borderCol = borderColor ?? _getBorderColor(contentColor);

    // 2. Resolve Size dimensions
    final double resolvedHeight = height ?? _getDefaultHeight();
    final double horizontalPadding = _getHorizontalPadding();
    final double textFontSize = _getFontSize();
    final double loaderSize = iconSize ?? _getLoaderSize();
    final double gap = spacing ?? _getSpacing();
    final radius = borderRadius ?? _getDefaultBorderRadius();
    final resolvedBorderWidth = borderWidth ?? 1.0;

    final textStyle = (labelStyle ?? const TextStyle()).copyWith(
      fontFamily: labelStyle?.fontFamily ?? 'Google Sans',
      fontSize: labelStyle?.fontSize ?? textFontSize,
      fontWeight: labelStyle?.fontWeight ?? FontWeight.w700,
      color: labelStyle?.color ?? contentColor,
    );

    // 3. Assemble child content
    Widget body;

    if (loading && loadingPosition == TectaButtonLoadingPosition.center) {
      body = SizedBox(
        width: loaderSize,
        height: loaderSize,
        child: CircularProgressIndicator(strokeWidth: 2.0, color: contentColor),
      );
    } else {
      final List<Widget> children = [];

      // Loader/Icon at start
      if (loading && loadingPosition == TectaButtonLoadingPosition.start) {
        children.add(
          SizedBox(
            width: loaderSize,
            height: loaderSize,
            child: CircularProgressIndicator(strokeWidth: 1.8, color: contentColor),
          ),
        );
        children.add(SizedBox(width: gap));
      } else if (icon != null) {
        children.add(
          IconTheme(
            data: IconThemeData(color: contentColor, size: loaderSize),
            child: icon!,
          ),
        );
        children.add(SizedBox(width: gap));
      }

      // Label Text
      final String activeLabel = (loading && loadingLabel != null) ? loadingLabel! : label;
      children.add(Text(activeLabel, style: textStyle, textAlign: TextAlign.center));

      // Loader/Icon at end
      if (loading && loadingPosition == TectaButtonLoadingPosition.end) {
        children.add(SizedBox(width: gap));
        children.add(
          SizedBox(
            width: loaderSize,
            height: loaderSize,
            child: CircularProgressIndicator(strokeWidth: 1.8, color: contentColor),
          ),
        );
      } else if (trailingIcon != null) {
        children.add(SizedBox(width: gap));
        children.add(
          IconTheme(
            data: IconThemeData(color: contentColor, size: loaderSize),
            child: trailingIcon!,
          ),
        );
      }

      body = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    }

    // Wrap with Material and InkWell
    Widget buttonWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: resolvedHeight,
      decoration: BoxDecoration(
        color: _isEnabled ? bgColor : _getDisabledBgColor(),
        borderRadius: radius,
        border: borderCol != null ? Border.all(color: borderCol, width: resolvedBorderWidth) : null,
        boxShadow: _getShadow(context, bgColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isEnabled ? onPressed : null,
          borderRadius: radius as BorderRadius?,
          splashColor: contentColor.withValues(alpha: 0.12),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Center(widthFactor: fullWidth ? null : 1.0, heightFactor: 1.0, child: body),
          ),
        ),
      ),
    );

    if (fullWidth) {
      buttonWidget = SizedBox(width: double.infinity, child: buttonWidget);
    }

    return Semantics(button: true, enabled: _isEnabled, child: buttonWidget);
  }

  // ===========================================================================
  // STYLING RESOLVERS
  // ===========================================================================

  Color _getBgColor(BuildContext context) {
    if (variant == TectaButtonVariant.text || variant == TectaButtonVariant.outlined) {
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

    // Contained styling
    return resolvedColor;
  }

  Color _getContentColor(BuildContext context) {
    if (!_isEnabled) {
      return TectaColors.grey500;
    }

    final resolvedColor = TectaColors.resolve(context, color ?? Theme.of(context).colorScheme.primary);

    // Contained has specific text contrasts
    if (variant == TectaButtonVariant.contained) {
      if (resolvedColor == TectaColors.warningMain) {
        return TectaColors.warningDarker; // Dark contrast
      }
      if (resolvedColor == TectaColors.white) {
        return TectaColors.grey800; // Dark contrast on white button
      }
      return resolvedColor.computeLuminance() > 0.5 ? TectaColors.grey800 : TectaColors.white;
    }

    // Soft uses darker shade of target color
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

    // Outlined / Text style text colors
    return resolvedColor;
  }

  Color? _getBorderColor(Color contentColor) {
    if (variant != TectaButtonVariant.outlined) {
      return null;
    }
    if (!_isEnabled) {
      return TectaColors.grey300;
    }
    return contentColor.withValues(alpha: 0.48);
  }

  Color _getDisabledBgColor() {
    if (variant == TectaButtonVariant.text || variant == TectaButtonVariant.outlined) {
      return Colors.transparent;
    }
    return TectaColors.grey200;
  }

  List<BoxShadow>? _getShadow(BuildContext context, Color resolvedColor) {
    // If elevation is explicitly set to 0, no shadow
    if (elevation != null && elevation! <= 0) return null;
    if (!_isEnabled || variant != TectaButtonVariant.contained) {
      return null;
    }

    final double blurAmount = elevation ?? 8.0;
    final double offsetAmount = elevation != null ? elevation! / 2 : 4.0;

    return [
      BoxShadow(
        color: resolvedColor.withValues(alpha: 0.24),
        blurRadius: blurAmount,
        offset: Offset(0, offsetAmount),
      ),
    ];
  }

  // ===========================================================================
  // DIMENSIONS RESOLVERS
  // ===========================================================================

  double _getDefaultHeight() {
    switch (size) {
      case TectaButtonSize.small:
        return 30.0;
      case TectaButtonSize.medium:
        return 36.0;
      case TectaButtonSize.large:
        return 42.0;
      case TectaButtonSize.xLarge:
        return 48.0;
    }
  }

  double _getHorizontalPadding() {
    switch (size) {
      case TectaButtonSize.small:
        return 10.0;
      case TectaButtonSize.medium:
        return 16.0;
      case TectaButtonSize.large:
        return 20.0;
      case TectaButtonSize.xLarge:
        return 24.0;
    }
  }

  double _getFontSize() {
    switch (size) {
      case TectaButtonSize.small:
        return 13.0;
      case TectaButtonSize.medium:
        return 14.0;
      case TectaButtonSize.large:
        return 15.0;
      case TectaButtonSize.xLarge:
        return 16.0;
    }
  }

  double _getLoaderSize() {
    switch (size) {
      case TectaButtonSize.small:
        return 14.0;
      case TectaButtonSize.medium:
        return 16.0;
      case TectaButtonSize.large:
        return 18.0;
      case TectaButtonSize.xLarge:
        return 20.0;
    }
  }

  double _getSpacing() {
    switch (size) {
      case TectaButtonSize.small:
        return 6.0;
      case TectaButtonSize.medium:
        return 8.0;
      case TectaButtonSize.large:
        return 10.0;
      case TectaButtonSize.xLarge:
        return 12.0;
    }
  }

  BorderRadiusGeometry _getDefaultBorderRadius() {
    switch (size) {
      case TectaButtonSize.small:
      case TectaButtonSize.medium:
      case TectaButtonSize.large:
        return BorderRadius.circular(8.0);
      case TectaButtonSize.xLarge:
        return BorderRadius.circular(10.0);
    }
  }
}
