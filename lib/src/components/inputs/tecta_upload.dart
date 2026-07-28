import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A custom dashed/dotted border painter to support premium borders on containers.
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth = 1.0;
  final double dashWidth = 4.0;
  final double dashSpace = 3.0;
  final double radius;
  final bool isCircle;

  _DashedBorderPainter({
    this.color = const Color(0xFFC4CDD5),
    this.radius = 12.0,
    this.isCircle = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    if (isCircle) {
      path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    } else {
      path.addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );
    }

    final Path dashedPath = Path();
    double distance = 0.0;
    for (final PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        dashedPath.addPath(measurePath.extractPath(distance, distance + dashWidth), Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      dashWidth != oldDelegate.dashWidth ||
      dashSpace != oldDelegate.dashSpace ||
      radius != oldDelegate.radius ||
      isCircle != oldDelegate.isCircle;
}

/// A stylized folder vector illustration built purely using Flutter widgets.
class _UploadIllustration extends StatelessWidget {
  const _UploadIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Paper sheet 1 (tilted left)
          Positioned(
            bottom: 12,
            left: 28,
            child: Transform.rotate(
              angle: -0.15,
              child: Container(
                width: 32,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: TectaColors.grey300),
                ),
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 16, height: 2, color: TectaColors.grey300),
                    const SizedBox(height: 4),
                    Container(width: 20, height: 2, color: TectaColors.grey300),
                    const SizedBox(height: 4),
                    Container(width: 12, height: 2, color: TectaColors.grey300),
                  ],
                ),
              ),
            ),
          ),
          // Paper sheet 2 (tilted right)
          Positioned(
            bottom: 14,
            right: 28,
            child: Transform.rotate(
              angle: 0.15,
              child: Container(
                width: 32,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: TectaColors.grey300),
                ),
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 18, height: 2, color: TectaColors.primaryLight),
                    const SizedBox(height: 4),
                    Container(width: 14, height: 2, color: TectaColors.grey300),
                    const SizedBox(height: 4),
                    Container(width: 20, height: 2, color: TectaColors.grey300),
                  ],
                ),
              ),
            ),
          ),
          // Main Folder back flap
          Positioned(
            bottom: 4,
            child: Container(
              width: 76,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF004B3A), // Green darkest
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          // Main Folder front flap with tab
          Positioned(
            bottom: 0,
            child: Container(
              width: 76,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF007A5A), // Green main
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.cloud_upload_outlined, color: TectaColors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A premium Multi-File upload box with a dashed border, vector folder illustration,
/// title headings, and a browse text link.
class TectaUploadBox extends StatelessWidget {
  /// Header title inside the upload box. Defaults to "Drop or select files".
  final String title;

  /// Subtitle instructions text. Defaults to "Drag files here, or browse your device".
  final String subtitle;

  /// Triggered when the upload box is clicked/tapped.
  final VoidCallback onTap;

  /// Optional background color override.
  final Color? backgroundColor;

  /// Custom active accent color for the browse link text.
  final Color? activeLinkColor;

  /// Creates a [TectaUploadBox] drag-and-drop file upload component.
  const TectaUploadBox({
    super.key,
    this.title = 'Drop or select files',
    this.subtitle = 'Drag files here, or browse your device.',
    required this.onTap,
    this.backgroundColor,
    this.activeLinkColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color linkColor = activeLinkColor ?? const Color(0xFF007A5A);
    final Color bg = backgroundColor ?? TectaColors.grey200.withValues(alpha: 0.4);

    // Locate "browse" substring to style it differently as a link
    final List<TextSpan> subtitleSpans = [];
    if (subtitle.contains('browse')) {
      final parts = subtitle.split('browse');
      subtitleSpans.add(TextSpan(text: parts[0]));
      subtitleSpans.add(
        TextSpan(
          text: 'browse',
          style: TextStyle(
            color: linkColor,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
        ),
      );
      subtitleSpans.add(TextSpan(text: parts[1]));
    } else {
      subtitleSpans.add(TextSpan(text: subtitle));
    }

    return CustomPaint(
      painter: _DashedBorderPainter(
        color: TectaColors.grey400.withValues(alpha: 0.6),
        radius: 12.0,
      ),
      child: Container(
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12.0)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _UploadIllustration(),
                const SizedBox(height: 16.0),
                Text(
                  title,
                  style: TectaTypography.h6.copyWith(
                    color: TectaColors.grey800,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
                    children: subtitleSpans,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A premium circular profile/avatar upload frame with a dashed outline, hover overlays,
/// format size guidelines, and click triggers.
class TectaUploadAvatar extends StatefulWidget {
  /// The image provider showing the current selected avatar.
  final ImageProvider? image;

  /// Triggered when the avatar box is clicked/tapped to upload.
  final VoidCallback onTap;

  /// Detail guidelines text displayed below the circle.
  final String guidelines;

  /// Creates a [TectaUploadAvatar] profile picture upload component.
  const TectaUploadAvatar({
    super.key,
    this.image,
    required this.onTap,
    this.guidelines = 'Allowed *.jpeg, *.jpg, *.png, *.gif\nmax size of 3 Mb',
  });

  @override
  State<TectaUploadAvatar> createState() => _TectaUploadAvatarState();
}

class _TectaUploadAvatarState extends State<TectaUploadAvatar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = widget.image != null;

    final Widget innerCircle = Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: TectaColors.grey100,
        image: hasImage ? DecorationImage(image: widget.image!, fit: BoxFit.cover) : null,
      ),
      child: Stack(
        children: [
          // Overlay content (camera icon + upload photo text)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo_camera,
                  color: hasImage ? Colors.transparent : TectaColors.grey600,
                  size: 24,
                ),
                if (!hasImage) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Upload photo',
                    style: TectaTypography.caption.copyWith(
                      color: TectaColors.grey600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Interactive Hover/Focus overlay
          Positioned.fill(
            child: InkWell(
              onTap: widget.onTap,
              customBorder: const CircleBorder(),
              onHover: (hovered) {
                setState(() {
                  _isHovered = hovered;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isHovered && hasImage
                      ? Colors.black.withValues(alpha: 0.38)
                      : Colors.transparent,
                ),
                child: _isHovered && hasImage
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.photo_camera, color: TectaColors.white, size: 24),
                            const SizedBox(height: 4),
                            Text(
                              'Update photo',
                              style: TectaTypography.caption.copyWith(
                                color: TectaColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular dashed outline frame
        CustomPaint(
          painter: _DashedBorderPainter(
            color: TectaColors.grey400.withValues(alpha: 0.6),
            isCircle: true,
          ),
          child: Padding(padding: const EdgeInsets.all(8.0), child: innerCircle),
        ),
        const SizedBox(height: 16.0),
        // Guideline description texts
        Text(
          widget.guidelines,
          style: TectaTypography.caption.copyWith(color: TectaColors.grey500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
