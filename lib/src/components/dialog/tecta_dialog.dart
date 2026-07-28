import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium, highly customizable Dialog modal component matching Minimals design language.
///
/// Features:
/// - Rounded card style with premium elevation drop shadows ([TectaShadows.z24]).
/// - Optional title header and cross close action.
/// - Scrollable or static body content.
/// - Footer actions alignment.
/// - Full-screen layout mode for mobile views.
class TectaDialog extends StatelessWidget {
  /// Optional title displayed at the top.
  final String? title;

  /// The body content of the dialog.
  final Widget? content;

  /// Footer actions (e.g. Cancel, OK buttons).
  final List<Widget>? actions;

  /// Optional callback when the top-right close icon button is tapped.
  /// If provided, the close icon is automatically rendered.
  final VoidCallback? onClose;

  /// Custom maximum width constraint. Defaults to `400.0`.
  final double maxWidth;

  /// Whether the body content is wrapped in a scrollable view. Defaults to `false`.
  final bool scrollable;

  /// Renders the dialog in a full-screen layout mode. Defaults to `false`.
  final bool isFullscreen;

  /// Custom border radius override. Defaults to `BorderRadius.circular(16.0)`.
  final BorderRadiusGeometry? borderRadius;

  /// Custom padding inside the dialog. Defaults to `EdgeInsets.all(24.0)`.
  final EdgeInsetsGeometry? padding;

  /// Custom background color override. Defaults to [TectaColors.white].
  final Color? backgroundColor;

  /// Custom shadow color override.
  final Color? shadowColor;

  /// Custom elevation override. Defaults to `24.0`.
  final double? elevation;

  /// Custom text style override for the title.
  final TextStyle? titleStyle;

  /// Custom close icon color override. Defaults to [TectaColors.grey500].
  final Color? closeIconColor;

  /// Creates a [TectaDialog] modal dialog component.
  const TectaDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.onClose,
    this.maxWidth = 400.0,
    this.scrollable = false,
    this.isFullscreen = false,
    this.borderRadius,
    this.padding,
    this.backgroundColor,
    this.shadowColor,
    this.elevation,
    this.titleStyle,
    this.closeIconColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isFullscreen) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: title != null ? Text(title!) : null,
          leading: onClose != null
              ? IconButton(icon: const Icon(Icons.close), onPressed: onClose)
              : null,
          actions: actions,
        ),
        body: content != null
            ? (scrollable ? SingleChildScrollView(child: content!) : content!)
            : null,
      );
    }

    final BorderRadiusGeometry radius = borderRadius ?? BorderRadius.circular(16.0);
    final EdgeInsetsGeometry innerPadding = padding ?? const EdgeInsets.all(24.0);
    final Color bg = backgroundColor ?? TectaColors.white;
    final Color sColor = shadowColor ?? Colors.black.withValues(alpha: 0.24);
    final double elev = elevation ?? 24.0;
    final Color closeColor = closeIconColor ?? TectaColors.grey500;

    final TextStyle defaultTitleStyle = TectaTypography.h6.copyWith(
      color: TectaColors.grey800,
      fontWeight: FontWeight.w700,
    );

    return Dialog(
      backgroundColor: bg,
      shadowColor: sColor,
      elevation: elev,
      shape: RoundedRectangleBorder(borderRadius: radius),
      clipBehavior: Clip.antiAlias,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: innerPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row (Title & Close Button)
            if (title != null || onClose != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Expanded(child: Text(title!, style: titleStyle ?? defaultTitleStyle)),
                  if (onClose != null)
                    IconButton(
                      icon: Icon(Icons.close, color: closeColor),
                      onPressed: onClose,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
              const SizedBox(height: 16.0),
            ],

            // Content Area
            if (content != null)
              Flexible(
                child: scrollable
                    ? SingleChildScrollView(physics: const BouncingScrollPhysics(), child: content!)
                    : content!,
              ),

            // Actions Row
            if (actions != null && actions!.isNotEmpty) ...[
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!.map((action) {
                  return Padding(padding: const EdgeInsets.only(left: 8.0), child: action);
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Launches a premium [TectaDialog] with a subtle bounce scale and fade entry transition.
Future<T?> showTectaDialog<T>(
  BuildContext context, {
  required Widget child,
  bool barrierDismissible = true,
  Color? barrierColor,
}) {
  final Color overlayColor = barrierColor ?? Colors.black.withValues(alpha: 0.5);

  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'TectaDialog',
    barrierColor: overlayColor, // Premium dimmed background overlay
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, anim1, anim2) => child,
    transitionBuilder: (context, anim1, anim2, child) {
      final double scale = CurvedAnimation(parent: anim1, curve: Curves.easeOutBack).value;

      return Transform.scale(
        scale: scale,
        child: FadeTransition(opacity: anim1, child: child),
      );
    },
  );
}
