import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Style variants of the divider line.
enum TectaDividerStyle {
  /// Solid continuous line.
  solid,
  /// Dashed line.
  dashed,
  /// Dotted line.
  dotted
}

/// The alignment of the label inside [TectaDivider].
enum TectaDividerLabelAlignment {
  /// Positioned at the start.
  start,
  /// Positioned at the center.
  center,
  /// Positioned at the end.
  end
}

/// A premium, highly customizable Divider component for the Tecta Design System.
///
/// Features:
/// - Horizontal and Vertical orientations.
/// - Three line styles: [TectaDividerStyle.solid] (default), [TectaDividerStyle.dashed], and [TectaDividerStyle.dotted].
/// - Optional text label or widget center-aligned or aligned start/end.
/// - Adjustable thickness, spacing, color, and indents.
class TectaDivider extends StatelessWidget {
  /// The orientation of the divider. Defaults to [Axis.horizontal].
  final Axis orientation;

  /// The thickness of the divider line. Defaults to 1.0.
  final double thickness;

  /// Spasi kosong sebelum garis pembatas dimulai.
  final double indent;

  /// Spasi kosong setelah garis pembatas berakhir.
  final double endIndent;

  /// Custom color of the divider line. Defaults to [TectaColors.grey200].
  final Color? color;

  /// Line style of the divider. Defaults to [TectaDividerStyle.solid].
  final TectaDividerStyle style;

  /// Optional label widget/text displayed along the divider.
  final Widget? label;

  /// Alignment of the label. Defaults to [TectaDividerLabelAlignment.center].
  final TectaDividerLabelAlignment labelAlignment;

  /// Spacing between the label and the divider lines. Defaults to 16.0.
  final double spacing;

  /// Creates a [TectaDivider] separator.
  const TectaDivider({
    super.key,
    this.orientation = Axis.horizontal,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color,
    this.style = TectaDividerStyle.solid,
    this.label,
    this.labelAlignment = TectaDividerLabelAlignment.center,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? TectaColors.grey300;
    final finalColor = TectaColors.resolve(context, resolvedColor);

    if (orientation == Axis.vertical) {
      return _buildVerticalDivider(context, finalColor);
    } else {
      return _buildHorizontalDivider(context, finalColor);
    }
  }

  Widget _buildHorizontalDivider(BuildContext context, Color finalColor) {
    if (label == null) {
      return Padding(
        padding: EdgeInsets.only(left: indent, right: endIndent),
        child: SizedBox(
          width: double.infinity,
          height: thickness,
          child: CustomPaint(
            painter: _DividerPainter(
              color: finalColor,
              thickness: thickness,
              style: style,
              orientation: Axis.horizontal,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (indent > 0) SizedBox(width: indent),
        if (labelAlignment == TectaDividerLabelAlignment.start) ...[
          _buildLine(finalColor, isExpanded: false),
          SizedBox(width: spacing),
        ],
        if (labelAlignment == TectaDividerLabelAlignment.center || labelAlignment == TectaDividerLabelAlignment.end) ...[
          Expanded(child: _buildLine(finalColor, isExpanded: true)),
          SizedBox(width: spacing),
        ],
        label!,
        if (labelAlignment == TectaDividerLabelAlignment.center || labelAlignment == TectaDividerLabelAlignment.start) ...[
          SizedBox(width: spacing),
          Expanded(child: _buildLine(finalColor, isExpanded: true)),
        ],
        if (labelAlignment == TectaDividerLabelAlignment.end) ...[
          SizedBox(width: spacing),
          _buildLine(finalColor, isExpanded: false),
        ],
        if (endIndent > 0) SizedBox(width: endIndent),
      ],
    );
  }

  Widget _buildVerticalDivider(BuildContext context, Color finalColor) {
    if (label == null) {
      return Padding(
        padding: EdgeInsets.only(top: indent, bottom: endIndent),
        child: SizedBox(
          width: thickness,
          height: double.infinity,
          child: CustomPaint(
            painter: _DividerPainter(
              color: finalColor,
              thickness: thickness,
              style: style,
              orientation: Axis.vertical,
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (indent > 0) SizedBox(height: indent),
        if (labelAlignment == TectaDividerLabelAlignment.start) ...[
          _buildLine(finalColor, isExpanded: false),
          SizedBox(height: spacing),
        ],
        if (labelAlignment == TectaDividerLabelAlignment.center || labelAlignment == TectaDividerLabelAlignment.end) ...[
          Expanded(child: _buildLine(finalColor, isExpanded: true)),
          SizedBox(height: spacing),
        ],
        label!,
        if (labelAlignment == TectaDividerLabelAlignment.center || labelAlignment == TectaDividerLabelAlignment.start) ...[
          SizedBox(height: spacing),
          Expanded(child: _buildLine(finalColor, isExpanded: true)),
        ],
        if (labelAlignment == TectaDividerLabelAlignment.end) ...[
          SizedBox(height: spacing),
          _buildLine(finalColor, isExpanded: false),
        ],
        if (endIndent > 0) SizedBox(height: endIndent),
      ],
    );
  }

  Widget _buildLine(Color finalColor, {required bool isExpanded}) {
    if (orientation == Axis.vertical) {
      final double? height = isExpanded ? null : 24.0;
      return SizedBox(
        width: thickness,
        height: height,
        child: CustomPaint(
          painter: _DividerPainter(
            color: finalColor,
            thickness: thickness,
            style: style,
            orientation: Axis.vertical,
          ),
        ),
      );
    } else {
      final double? width = isExpanded ? null : 24.0;
      return SizedBox(
        width: width,
        height: thickness,
        child: CustomPaint(
          painter: _DividerPainter(
            color: finalColor,
            thickness: thickness,
            style: style,
            orientation: Axis.horizontal,
          ),
        ),
      );
    }
  }
}

class _DividerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final TectaDividerStyle style;
  final Axis orientation;

  _DividerPainter({
    required this.color,
    required this.thickness,
    required this.style,
    required this.orientation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final double maxVal = orientation == Axis.horizontal ? size.width : size.height;
    final bool isHorizontal = orientation == Axis.horizontal;

    if (style == TectaDividerStyle.solid) {
      if (isHorizontal) {
        canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
      } else {
        canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
      }
    } else if (style == TectaDividerStyle.dashed) {
      final double dashWidth = 6.0;
      final double dashSpace = 4.0;
      double currentPos = 0.0;

      while (currentPos < maxVal) {
        final double endPos = (currentPos + dashWidth).clamp(0.0, maxVal);
        if (isHorizontal) {
          canvas.drawLine(Offset(currentPos, size.height / 2), Offset(endPos, size.height / 2), paint);
        } else {
          canvas.drawLine(Offset(size.width / 2, currentPos), Offset(size.width / 2, endPos), paint);
        }
        currentPos += dashWidth + dashSpace;
      }
    } else if (style == TectaDividerStyle.dotted) {
      final double dotRadius = thickness / 2;
      final double spacing = dotRadius * 4;
      double currentPos = dotRadius;

      paint.style = PaintingStyle.fill;
      while (currentPos < maxVal) {
        if (isHorizontal) {
          canvas.drawCircle(Offset(currentPos, size.height / 2), dotRadius, paint);
        } else {
          canvas.drawCircle(Offset(size.width / 2, currentPos), dotRadius, paint);
        }
        currentPos += spacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DividerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.thickness != thickness ||
        oldDelegate.style != style ||
        oldDelegate.orientation != orientation;
  }
}
