import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// The visual style variants supported by the [TectaBadge] component.
enum TectaBadgeVariant { standard, dot }

/// A premium, highly customizable Badge component for the Tecta Design System.
///
/// Features:
/// - Supports [TectaBadgeVariant.standard] (number/text) and [TectaBadgeVariant.dot] variants.
/// - Predefined and custom colors (accepts any Flutter [Color]).
/// - Adjustable overlap layouts (`isOverlapCircle`) to center-align with circular children (like avatars).
/// - Automatic count capping (e.g. renders `99+` if `count` exceeds `max`).
/// - Built-in separating borders to draw clean cutouts over wrapped widgets.
class TectaBadge extends StatelessWidget {
  /// The widget that the badge overlays.
  final Widget child;

  /// Custom string label inside the badge (e.g. "new").
  /// Mutually exclusive or alternative to [count].
  final String? label;

  /// An integer count value.
  final int? count;

  /// The maximum value displayed in the badge before rendering a plus sign (e.g. `99+`). Defaults to `99`.
  final int max;

  /// The visual variant style of the badge. Defaults to [TectaBadgeVariant.standard].
  final TectaBadgeVariant variant;

  /// The active color of the badge (accepts any Flutter [Color]). Defaults to [TectaColors.errorMain] (red).
  final Color? color;

  /// Whether to display the badge if [count] is 0. Defaults to `false`.
  final bool showZero;

  /// Shift the badge alignment inward to align cleanly with circular children (like avatars). Defaults to `false`.
  final bool isOverlapCircle;

  /// Custom background color override.
  final Color? backgroundColor;

  /// Custom text color override.
  final Color? textColor;

  /// Custom outer separating border color. Defaults to [ThemeData.cardColor] (White).
  final Color? borderColor;

  /// Custom outer separating border width. Defaults to `1.5` logical pixels.
  final double borderWidth;

  /// The alignment position of the badge relative to the child. Defaults to [Alignment.topRight].
  final AlignmentGeometry alignment;

  /// Creates a [TectaBadge] component to overlay status information on a child.
  const TectaBadge({
    super.key,
    required this.child,
    this.label,
    this.count,
    this.max = 99,
    this.variant = TectaBadgeVariant.standard,
    this.color,
    this.showZero = false,
    this.isOverlapCircle = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 1.5,
    this.alignment = Alignment.topRight,
  });

  @override
  Widget build(BuildContext context) {
    final bool shouldShow = _shouldShowBadge();

    if (!shouldShow) {
      return child;
    }

    final theme = Theme.of(context);
    final defaultBgColor = _getDefaultBgColor(context);
    final defaultTextColor = _getDefaultTextColor(context);

    final finalBgColor = backgroundColor ?? defaultBgColor;
    final finalTextColor = textColor ?? defaultTextColor;
    final finalBorderColor = borderColor ?? theme.cardColor;

    final resolvedLabel = _getLabel();

    final Widget badgeWidget = Container(
      key: const ValueKey('badge_container'),
      padding: variant == TectaBadgeVariant.dot
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
      constraints: BoxConstraints(
        minWidth: variant == TectaBadgeVariant.dot ? 10.0 : 18.0,
        minHeight: variant == TectaBadgeVariant.dot ? 10.0 : 18.0,
      ),
      decoration: BoxDecoration(
        color: finalBgColor,
        shape: variant == TectaBadgeVariant.dot ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: variant == TectaBadgeVariant.dot ? null : BorderRadius.circular(10.0),
        border: Border.all(color: finalBorderColor, width: borderWidth),
      ),
      alignment: Alignment.center,
      child: variant == TectaBadgeVariant.dot
          ? null
          : Text(
              resolvedLabel ?? '',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
                color: finalTextColor,
                height: 1.0,
              ),
            ),
    );

    // Resolve alignment to determine anchor corner.
    final resolvedAlignment = alignment.resolve(Directionality.of(context));

    // Step 1: Position badge at the anchor corner of the child.
    double? posTop;
    double? posRight;
    double? posBottom;
    double? posLeft;

    if (resolvedAlignment == Alignment.topRight) {
      posTop = 0;
      posRight = 0;
    } else if (resolvedAlignment == Alignment.topLeft) {
      posTop = 0;
      posLeft = 0;
    } else if (resolvedAlignment == Alignment.bottomRight) {
      posBottom = 0;
      posRight = 0;
    } else if (resolvedAlignment == Alignment.bottomLeft) {
      posBottom = 0;
      posLeft = 0;
    } else {
      posTop = 0;
      posRight = 0;
    }

    // Step 2: Use FractionalTranslation to CENTER the badge on the anchor corner.
    double dx = resolvedAlignment.x > 0 ? 0.5 : -0.5;
    double dy = resolvedAlignment.y < 0 ? -0.5 : 0.5;

    if (isOverlapCircle) {
      dx *= 0.5;
      dy *= 0.5;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: posTop,
          right: posRight,
          bottom: posBottom,
          left: posLeft,
          child: FractionalTranslation(translation: Offset(dx, dy), child: badgeWidget),
        ),
      ],
    );
  }

  bool _shouldShowBadge() {
    if (variant == TectaBadgeVariant.dot) {
      return true;
    }
    final localCount = count;
    if (localCount != null) {
      if (localCount == 0) {
        return showZero;
      }
      return true;
    }
    return label != null && label!.isNotEmpty;
  }

  String? _getLabel() {
    final localLabel = label;
    if (localLabel != null) {
      return localLabel;
    }
    final localCount = count;
    if (localCount != null) {
      if (localCount > max) {
        return '$max+';
      }
      return localCount.toString();
    }
    return null;
  }

  Color _getDefaultBgColor(BuildContext context) {
    final Color activeColor = color ?? TectaColors.errorMain;
    return TectaColors.resolve(context, activeColor);
  }

  Color _getDefaultTextColor(BuildContext context) {
    final Color activeBg = _getDefaultBgColor(context);
    if (color == TectaColors.warningMain) {
      return TectaColors.warningDarker;
    }
    if (color == null) {
      return TectaColors.white;
    }
    return activeBg.computeLuminance() > 0.5 ? TectaColors.grey900 : TectaColors.white;
  }
}
