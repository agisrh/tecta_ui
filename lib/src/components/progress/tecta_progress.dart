import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium Linear Progress indicator matching the MUI / Minimals design language.
///
/// Features:
/// - Smooth progress bar track.
/// - Rounded corner border styling (`borderRadius`).
/// - Custom thickness height, active/inactive colors, and support for indeterminate/determinate states.
/// - Option to cycle smoothly through a list of custom colors (Google style).
class TectaLinearProgress extends StatefulWidget {
  /// The progress value between `0.0` and `1.0`. If null, runs in indeterminate loading mode.
  final double? value;

  /// Height/thickness of the progress bar track. Defaults to `6.0`.
  final double height;

  /// Custom active color override. Defaults to [TectaColors.primaryMain].
  final Color? color;

  /// Custom inactive track background color override. Defaults to [TectaColors.grey200].
  final Color? backgroundColor;

  /// Corner radius of the progress track. Defaults to `BorderRadius.circular(3.0)`.
  final BorderRadiusGeometry? borderRadius;

  /// Optional list of colors to interpolate and rotate through (e.g. Google multi-color spinner).
  final List<Color>? colors;

  /// Creates a [TectaLinearProgress] horizontal progress bar.
  const TectaLinearProgress({
    super.key,
    this.value,
    this.height = 6.0,
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.colors,
  });

  @override
  State<TectaLinearProgress> createState() => _TectaLinearProgressState();
}

class _TectaLinearProgressState extends State<TectaLinearProgress>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.colors != null && widget.colors!.isNotEmpty) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
      )..repeat();
    }
  }

  @override
  void didUpdateWidget(TectaLinearProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool hasColors = widget.colors != null && widget.colors!.isNotEmpty;
    final bool hadColors = oldWidget.colors != null && oldWidget.colors!.isNotEmpty;

    if (hasColors && !hadColors) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
      )..repeat();
    } else if (!hasColors && hadColors) {
      _controller?.dispose();
      _controller = null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Color _getCurrentColor(double animationValue) {
    final colors = widget.colors!;
    if (colors.isEmpty) return widget.color ?? TectaColors.primaryMain;
    if (colors.length == 1) return colors.first;

    final double segment = 1.0 / colors.length;
    final int index = (animationValue / segment).floor().clamp(0, colors.length - 1);
    final double relativeVal = (animationValue - (index * segment)) / segment;

    final Color start = colors[index];
    final Color end = colors[(index + 1) % colors.length];
    return Color.lerp(start, end, relativeVal) ?? start;
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry radius = widget.borderRadius ?? BorderRadius.circular(3.0);
    final Color inactiveColor = widget.backgroundColor ?? TectaColors.grey200;

    Widget indicator;
    if (_controller != null) {
      indicator = AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
          return LinearProgressIndicator(
            value: widget.value,
            color: _getCurrentColor(_controller!.value),
            backgroundColor: inactiveColor,
          );
        },
      );
    } else {
      final Color activeColor = widget.color ?? TectaColors.primaryMain;
      indicator = LinearProgressIndicator(
        value: widget.value,
        color: activeColor,
        backgroundColor: inactiveColor,
      );
    }

    return ClipRRect(
      borderRadius: radius is BorderRadius ? radius : BorderRadius.circular(3.0),
      child: SizedBox(
        height: widget.height,
        child: indicator,
      ),
    );
  }
}

/// A premium Circular Progress spinner indicator matching the MUI / Minimals design language.
///
/// Features:
/// - Clean circular spinner.
/// - Adjustable diameter sizes, stroke width thicknesses, and colors.
/// - Option to cycle smoothly through a list of custom colors (Google style).
class TectaCircularProgress extends StatefulWidget {
  /// The progress value between `0.0` and `1.0`. If null, runs in indeterminate loading mode.
  final double? value;

  /// Diameter size of the circular progress indicator. Defaults to `36.0`.
  final double size;

  /// Thickness of the stroke line drawing the circle. Defaults to `4.0`.
  final double strokeWidth;

  /// Custom color override. Defaults to [TectaColors.primaryMain].
  final Color? color;

  /// Background track color. Defaults to transparent.
  final Color? backgroundColor;

  /// Optional list of colors to interpolate and rotate through (e.g. Google multi-color spinner).
  final List<Color>? colors;

  /// Creates a [TectaCircularProgress] spinner loader component.
  const TectaCircularProgress({
    super.key,
    this.value,
    this.size = 36.0,
    this.strokeWidth = 4.0,
    this.color,
    this.backgroundColor,
    this.colors,
  });

  @override
  State<TectaCircularProgress> createState() => _TectaCircularProgressState();
}

class _TectaCircularProgressState extends State<TectaCircularProgress>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.colors != null && widget.colors!.isNotEmpty) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
      )..repeat();
    }
  }

  @override
  void didUpdateWidget(TectaCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool hasColors = widget.colors != null && widget.colors!.isNotEmpty;
    final bool hadColors = oldWidget.colors != null && oldWidget.colors!.isNotEmpty;

    if (hasColors && !hadColors) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
      )..repeat();
    } else if (!hasColors && hadColors) {
      _controller?.dispose();
      _controller = null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Color _getCurrentColor(double animationValue) {
    final colors = widget.colors!;
    if (colors.isEmpty) return widget.color ?? TectaColors.primaryMain;
    if (colors.length == 1) return colors.first;

    final double segment = 1.0 / colors.length;
    final int index = (animationValue / segment).floor().clamp(0, colors.length - 1);
    final double relativeVal = (animationValue - (index * segment)) / segment;

    final Color start = colors[index];
    final Color end = colors[(index + 1) % colors.length];
    return Color.lerp(start, end, relativeVal) ?? start;
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null) {
      return AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: CircularProgressIndicator(
              value: widget.value,
              strokeWidth: widget.strokeWidth,
              color: _getCurrentColor(_controller!.value),
              backgroundColor: widget.backgroundColor,
            ),
          );
        },
      );
    }

    final Color activeColor = widget.color ?? TectaColors.primaryMain;
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CircularProgressIndicator(
        value: widget.value,
        strokeWidth: widget.strokeWidth,
        color: activeColor,
        backgroundColor: widget.backgroundColor,
      ),
    );
  }
}
