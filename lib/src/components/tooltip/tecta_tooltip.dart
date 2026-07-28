import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Supported positioning options for [TectaTooltip].
enum TectaTooltipPosition {
  /// Place tooltip above the target widget.
  top,
  /// Place tooltip below the target widget.
  bottom,
  /// Place tooltip to the left of the target widget.
  left,
  /// Place tooltip to the right of the target widget.
  right
}

/// Supported trigger modes for [TectaTooltip].
enum TectaTooltipTrigger {
  /// Tooltip shows on hover or long-press (default).
  longPress,

  /// Tooltip toggles on tap (single tap to show, tap again or tap outside to hide).
  tap,

  /// Tooltip shows on press down and hides on release.
  press,
}

enum _TooltipArrowDirection { up, down, left, right }

/// A premium, customizable Tooltip widget matching Minimals design language.
///
/// Features:
/// - Contextual overlay triggered on mouse hover, tap, press, or long-press.
/// - Supporting 4 positions: `top`, `bottom`, `left`, `right`.
/// - Supports tap toggle mode (`triggerOnTap: true` or `trigger: TectaTooltipTrigger.tap`).
/// - Integrates a pointer arrow pointing towards the center of the trigger widget.
/// - Soft contrast text bubble matches modern dark UI hints.
class TectaTooltip extends StatefulWidget {
  /// The target widget that triggers the tooltip on hover/interaction.
  final Widget child;

  /// The message string to display inside the tooltip bubble.
  final String message;

  /// Where to place the tooltip relative to the target widget. Defaults to [TectaTooltipPosition.top].
  final TectaTooltipPosition position;

  /// Custom background color. Defaults to [TectaColors.grey800].
  final Color? backgroundColor;

  /// Custom text style. Defaults to white caption layout.
  final TextStyle? textStyle;

  /// Custom border radius. Defaults to `BorderRadius.circular(6.0)`.
  final BorderRadiusGeometry? borderRadius;

  /// Trigger mode for displaying the tooltip. Defaults to [TectaTooltipTrigger.longPress].
  final TectaTooltipTrigger trigger;

  /// Convenience flag to enable single-tap toggle trigger mode.
  /// If set to `true`, overrides [trigger] to [TectaTooltipTrigger.tap].
  final bool triggerOnTap;

  /// Optional duration for auto-hiding the tooltip in tap trigger mode.
  /// If null, defaults to 3 seconds when in tap mode, or no auto-hide if set to [Duration.zero].
  final Duration? displayDuration;

  /// Creates a [TectaTooltip] tooltip overlay component.
  const TectaTooltip({
    super.key,
    required this.child,
    required this.message,
    this.position = TectaTooltipPosition.top,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius,
    this.trigger = TectaTooltipTrigger.longPress,
    this.triggerOnTap = false,
    this.displayDuration,
  });

  @override
  State<TectaTooltip> createState() => _TectaTooltipState();
}

class _TectaTooltipState extends State<TectaTooltip> {
  OverlayEntry? _overlayEntry;
  Timer? _autoHideTimer;

  TectaTooltipTrigger get _effectiveTrigger {
    if (widget.triggerOnTap) {
      return TectaTooltipTrigger.tap;
    }
    return widget.trigger;
  }

