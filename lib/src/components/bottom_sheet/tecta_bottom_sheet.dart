import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium, highly customizable Bottom Sheet component matching Minimals design language.
///
/// Features:
/// - Capsule-styled drag handle at the top.
/// - Top rounded corners matching modern card shapes.
/// - Optional title header support.
/// - Full layout style overrides (colors, paddings, corners).
class TectaBottomSheet extends StatelessWidget {
  /// Optional title displayed at the top.
  final String? title;

  /// The body content of the bottom sheet.
  final Widget content;

  /// Whether to show the top drag handle pill. Defaults to `true`.
  final bool showHandle;

  /// Custom background color override. Defaults to [TectaColors.white].
  final Color? backgroundColor;

  /// Custom border radius override. Defaults to top rounded `24.0`.
  final BorderRadiusGeometry? borderRadius;

  /// Custom padding inside the bottom sheet. Defaults to `EdgeInsets.only(top: 8.0, left: 24.0, right: 24.0, bottom: 24.0)`.
  final EdgeInsetsGeometry? padding;

  /// Custom text style override for the title.
  final TextStyle? titleStyle;

  /// Custom action widgets in the header (e.g. Close, Done).
  final List<Widget>? actions;

  /// Custom color override for the top drag handle. Defaults to [TectaColors.grey300].
  final Color? handleColor;

  /// Custom width override for the top drag handle. Defaults to `40.0`.
  final double? handleWidth;

  /// Custom height override for the top drag handle. Defaults to `4.0`.
  final double? handleHeight;

  /// Creates a [TectaBottomSheet] modal sheet.
  const TectaBottomSheet({
    super.key,
    this.title,
    required this.content,
    this.showHandle = true,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.titleStyle,
    this.actions,
    this.handleColor,
    this.handleWidth,
    this.handleHeight,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = backgroundColor ?? TectaColors.white;
    final BorderRadiusGeometry radius =
        borderRadius ?? const BorderRadius.vertical(top: Radius.circular(24.0));
    final EdgeInsetsGeometry innerPadding =
        padding ?? const EdgeInsets.only(top: 8.0, left: 24.0, right: 24.0, bottom: 24.0);

    final TextStyle defaultTitleStyle = TectaTypography.h6.copyWith(
      color: TectaColors.grey800,
      fontWeight: FontWeight.w700,
    );

    final Color hColor = handleColor ?? TectaColors.grey300;
    final double hWidth = handleWidth ?? 40.0;
    final double hHeight = handleHeight ?? 4.0;

    return Material(
      color: bg,
      borderRadius: radius,
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Drag Handle
            if (showHandle) ...[
              const SizedBox(height: 8.0),
              Center(
                child: Container(
                  width: hWidth,
                  height: hHeight,
                  decoration: BoxDecoration(
                    color: hColor,
                    borderRadius: BorderRadius.circular(hHeight / 2),
                  ),
                ),
              ),
            ],

            // Header Row (Title & Actions) - placed outside inner padding to avoid nesting columns
            if (title != null || (actions != null && actions!.isNotEmpty)) ...[
              Padding(
                padding: EdgeInsets.only(
                  left: innerPadding.horizontal / 2,
                  right: innerPadding.horizontal / 2,
                  top: 12.0,
                  bottom: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (title != null)
                      Expanded(child: Text(title!, style: titleStyle ?? defaultTitleStyle)),
                    if (actions != null && actions!.isNotEmpty)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions!.map((act) {
                          return Padding(padding: const EdgeInsets.only(left: 8.0), child: act);
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ],

            // Content Widget - wrapped directly in Flexible
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                  left: innerPadding.horizontal / 2,
                  right: innerPadding.horizontal / 2,
                  bottom: (innerPadding as EdgeInsets).bottom,
                  top: (title == null && (actions == null || actions!.isEmpty)) ? 8.0 : 0.0,
                ),
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Launches a premium [TectaBottomSheet] with proper transparent constraints.
Future<T?> showTectaBottomSheet<T>(
  BuildContext context, {
  required Widget child,
  bool isDismissible = true,
  bool enableDrag = true,
  Color? barrierColor,
  bool isScrollControlled = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.5),
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    isScrollControlled: isScrollControlled,
    builder: (context) => child,
  );
}
