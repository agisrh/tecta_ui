import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium placeholder loading Skeleton component matching the MUI / Minimals design language.
///
/// Features:
/// - Support for circular (`BoxShape.circle`) and rectangular shapes.
/// - Integrated fading breathing shimmer pulse animation.
/// - Adjustable width, height, corner radius, and backdrop colors.
class TectaSkeleton extends StatefulWidget {
  /// Custom width. If null, stretches to fit bounds.
  final double? width;

  /// Custom height. If null, stretches to fit bounds.
  final double? height;

  /// Layout shape. Defaults to [BoxShape.rectangle].
  final BoxShape shape;

  /// Corner radius for rectangular shapes. Defaults to `BorderRadius.circular(8.0)`.
  final BorderRadiusGeometry? borderRadius;

  /// Custom backdrop color override. Defaults to [TectaColors.grey300].
  final Color? color;

  /// Duration of one fade pulse cycle. Defaults to `1000 milliseconds`.
  final Duration duration;

  /// Creates a [TectaSkeleton] placeholder loading shimmer component.
  const TectaSkeleton({
    super.key,
    this.width,
    this.height,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.color,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  State<TectaSkeleton> createState() => _TectaSkeletonState();
}

class _TectaSkeletonState extends State<TectaSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _opacityAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry? radius = widget.shape == BoxShape.circle
        ? null
        : (widget.borderRadius ?? BorderRadius.circular(8.0));

    final Color skeletonColor = widget.color ?? TectaColors.grey300;

    return FadeTransition(
      opacity: _opacityAnimation,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: skeletonColor,
          shape: widget.shape,
          borderRadius: radius,
        ),
      ),
    );
  }
}