  void _showTooltip() {
    if (_overlayEntry != null) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final Offset anchorOffset = renderBox.localToGlobal(Offset.zero);
    final Size anchorSize = renderBox.size;
    final bool isTap = _effectiveTrigger == TectaTooltipTrigger.tap;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            if (isTap)
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _hideTooltip,
                  child: const SizedBox.expand(),
                ),
              ),
            _TooltipOverlayPresenter(
              anchorOffset: anchorOffset,
              anchorSize: anchorSize,
              message: widget.message,
              position: widget.position,
              backgroundColor: widget.backgroundColor,
              textStyle: widget.textStyle,
              borderRadius: widget.borderRadius,
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);

    if (isTap || widget.displayDuration != null) {
      final Duration duration = widget.displayDuration ?? const Duration(seconds: 3);
      if (duration > Duration.zero) {
        _autoHideTimer?.cancel();
        _autoHideTimer = Timer(duration, _hideTooltip);
      }
    }
  }

  void _hideTooltip() {
    _autoHideTimer?.cancel();
    _autoHideTimer = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleTooltip() {
    if (_overlayEntry != null) {
      _hideTooltip();
    } else {
      _showTooltip();
    }
  }

  @override
  void dispose() {
    _hideTooltip();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trigger = _effectiveTrigger;

    return MouseRegion(
      onEnter: (_) => _showTooltip(),
      onExit: (_) => _hideTooltip(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: trigger == TectaTooltipTrigger.tap ? _toggleTooltip : null,
        onLongPressStart:
            trigger == TectaTooltipTrigger.longPress ? (_) => _showTooltip() : null,
        onLongPressEnd:
            trigger == TectaTooltipTrigger.longPress ? (_) => _hideTooltip() : null,
        onLongPressCancel:
            trigger == TectaTooltipTrigger.longPress ? _hideTooltip : null,
        onTapDown:
            trigger == TectaTooltipTrigger.press ? (_) => _showTooltip() : null,
        onTapUp:
            trigger == TectaTooltipTrigger.press ? (_) => _hideTooltip() : null,
        onTapCancel:
            trigger == TectaTooltipTrigger.press ? _hideTooltip : null,
        child: widget.child,
      ),
    );
  }
}

class _TooltipOverlayPresenter extends StatefulWidget {
  final Offset anchorOffset;
  final Size anchorSize;
  final String message;
  final TectaTooltipPosition position;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;

  const _TooltipOverlayPresenter({
    required this.anchorOffset,
    required this.anchorSize,
    required this.message,
    required this.position,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius,
  });

  @override
  State<_TooltipOverlayPresenter> createState() => _TooltipOverlayPresenterState();
}

