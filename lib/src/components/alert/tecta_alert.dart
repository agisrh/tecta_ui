import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// The severity levels supported by the [TectaAlert] component.
enum TectaAlertSeverity {
  /// Success status showing green background/text.
  success,
  /// Info status showing blue background/text.
  info,
  /// Warning status showing orange background/text.
  warning,
  /// Error status showing red background/text.
  error
}

/// The visual style variants supported by the [TectaAlert] component.
enum TectaAlertVariant {
  /// Translucent background with dark text color.
  soft,
  /// Solid background with white or dark text.
  filled,
  /// Transparent background with colored border.
  outlined,
  /// Premium grid background with fading gradient, floating icon, and subtle border.
  banner
}

/// A premium, highly customizable Alert component for the Tecta Design System.
///
/// Features:
/// - Three visual variants: [TectaAlertVariant.soft] (default), [TectaAlertVariant.filled], and [TectaAlertVariant.outlined].
/// - Four severity types: success, info, warning, and error.
/// - Highly dynamic styling overrides for backgrounds, text styles, icons, borders, margins, and padding.
/// - Support for optional title, leading widget, action widget, and onClose callback.
class TectaAlert extends StatelessWidget {
  /// The optional title of the alert, rendered in a bold typography.
  final String? title;

  /// The body message text of the alert. Mutually exclusive with [child].
  final String? message;

  /// A custom child widget to display in place of the message body. Mutually exclusive with [message].
  final Widget? child;

  /// The severity level of the alert. Defaults to [TectaAlertSeverity.info].
  final TectaAlertSeverity severity;

  /// The visual variant style of the alert. Defaults to [TectaAlertVariant.soft].
  final TectaAlertVariant variant;

  /// Optional leading widget. If not specified, a default solar icon corresponding to the severity is used.
  final Widget? leading;

  /// Optional action widget on the right side of the alert (e.g., text buttons).
  final Widget? action;

  /// Callback executed when the close button is tapped. Shows a close button on the right if provided.
  final VoidCallback? onClose;

  // ===========================================================================
  // DYNAMIC STYLING OVERRIDES
  // ===========================================================================

  /// Custom TextStyle for the title. Defaults to `TectaTypography.subtitle2`.
  final TextStyle? titleStyle;

  /// Custom TextStyle for the message. Defaults to `TectaTypography.body2`.
  final TextStyle? messageStyle;

  /// Custom size for the leading icon. Defaults to `24.0`.
  final double? iconSize;

  /// Custom color for the leading status icon.
  final Color? iconColor;

  /// Custom color for the close button icon.
  final Color? closeIconColor;

  /// Custom background color override.
  final Color? backgroundColor;

  /// Custom border radius override. Defaults to `BorderRadius.circular(12.0)`.
  final BorderRadiusGeometry? borderRadius;

  /// Custom border decoration.
  final BoxBorder? border;

  /// Custom padding inside the alert container. Defaults to `EdgeInsets.all(16.0)`.
  final EdgeInsetsGeometry? padding;

  /// Custom margins around the alert container.
  final EdgeInsetsGeometry? margin;

  /// Custom cross axis alignment of the main row.
  /// Defaults to [CrossAxisAlignment.center] if [title] is null,
  /// and [CrossAxisAlignment.start] if [title] is not null.
  final CrossAxisAlignment? crossAxisAlignment;

  /// Creates a [TectaAlert] status/feedback widget.
  const TectaAlert({
    super.key,
    this.title,
    this.message,
    this.child,
    this.severity = TectaAlertSeverity.info,
    this.variant = TectaAlertVariant.soft,
    this.leading,
    this.action,
    this.onClose,
    this.titleStyle,
    this.messageStyle,
    this.iconSize,
    this.iconColor,
    this.closeIconColor,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(16.0),
    this.crossAxisAlignment,
  }) : assert(
         (message != null) ^ (child != null),
         'You must provide either message or child, but not both.',
       );

