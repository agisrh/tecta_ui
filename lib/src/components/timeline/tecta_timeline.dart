import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// The styling variant of the timeline node indicator.
enum TectaTimelineIndicatorType { solid, outlined, soft }

/// The style of the line connecting timeline nodes.
enum TectaTimelineLineType { solid, dashed }

/// A premium vertical Timeline workflow tracking component matching Minimals design language.
///
/// Features:
/// - Step-by-step track mapping.
/// - Supporting 3 indicator variants: `solid`, `outlined`, `soft` (translucent color).
/// - Connector line types: `solid`, `dashed`.
class TectaTimeline extends StatelessWidget {
  /// The chronological list of timeline items.
  final List<TectaTimelineItem> children;

  /// Custom padding around the entire timeline.
  final EdgeInsetsGeometry? padding;

  /// Creates a [TectaTimeline] component to display a vertical timeline of items.
  const TectaTimeline({super.key, required this.children, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(children.length, (index) {
          final item = children[index];
          // Automatically set isLast if not set explicitly
          final bool isLast = index == children.length - 1;

          return _TimelineItemPresenter(
            title: item.title,
            subtitle: item.subtitle,
            time: item.time,
            isLast: isLast,
            indicator: item.indicator,
            indicatorColor: item.indicatorColor,
            indicatorType: item.indicatorType,
            lineType: item.lineType,
            content: item.content,
          );
        }),
      ),
    );
  }
}

/// Data container for a single point in the timeline list.
class TectaTimelineItem {
  /// The main heading or title text of the timeline item step.
  final String title;

  /// Optional subtitle descriptor details below the title.
  final String? subtitle;

  /// Optional timestamp display string (e.g. "10:30 AM" or "July 6").
  final String? time;

  /// Custom widget indicator for the node (replaces the default circle dot).
  final Widget? indicator;

  /// Custom coloring of default indicator dot.
  final Color? indicatorColor;

  /// Styled indicator format (solid, outlined, or soft transparent).
  final TectaTimelineIndicatorType indicatorType;

  /// The connecting line formatting style (solid or dashed).
  final TectaTimelineLineType lineType;

  /// Optional expanding card content block below the title/subtitle.
  final Widget? content;

  /// Creates a [TectaTimelineItem] to represent a point on a vertical timeline.
  const TectaTimelineItem({
    required this.title,
    this.subtitle,
    this.time,
    this.indicator,
    this.indicatorColor,
    this.indicatorType = TectaTimelineIndicatorType.solid,
    this.lineType = TectaTimelineLineType.solid,
    this.content,
  });
}

class _TimelineItemPresenter extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? time;
  final bool isLast;
  final Widget? indicator;
  final Color? indicatorColor;
  final TectaTimelineIndicatorType indicatorType;
  final TectaTimelineLineType lineType;
  final Widget? content;

  const _TimelineItemPresenter({
    required this.title,
    this.subtitle,
    this.time,
    required this.isLast,
    this.indicator,
    this.indicatorColor,
    required this.indicatorType,
    required this.lineType,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = indicatorColor ?? Theme.of(context).colorScheme.primary;

    // Render node indicator
    Widget nodeIndicator = indicator ?? const SizedBox.shrink();
    if (indicator == null) {
      switch (indicatorType) {
        case TectaTimelineIndicatorType.solid:
          nodeIndicator = Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(color: activeColor, shape: BoxShape.circle),
          );
          break;
        case TectaTimelineIndicatorType.outlined:
          nodeIndicator = Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: activeColor, width: 2.5),
            ),
          );
          break;
        case TectaTimelineIndicatorType.soft:
          nodeIndicator = Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              color: activeColor.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(color: activeColor, shape: BoxShape.circle),
            ),
          );
          break;
      }
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time layout (Optional left section)
          if (time != null) ...[
            SizedBox(
              width: 60.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  time!,
                  style: TectaTypography.caption.copyWith(
                    color: TectaColors.grey500,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
          ],

          // Connector line and indicator
          Column(
            children: [
              Padding(padding: const EdgeInsets.only(top: 3.0), child: nodeIndicator),
              if (!isLast)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: CustomPaint(
                      size: const Size(2.0, double.infinity),
                      painter: _TimelineLinePainter(
                        color: TectaColors.grey300,
                        lineType: lineType,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16.0),

          // Details content (Right section)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TectaTypography.subtitle2.copyWith(
                      color: TectaColors.grey800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4.0),
                    Text(
                      subtitle!,
                      style: TectaTypography.body2.copyWith(color: TectaColors.grey500),
                    ),
                  ],
                  if (content != null) ...[const SizedBox(height: 8.0), content!],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineLinePainter extends CustomPainter {
  final Color color;
  final TectaTimelineLineType lineType;

  _TimelineLinePainter({required this.color, required this.lineType});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final double startX = size.width / 2;

    if (lineType == TectaTimelineLineType.solid) {
      canvas.drawLine(Offset(startX, 0.0), Offset(startX, size.height), paint);
    } else {
      // Dashed line
      double startY = 0.0;
      const double dashHeight = 4.0;
      const double dashGap = 4.0;

      while (startY < size.height) {
        canvas.drawLine(Offset(startX, startY), Offset(startX, startY + dashHeight), paint);
        startY += dashHeight + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TimelineLinePainter oldDelegate) =>
      color != oldDelegate.color || lineType != oldDelegate.lineType;
}
