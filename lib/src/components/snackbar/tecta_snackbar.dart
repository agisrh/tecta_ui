import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Visual variants for [TectaSnackbar].
enum TectaSnackbarVariant { minimal, info, success, warning, error, custom }

/// A premium, highly customizable Snackbar/Toast component matching Minimals design language.
///
/// Can be used as a standalone widget, inside a standard Flutter [SnackBar],
/// or shown globally as an animated overlay using [TectaSnackbar.show].
class TectaSnackbar extends StatelessWidget {
  /// The primary message text.
  final String message;

  /// Optional title text displayed above the message.
  final String? title;

  /// Optional detail text displayed below the message.
  final String? subText;

  /// The visual variant style. Defaults to [TectaSnackbarVariant.minimal].
  final TectaSnackbarVariant variant;

  /// Optional custom leading widget (usually an Icon). Overrides default variant icons.
  final Widget? leadingIcon;

  /// Optional action widget on the right (or bottom-right for multi-line).
  final Widget? action;

  /// Optional callback triggered when the close button is clicked.
  final VoidCallback? onClose;

  /// Custom background color override.
  final Color? backgroundColorOverride;

  /// Custom text color override.
  final Color? textColorOverride;

  /// Custom title text style override.
  final TextStyle? titleStyle;

  /// Custom message text style override.
  final TextStyle? messageStyle;

  /// Custom sub-text text style override.
  final TextStyle? subTextStyle;

  /// Custom border radius override.
  final double? borderRadius;

  /// Custom shadows override.
  final List<BoxShadow>? shadows;

  /// Custom border override.
  final Border? border;

  /// Custom background decoration override (allows gradients, custom borders, shapes).
  final Decoration? decorationOverride;

  /// Creates a [TectaSnackbar] message banner component.
  const TectaSnackbar({
    super.key,
    required this.message,
    this.title,
    this.subText,
    this.variant = TectaSnackbarVariant.minimal,
    this.leadingIcon,
    this.action,
    this.onClose,
    this.backgroundColorOverride,
    this.textColorOverride,
    this.titleStyle,
    this.messageStyle,
    this.subTextStyle,
    this.borderRadius,
    this.shadows,
    this.border,
    this.decorationOverride,
  });

  /// Displays the snackbar globally using an animated overlay on top of everything.
  ///
  /// [context] is used to find the overlay.
  /// [duration] specifies how long the snackbar remains visible (defaults to 3 seconds).
  /// [alignment] controls the screen position (defaults to [Alignment.topRight] on larger screens/web, [Alignment.topCenter] on mobile).
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    String? subText,
    TectaSnackbarVariant variant = TectaSnackbarVariant.minimal,
    Widget? leadingIcon,
    Widget? action,
    Duration duration = const Duration(seconds: 3),
    Alignment? alignment,
    Color? backgroundColorOverride,
    Color? textColorOverride,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    TextStyle? subTextStyle,
    double? borderRadius,
    List<BoxShadow>? shadows,
    Border? border,
    Decoration? decorationOverride,
  }) {
    final OverlayState overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    // Resolve responsiveness alignment
    final screenWidth = MediaQuery.of(context).size.width;
    final resolvedAlignment =
        alignment ?? (screenWidth > 600 ? Alignment.topRight : Alignment.topCenter);

    overlayEntry = OverlayEntry(
      builder: (context) {
        return _SnackbarOverlayPresenter(
          message: message,
          title: title,
          subText: subText,
          variant: variant,
          leadingIcon: leadingIcon,
          action: action,
          duration: duration,
          alignment: resolvedAlignment,
          backgroundColorOverride: backgroundColorOverride,
          textColorOverride: textColorOverride,
          titleStyle: titleStyle,
          messageStyle: messageStyle,
          subTextStyle: subTextStyle,
          borderRadius: borderRadius,
          shadows: shadows,
          border: border,
          decorationOverride: decorationOverride,
          onDismissed: () {
            overlayEntry.remove();
          },
        );
      },
    );

    overlayState.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = variant == TectaSnackbarVariant.minimal;

    // Resolve background & border colors
    final Color bg =
        backgroundColorOverride ?? (isDark ? TectaColors.grey800 : TectaColors.white);
    final List<BoxShadow> resolvedShadows = shadows ?? (isDark ? [] : TectaShadows.z8);
    final Border? resolvedBorder =
        border ??
        (isDark
            ? null
            : Border.all(color: TectaColors.grey200.withValues(alpha: 0.8), width: 1.0));

    final double resolvedRadius = borderRadius ?? 12.0;

    // Resolve Text Colors & Styles
    final Color defaultTitleColor = isDark ? TectaColors.white : TectaColors.grey800;
    final Color defaultMessageColor = isDark ? TectaColors.white : TectaColors.grey700;
    final Color defaultDetailColor = isDark ? TectaColors.grey400 : TectaColors.grey500;

    final resolvedTitleStyle =
        titleStyle ??
        TectaTypography.subtitle2.copyWith(color: textColorOverride ?? defaultTitleColor);

    final resolvedMessageStyle =
        messageStyle ??
        TectaTypography.body2.copyWith(color: textColorOverride ?? defaultMessageColor);

    final resolvedSubTextStyle =
        subTextStyle ?? TectaTypography.caption.copyWith(color: defaultDetailColor);

    // Resolve leading icon container
    Widget? resolvedLeading = leadingIcon;
    if (resolvedLeading == null && variant != TectaSnackbarVariant.minimal) {
      resolvedLeading = _buildVariantIcon();
    }

    final bool isSingleLine = title == null && subText == null;
    final bool showActionAtBottom = !isSingleLine && action != null;
    final rowAlignment = isSingleLine ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final double topOffset = isSingleLine ? 0.0 : 2.0;

    return Container(
      constraints: const BoxConstraints(maxWidth: 344),
      decoration: decorationOverride ?? BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(resolvedRadius),
        boxShadow: resolvedShadows,
        border: resolvedBorder,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: rowAlignment,
              children: [
                if (resolvedLeading != null) ...[
                  // Vertically align leading icon container accordingly
                  Padding(
                    padding: EdgeInsets.only(top: topOffset),
                    child: resolvedLeading,
                  ),
                  const SizedBox(width: 12.0),
                ],
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: topOffset),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null) ...[
                          Text(title!, style: resolvedTitleStyle),
                          const SizedBox(height: 4.0),
                        ],
                        Text(message, style: resolvedMessageStyle),
                        if (subText != null) ...[
                          const SizedBox(height: 4.0),
                          Text(subText!, style: resolvedSubTextStyle),
                        ],
                      ],
                    ),
                  ),
                ),
                if (action != null && !showActionAtBottom) ...[
                  const SizedBox(width: 12.0),
                  Padding(
                    padding: EdgeInsets.only(top: topOffset),
                    child: action!,
                  ),
                ],
                if (onClose != null) ...[
                  const SizedBox(width: 12.0),
                  Padding(
                    padding: EdgeInsets.only(top: topOffset),
                    child: GestureDetector(
                      onTap: onClose,
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? TectaColors.white.withValues(alpha: 0.08)
                              : TectaColors.grey200.withValues(alpha: 0.5),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 14,
                          color: isDark ? TectaColors.grey400 : TectaColors.grey600,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (showActionAtBottom) ...[
              const SizedBox(height: 8.0),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [action!]),
            ],
          ],
        ),
      ),
    );
  }

  Widget? _buildVariantIcon() {
    IconData iconData;
    Color iconColor;
    Color containerColor;

    switch (variant) {
      case TectaSnackbarVariant.success:
        iconData = Icons.check_circle;
        iconColor = TectaColors.successMain;
        containerColor = TectaColors.successLighter;
        break;
      case TectaSnackbarVariant.info:
        iconData = Icons.info;
        iconColor = TectaColors.infoMain;
        containerColor = TectaColors.infoLighter;
        break;
      case TectaSnackbarVariant.warning:
        iconData = Icons.warning;
        iconColor = TectaColors.warningMain;
        containerColor = TectaColors.warningLighter;
        break;
      case TectaSnackbarVariant.error:
        iconData = Icons.error;
        iconColor = TectaColors.errorMain;
        containerColor = TectaColors.errorLighter;
        break;
      default:
        return null;
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: containerColor, borderRadius: BorderRadius.circular(10.0)),
      child: Icon(iconData, color: iconColor, size: 20.0),
    );
  }
}