  @override
  Widget build(BuildContext context) {
    final localTitle = title;
    final localMessage = message;
    final localChild = child;

    final defaultBgColor = _getDefaultBgColor(severity, variant);
    final defaultTextColor = _getDefaultTextColor(severity, variant);
    final defaultBorder = _getDefaultBorder(severity, variant);

    final finalBgColor = backgroundColor ?? defaultBgColor;
    final finalBorder = border ?? defaultBorder;
    final finalBorderRadius = borderRadius ?? BorderRadius.circular(12.0);

    final finalTitleStyle = (titleStyle ?? TectaTypography.subtitle2).copyWith(
      color: titleStyle?.color ?? defaultTextColor,
      fontWeight: titleStyle?.fontWeight ?? FontWeight.w700,
    );

    final finalMessageStyle = (messageStyle ?? TectaTypography.body2).copyWith(
      color: messageStyle?.color ?? defaultTextColor,
    );

    final resolvedIconColor = iconColor ?? _getDefaultIconColor(severity, variant);
    final resolvedIconSize = iconSize ?? 24.0;

    Widget? leadingWidget = leading;
    if (leadingWidget == null) {
      final IconData iconData;

      // Standard (Soft) and Outlined use bold/filled icons.
      // Filled uses linear/outline icons (except warning which uses bold/filled for visibility).
      if (variant == TectaAlertVariant.filled) {
        switch (severity) {
          case TectaAlertSeverity.success:
            iconData = SolarLinearIcons.checkCircle;
            break;
          case TectaAlertSeverity.info:
            iconData = SolarLinearIcons.infoCircle;
            break;
          case TectaAlertSeverity.warning:
            iconData = SolarBoldIcons.dangerTriangle;
            break;
          case TectaAlertSeverity.error:
            iconData = SolarLinearIcons.dangerCircle;
            break;
        }
      } else {
        switch (severity) {
          case TectaAlertSeverity.success:
            iconData = SolarBoldIcons.checkCircle;
            break;
          case TectaAlertSeverity.info:
            iconData = SolarBoldIcons.infoCircle;
            break;
          case TectaAlertSeverity.warning:
            iconData = SolarBoldIcons.dangerTriangle;
            break;
          case TectaAlertSeverity.error:
            iconData = SolarBoldIcons.dangerCircle;
            break;
        }
      }

      leadingWidget = Icon(iconData, color: resolvedIconColor, size: resolvedIconSize);
    }

    final accessibilityLabel =
        '${severity.name.toUpperCase()} alert. '
        '${localTitle != null ? "$localTitle. " : ""}'
        '${localMessage ?? ""}';

    final resolvedCrossAxisAlignment =
        crossAxisAlignment ??
        (localTitle == null ? CrossAxisAlignment.center : CrossAxisAlignment.start);

    if (variant == TectaAlertVariant.banner) {
      final accentColor = resolvedIconColor;
      final IconData bannerIcon;
      switch (severity) {
        case TectaAlertSeverity.success:
          bannerIcon = SolarBoldIcons.checkCircle;
          break;
        case TectaAlertSeverity.info:
          bannerIcon = SolarBoldIcons.infoCircle;
          break;
        case TectaAlertSeverity.warning:
          bannerIcon = SolarBoldIcons.dangerTriangle;
          break;
        case TectaAlertSeverity.error:
          bannerIcon = SolarBoldIcons.dangerCircle;
          break;
      }

      final floatingIcon = leading ??
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              bannerIcon,
              color: accentColor,
              size: iconSize ?? 16,
            ),
          );

