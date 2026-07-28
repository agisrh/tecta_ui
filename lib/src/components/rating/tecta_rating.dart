import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium, interactive Star Rating selector component matching Minimals design language.
///
/// Features:
/// - Supports full or half star intervals (`allowHalfRating: true`).
/// - Interactive gestures (taps and drags) to choose rating values.
/// - Customizable star sizing, spacing, colors (active / inactive), and count.
class TectaRating extends StatelessWidget {
  /// The current rating value.
  final double rating;

  /// Callback when rating value is changed by the user. If null, rating is read-only.
  final ValueChanged<double>? onRatingChanged;

  /// Total number of stars to display. Defaults to `5`.
  final int maxRating;

  /// The size of each star icon. Defaults to `28.0`.
  final double size;

  /// Spacing between star icons. Defaults to `4.0`.
  final double spacing;

  /// Color of active/filled stars. Defaults to [TectaColors.warningMain] (amber gold).
  final Color? color;

  /// Color of inactive/empty stars. Defaults to [TectaColors.grey300] (soft grey).
  final Color? unselectedColor;

  /// Whether to allow half-star selection (e.g. 3.5). Defaults to `false`.
  final bool allowHalfRating;

  /// Creates a [TectaRating] interactive star rating component.
  const TectaRating({
    super.key,
    required this.rating,
    this.onRatingChanged,
    this.maxRating = 5,
    this.size = 28.0,
    this.spacing = 4.0,
    this.color,
    this.unselectedColor,
    this.allowHalfRating = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = color ?? TectaColors.warningMain;
    final Color inactiveColor = unselectedColor ?? TectaColors.grey300;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final double starIndex = index + 1.0;

        Widget starWidget;
        if (rating >= starIndex) {
          // Fully filled star
          starWidget = Icon(Icons.star_rounded, color: activeColor, size: size);
        } else if (rating >= starIndex - 0.5 && allowHalfRating) {
          // Half filled star
          starWidget = Stack(
            children: [
              Icon(Icons.star_rounded, color: inactiveColor, size: size),
              ClipRect(
                clipper: _HalfStarClipper(),
                child: Icon(Icons.star_rounded, color: activeColor, size: size),
              ),
            ],
          );
        } else {
          // Empty star
          starWidget = Icon(Icons.star_rounded, color: inactiveColor, size: size);
        }

        if (onRatingChanged != null) {
          starWidget = GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) {
              final double localX = details.localPosition.dx;
              double selectedVal = index + 1.0;
              if (allowHalfRating && localX < size / 2) {
                selectedVal = index + 0.5;
              }
              onRatingChanged!(selectedVal);
            },
            child: starWidget,
          );
        }

        return Padding(
          padding: EdgeInsets.only(right: index == maxRating - 1 ? 0 : spacing),
          child: starWidget,
        );
      }),
    );
  }
}

class _HalfStarClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, size.width / 2, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