/// An internal stateful widget handling animations and timed dismissal for overlay toasts.
class _SnackbarOverlayPresenter extends StatefulWidget {
  final String message;
  final String? title;
  final String? subText;
  final TectaSnackbarVariant variant;
  final Widget? leadingIcon;
  final Widget? action;
  final Duration duration;
  final Alignment alignment;
  final Color? backgroundColorOverride;
  final Color? textColorOverride;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final TextStyle? subTextStyle;
  final double? borderRadius;
  final List<BoxShadow>? shadows;
  final Border? border;
  final Decoration? decorationOverride;
  final VoidCallback onDismissed;

  const _SnackbarOverlayPresenter({
    required this.message,
    this.title,
    this.subText,
    required this.variant,
    this.leadingIcon,
    this.action,
    required this.duration,
    required this.alignment,
    this.backgroundColorOverride,
    this.textColorOverride,
    this.titleStyle,
    this.messageStyle,
    this.subTextStyle,
    this.borderRadius,
    this.shadows,
    this.border,
    this.decorationOverride,
    required this.onDismissed,
  });

  @override
  State<_SnackbarOverlayPresenter> createState() => _SnackbarOverlayPresenterState();
}

class _SnackbarOverlayPresenterState extends State<_SnackbarOverlayPresenter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    // Resolve slide direction based on horizontal alignment
    final double slideOffsetX = widget.alignment.x > 0
        ? 1.5
        : (widget.alignment.x < 0 ? -1.5 : 0.0);
    final double slideOffsetY = widget.alignment.x == 0
        ? (widget.alignment.y > 0 ? 1.5 : -1.5)
        : 0.0;

    _slideAnimation = Tween<Offset>(
      begin: Offset(slideOffsetX, slideOffsetY),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    _dismissTimer = Timer(widget.duration, _dismiss);
  }

  void _dismiss() {
    _dismissTimer?.cancel();
    if (mounted) {
      _controller.reverse().then((_) {
        widget.onDismissed();
      });
    }
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: SafeArea(
        child: Align(
          alignment: widget.alignment,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Dismissible(
                  key: UniqueKey(),
                  direction: widget.alignment.x > 0
                      ? DismissDirection.endToStart
                      : (widget.alignment.x < 0
                            ? DismissDirection.startToEnd
                            : DismissDirection.vertical),
                  onDismissed: (_) => widget.onDismissed(),
                  child: TectaSnackbar(
                    message: widget.message,
                    title: widget.title,
                    subText: widget.subText,
                    variant: widget.variant,
                    leadingIcon: widget.leadingIcon,
                    action: widget.action,
                    backgroundColorOverride: widget.backgroundColorOverride,
                    textColorOverride: widget.textColorOverride,
                    titleStyle: widget.titleStyle,
                    messageStyle: widget.messageStyle,
                    subTextStyle: widget.subTextStyle,
                    borderRadius: widget.borderRadius,
                    shadows: widget.shadows,
                    border: widget.border,
                    decorationOverride: widget.decorationOverride,
                    onClose: _dismiss,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