      return Semantics(
        container: true,
        label: accessibilityLabel,
        child: Container(
          margin: margin,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: finalBgColor,
            borderRadius: finalBorderRadius,
            border: finalBorder,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _AlertBackgroundPainter(accentColor: accentColor),
                ),
              ),
              Padding(
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    floatingIcon,
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 2),
                          if (localTitle != null) ...[
                            Text(localTitle, style: finalTitleStyle),
                            const SizedBox(height: 4),
                          ],
                          if (localMessage != null) Text(localMessage, style: finalMessageStyle),
                          if (localChild != null) localChild,
                        ],
                      ),
                    ),
                    if (action != null) ...[const SizedBox(width: 8), action!],
                    if (onClose != null)
                      Semantics(
                        button: true,
                        label: 'Close Alert',
                        child: GestureDetector(
                          onTap: onClose,
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Icon(
                              SolarLinearIcons.close,
                              color: closeIconColor ?? TectaColors.grey600,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Semantics(
      container: true,
      label: accessibilityLabel,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: finalBgColor,
          borderRadius: finalBorderRadius,
          border: finalBorder,
        ),
        child: Row(
          crossAxisAlignment: resolvedCrossAxisAlignment,
          children: [
            leadingWidget,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (localTitle != null) ...[
                    Text(localTitle, style: finalTitleStyle),
                    const SizedBox(height: 4),
                  ],
                  if (localMessage != null) Text(localMessage, style: finalMessageStyle),
                  // ignore: use_null_aware_elements
                  if (localChild != null) localChild,
                ],
              ),
            ),
            if (action != null) ...[const SizedBox(width: 12), action!],
            if (onClose != null) ...[
              const SizedBox(width: 8),
              Semantics(
                button: true,
                label: 'Close Alert',
                child: GestureDetector(
                  onTap: onClose,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                    child: Icon(
                      SolarLinearIcons.close,
                      color: closeIconColor ?? defaultTextColor.withValues(alpha: 0.8),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getDefaultBgColor(TectaAlertSeverity severity, TectaAlertVariant variant) {
    if (variant == TectaAlertVariant.banner) {
      return Colors.white;
    }
    if (variant == TectaAlertVariant.filled) {
      switch (severity) {
        case TectaAlertSeverity.success:
          return TectaColors.successMain;
        case TectaAlertSeverity.info:
          return TectaColors.infoMain;
        case TectaAlertSeverity.warning:
          return TectaColors.warningMain;
        case TectaAlertSeverity.error:
          return TectaColors.errorMain;
      }
    } else if (variant == TectaAlertVariant.soft) {
      switch (severity) {
        case TectaAlertSeverity.success:
          return TectaColors.successLighter;
        case TectaAlertSeverity.info:
          return TectaColors.infoLighter;
        case TectaAlertSeverity.warning:
          return TectaColors.warningLighter;
        case TectaAlertSeverity.error:
          return TectaColors.errorLighter;
      }
    } else {
      // Outlined: has a very soft tint background
      switch (severity) {
        case TectaAlertSeverity.success:
          return TectaColors.successLighter.withValues(alpha: 0.3);
        case TectaAlertSeverity.info:
          return TectaColors.infoLighter.withValues(alpha: 0.3);
        case TectaAlertSeverity.warning:
          return TectaColors.warningLighter.withValues(alpha: 0.3);
        case TectaAlertSeverity.error:
          return TectaColors.errorLighter.withValues(alpha: 0.3);
      }
    }
  }

  Color _getDefaultTextColor(TectaAlertSeverity severity, TectaAlertVariant variant) {
    if (variant == TectaAlertVariant.banner) {
      return const Color(0xFF374151);
    }
    if (variant == TectaAlertVariant.filled) {
      if (severity == TectaAlertSeverity.warning) {
        return TectaColors.warningDarker; // Dark contrast on filled warning
      }
      return TectaColors.white;
    } else {
      // Soft and Outlined use the same dark high-contrast shades
      switch (severity) {
        case TectaAlertSeverity.success:
          return TectaColors.successDarker;
        case TectaAlertSeverity.info:
          return TectaColors.infoDarker;
        case TectaAlertSeverity.warning:
          return TectaColors.warningDarker;
        case TectaAlertSeverity.error:
          return TectaColors.errorDarker;
      }
    }
  }

  BoxBorder? _getDefaultBorder(TectaAlertSeverity severity, TectaAlertVariant variant) {
    if (variant == TectaAlertVariant.banner) {
      return Border.all(color: TectaColors.grey300, width: 0.25);
    }
    if (variant == TectaAlertVariant.outlined) {
      switch (severity) {
        case TectaAlertSeverity.success:
          return Border.all(color: TectaColors.successMain.withValues(alpha: 0.24));
        case TectaAlertSeverity.info:
          return Border.all(color: TectaColors.infoMain.withValues(alpha: 0.24));
        case TectaAlertSeverity.warning:
          return Border.all(color: TectaColors.warningMain.withValues(alpha: 0.24));
        case TectaAlertSeverity.error:
          return Border.all(color: TectaColors.errorMain.withValues(alpha: 0.24));
      }
    }
    return null;
  }

  Color _getDefaultIconColor(TectaAlertSeverity severity, TectaAlertVariant variant) {
    if (variant == TectaAlertVariant.banner) {
      switch (severity) {
        case TectaAlertSeverity.success:
          return const Color(0xFF059669);
        case TectaAlertSeverity.info:
          return const Color(0xFF1686F8);
        case TectaAlertSeverity.warning:
          return const Color(0xFFF59E0B);
        case TectaAlertSeverity.error:
          return const Color(0xFFEF5350);
      }
    }
    if (variant == TectaAlertVariant.filled) {
      if (severity == TectaAlertSeverity.warning) {
        return TectaColors.warningDarker;
      }
      return TectaColors.white;
    } else {
      switch (severity) {
        case TectaAlertSeverity.success:
          return TectaColors.successMain;
        case TectaAlertSeverity.info:
          return TectaColors.infoMain;
        case TectaAlertSeverity.warning:
          return TectaColors.warningMain;
        case TectaAlertSeverity.error:
          return TectaColors.errorMain;
      }
    }
  }
}

/// CustomPainter to paint the soft side-gradient and grid lines for premium Alert Banner.
class _AlertBackgroundPainter extends CustomPainter {
  final Color accentColor;

  _AlertBackgroundPainter({required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final gradientWidth = size.width * 0.15;

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          accentColor.withValues(alpha: 0.18),
          accentColor.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, gradientWidth, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, gradientWidth, size.height),
      gradientPaint,
    );

    const step = 16.0;
    final maxX = gradientWidth;

    for (double x = 0; x <= maxX; x += step) {
      final t = 1.0 - (x / maxX);
      final linePaint = Paint()
        ..color = accentColor.withValues(alpha: 0.18 * t)
        ..strokeWidth = 1.0;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }

    for (double y = 0; y <= size.height; y += step) {
      for (double x = 0; x <= maxX; x += 0.5) {
        final t = 1.0 - (x / maxX);
        final linePaint = Paint()
          ..color = accentColor.withValues(alpha: 0.18 * t)
          ..strokeWidth = 1.0;
        canvas.drawLine(Offset(x, y), Offset(math.min(x + 0.5, maxX), y), linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(_AlertBackgroundPainter oldDelegate) => oldDelegate.accentColor != accentColor;
}