class _TooltipOverlayPresenterState extends State<_TooltipOverlayPresenter>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  final GlobalKey _bubbleKey = GlobalKey();
  double _bubbleWidth = 0.0;
  double _bubbleHeight = 0.0;
  bool _hasMeasured = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _fadeAnimation = CurvedAnimation(parent: _animController, curve: Curves.easeOut);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = _bubbleKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        if (mounted) {
          setState(() {
            _bubbleWidth = renderBox.size.width;
            _bubbleHeight = renderBox.size.height;
            _hasMeasured = true;
          });
          _animController.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    // Horizontally clamp left position to prevent clipping
    double tooltipLeft =
        widget.anchorOffset.dx + (widget.anchorSize.width / 2) - (_bubbleWidth / 2);
    if (widget.position == TectaTooltipPosition.left) {
      tooltipLeft = widget.anchorOffset.dx - _bubbleWidth - 6.0;
    } else if (widget.position == TectaTooltipPosition.right) {
      tooltipLeft = widget.anchorOffset.dx + widget.anchorSize.width + 6.0;
    }

    if (tooltipLeft < 12.0) {
      tooltipLeft = 12.0;
    } else if (tooltipLeft + _bubbleWidth > screenWidth - 12.0) {
      tooltipLeft = screenWidth - 12.0 - _bubbleWidth;
    }

    // Vertically clamp top position to prevent clipping
    double tooltipTop = widget.anchorOffset.dy + widget.anchorSize.height + 6.0;
    if (widget.position == TectaTooltipPosition.top) {
      tooltipTop = widget.anchorOffset.dy - _bubbleHeight - 6.0;
    } else if (widget.position == TectaTooltipPosition.left ||
        widget.position == TectaTooltipPosition.right) {
      tooltipTop = widget.anchorOffset.dy + (widget.anchorSize.height / 2) - (_bubbleHeight / 2);
    }

    if (tooltipTop < 12.0) {
      tooltipTop = 12.0;
    } else if (tooltipTop + _bubbleHeight > screenHeight - 12.0) {
      tooltipTop = screenHeight - 12.0 - _bubbleHeight;
    }

    final Color bg = widget.backgroundColor ?? TectaColors.grey800;
    final BorderRadiusGeometry radius = widget.borderRadius ?? BorderRadius.circular(6.0);
    final TextStyle style =
        widget.textStyle ??
        TectaTypography.caption.copyWith(color: TectaColors.white, fontSize: 11.5);

    // Build pointing arrow
    Widget? arrowWidget;
    if (_hasMeasured) {
      _TooltipArrowDirection arrowDir = _TooltipArrowDirection.up;
      double arrowL = 0.0;
      double arrowT = 0.0;
      double arrowW = 10.0;
      double arrowH = 5.0;

      switch (widget.position) {
        case TectaTooltipPosition.bottom:
          arrowDir = _TooltipArrowDirection.up;
          arrowL = widget.anchorOffset.dx + (widget.anchorSize.width / 2) - 5.0;
          arrowT = tooltipTop - 4.5;
          arrowW = 10.0;
          arrowH = 5.0;
          break;
        case TectaTooltipPosition.top:
          arrowDir = _TooltipArrowDirection.down;
          arrowL = widget.anchorOffset.dx + (widget.anchorSize.width / 2) - 5.0;
          arrowT = tooltipTop + _bubbleHeight - 0.5;
          arrowW = 10.0;
          arrowH = 5.0;
          break;
        case TectaTooltipPosition.left:
          arrowDir = _TooltipArrowDirection.right;
          arrowL = tooltipLeft + _bubbleWidth - 0.5;
          arrowT = widget.anchorOffset.dy + (widget.anchorSize.height / 2) - 5.0;
          arrowW = 5.0;
          arrowH = 10.0;
          break;
        case TectaTooltipPosition.right:
          arrowDir = _TooltipArrowDirection.left;
          arrowL = tooltipLeft - 4.5;
          arrowT = widget.anchorOffset.dy + (widget.anchorSize.height / 2) - 5.0;
          arrowW = 5.0;
          arrowH = 10.0;
          break;
      }

      arrowWidget = Positioned(
        left: arrowL,
        top: arrowT,
        child: CustomPaint(
          size: Size(arrowW, arrowH),
          painter: _TooltipArrowPainter(color: bg, direction: arrowDir),
        ),
      );
    }

    return Positioned.fill(
      child: IgnorePointer(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Stack(
            children: [
              Positioned(
                left: tooltipLeft,
                top: tooltipTop,
                child: Material(
                  key: _bubbleKey,
                  type: MaterialType.transparency,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(color: bg, borderRadius: radius),
                    child: Text(widget.message, style: style),
                  ),
                ),
              ),
              // ignore: use_null_aware_elements
              if (arrowWidget != null) arrowWidget,
            ],
          ),
        ),
      ),
    );
  }
}

class _TooltipArrowPainter extends CustomPainter {
  final Color color;
  final _TooltipArrowDirection direction;

  _TooltipArrowPainter({required this.color, required this.direction});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    switch (direction) {
      case _TooltipArrowDirection.up:
        path.moveTo(0, size.height);
        path.lineTo(size.width / 2, 0);
        path.lineTo(size.width, size.height);
        break;
      case _TooltipArrowDirection.down:
        path.moveTo(0, 0);
        path.lineTo(size.width / 2, size.height);
        path.lineTo(size.width, 0);
        break;
      case _TooltipArrowDirection.left:
        path.moveTo(size.width, 0);
        path.lineTo(0, size.height / 2);
        path.lineTo(size.width, size.height);
        break;
      case _TooltipArrowDirection.right:
        path.moveTo(0, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height);
        break;
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TooltipArrowPainter oldDelegate) =>
      color != oldDelegate.color || direction != oldDelegate.direction;
}
