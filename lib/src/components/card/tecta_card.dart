import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium, highly customizable Card component matching Minimals design language.
///
/// Features:
/// - Styled structural compartments: Header, Media (Image), Body, and Actions Footer.
/// - Dynamic interactive hover states (translate upward and cast deeper shadows on hover).
/// - Customizable elevation shadows, borders, corners, padding, and background colors.
class TectaCard extends StatefulWidget {
  /// Header widget (typically [ListTile] or custom widget showing avatar/titles).
  final Widget? header;

  /// Media widget (typically an Image displaying custom visual banner).
  final Widget? media;

  /// Main body child content.
  final Widget? content;

  /// Footer actions row (typically icons or buttons).
  final List<Widget>? actions;

  /// Padding around the content (body) section. Defaults to `EdgeInsets.all(24.0)`.
  final EdgeInsetsGeometry? padding;

  /// Card border radius override. Defaults to `BorderRadius.circular(16.0)`.
  final BorderRadiusGeometry? borderRadius;

  /// Custom background color override. Defaults to [TectaColors.white].
  final Color? backgroundColor;

  /// Custom border color. If provided, renders card with border outline.
  final Color? borderColor;

  /// Custom elevation shadow override. Defaults to [TectaShadows.z1].
  final List<BoxShadow>? shadow;

  /// Whether to enable interactive hover lifting effect. Defaults to `true`.
  final bool enableHoverEffect;

  /// Action callback when the card itself is tapped.
  final VoidCallback? onTap;

  const TectaCard({
    super.key,
    this.header,
    this.media,
    this.content,
    this.actions,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.shadow,
    this.enableHoverEffect = true,
    this.onTap,
  });

  @override
  State<TectaCard> createState() => _TectaCardState();
}

class _TectaCardState extends State<TectaCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry radius = widget.borderRadius ?? BorderRadius.circular(16.0);
    final Color bg = widget.backgroundColor ?? TectaColors.white;
    final EdgeInsetsGeometry bodyPadding = widget.padding ?? const EdgeInsets.all(24.0);

    // Dynamic hover styles
    final double translateY = (_isHovered && widget.enableHoverEffect) ? -6.0 : 0.0;
    final List<BoxShadow> currentShadow = (_isHovered && widget.enableHoverEffect)
        ? TectaShadows.z16
        : (widget.shadow ?? TectaShadows.z1);

    Widget cardWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(0.0, translateY, 0.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: radius,
        boxShadow: widget.borderColor == null ? currentShadow : null,
        border: widget.borderColor != null
            ? Border.all(color: widget.borderColor!)
            : Border.all(color: TectaColors.grey200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header compartment
          if (widget.header != null) widget.header!,

          // Media compartment
          if (widget.media != null) widget.media!,

          // Body Content
          if (widget.content != null) Padding(padding: bodyPadding, child: widget.content!),

          // Actions Footer
          if (widget.actions != null && widget.actions!.isNotEmpty) ...[
            const Divider(height: 1, color: TectaColors.grey200),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: widget.actions!.map((act) {
                  return Padding(padding: const EdgeInsets.only(right: 8.0), child: act);
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );

    if (widget.onTap != null) {
      cardWidget = InkWell(
        onTap: widget.onTap,
        borderRadius: radius is BorderRadius ? radius : BorderRadius.circular(16.0),
        child: cardWidget,
      );
    }

    if (widget.enableHoverEffect) {
      cardWidget = MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}
