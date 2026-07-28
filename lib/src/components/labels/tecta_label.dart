import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Visual variants for [TectaLabel].
enum TectaLabelVariant {
  /// Filled background with high-contrast text.
  filled,
  /// Outlined border with transparent background.
  outlined,
  /// Translucent colored background with matching text color.
  soft,
  /// Inverted/dark background with light text.
  inverted
}

/// A premium, highly customizable status Label/Badge component matching Minimals design language.
///
/// Features:
/// - Four visual styles: [TectaLabelVariant.filled], [TectaLabelVariant.outlined], [TectaLabelVariant.soft], and [TectaLabelVariant.inverted].
/// - Accepts standard Flutter [Color] or pre-defined [TectaColors].
/// - Prefix ([startIcon]) and suffix ([endIcon]) icon support.
class TectaLabel extends StatelessWidget {
  /// The text content displayed inside the label.
  final String text;

  /// The visual variant style. Defaults to [TectaLabelVariant.soft].
  final TectaLabelVariant variant;

  /// Custom theme color for the label (accepts any Flutter [Color]). Defaults to [TectaColors.grey800].
  final Color? color;

  /// Optional prefix icon widget.
  final Widget? startIcon;

  /// Optional suffix icon widget.
  final Widget? endIcon;

  /// Custom background color override.
  final Color? backgroundColorOverride;

  /// Custom text and icon color override.
  final Color? textColorOverride;

  /// Custom border color override.
  final Color? borderColorOverride;

  /// Custom border radius override. Defaults to `BorderRadius.circular(6.0)`.
  final BorderRadiusGeometry? borderRadiusOverride;

  /// Custom padding inside the label. Defaults to `EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)`.
  final EdgeInsetsGeometry? paddingOverride;

  /// Custom text style override for the text label.
  final TextStyle? textStyleOverride;

  /// Creates a [TectaLabel] status label component.
  const TectaLabel({
    super.key,
    required this.text,
    this.variant = TectaLabelVariant.soft,
    this.color,
    this.startIcon,
    this.endIcon,
    this.backgroundColorOverride,
    this.textColorOverride,
    this.borderColorOverride,
    this.borderRadiusOverride,
    this.paddingOverride,
    this.textStyleOverride,
  });

  @override
  Widget build(BuildContext context) {
    final Color baseColor = color ?? TectaColors.grey800;
    final Color activeColor = TectaColors.resolve(context, baseColor);

    Color bg;
    Color txtColor;
    Border? border;

    switch (variant) {
      case TectaLabelVariant.filled:
        bg = activeColor;
        txtColor = activeColor.computeLuminance() > 0.5
            ? TectaColors.grey900
            : TectaColors.white;
        border = borderColorOverride != null ? Border.all(color: borderColorOverride!) : null;
        break;

      case TectaLabelVariant.outlined:
        bg = Colors.transparent;
        txtColor = activeColor;
        border = Border.all(color: borderColorOverride ?? activeColor, width: 1.0);
        break;

      case TectaLabelVariant.soft:
        bg = activeColor.withValues(alpha: 0.08);
        txtColor = activeColor;
        border = borderColorOverride != null ? Border.all(color: borderColorOverride!) : null;
        break;

      case TectaLabelVariant.inverted:
        bg = activeColor.withValues(alpha: 0.16);
        txtColor = activeColor;
        border = borderColorOverride != null ? Border.all(color: borderColorOverride!) : null;
        break;
    }

    final Color finalBg = backgroundColorOverride ?? bg;
    final Color finalTxtColor = textColorOverride ?? txtColor;
    final BorderRadiusGeometry radius = borderRadiusOverride ?? BorderRadius.circular(6.0);
    final EdgeInsetsGeometry padding =
        paddingOverride ?? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);

    final TextStyle defaultStyle = TectaTypography.overline.copyWith(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: finalTxtColor,
    );

    final TextStyle finalTextStyle = textStyleOverride ?? defaultStyle;

    return Container(
      decoration: BoxDecoration(color: finalBg, border: border, borderRadius: radius),
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (startIcon != null) ...[
            IconTheme.merge(
              data: IconThemeData(color: finalTxtColor, size: 12.0),
              child: startIcon!,
            ),
            const SizedBox(width: 4.0),
          ],
          Text(text, style: finalTextStyle),
          if (endIcon != null) ...[
            const SizedBox(width: 4.0),
            IconTheme.merge(
              data: IconThemeData(color: finalTxtColor, size: 12.0),
              child: endIcon!,
            ),
          ],
        ],
      ),
    );
  }
}
