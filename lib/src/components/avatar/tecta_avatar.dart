import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// The visual shapes supported by the [TectaAvatar] component.
enum TectaAvatarShape { circle, rounded, square }

/// A premium, highly customizable status indicator or overlay badge for the [TectaAvatar].
/// Displays on the bottom-right corner of the avatar.
class TectaAvatarBadge extends StatelessWidget {
  /// The child widget to display inside the badge (e.g. an icon or smaller widget).
  final Widget? child;

  /// The background color of the badge.
  final Color backgroundColor;

  /// The diameter size of the badge. Defaults to `12.0`.
  final double size;

  /// The color of the outer border ring. Defaults to [Colors.white].
  final Color borderColor;

  /// The width of the outer border ring. Defaults to `1.5`.
  final double borderWidth;

  /// Creates a [TectaAvatarBadge] overlay status indicator.
  const TectaAvatarBadge({
    super.key,
    this.child,
    required this.backgroundColor,
    this.size = 12.0,
    this.borderColor = Colors.white,
    this.borderWidth = 1.5,
  });

  /// Factory for a green "Online" status dot badge.
  factory TectaAvatarBadge.online({
    double size = 12.0,
    Color borderColor = Colors.white,
    double borderWidth = 1.5,
  }) {
    return TectaAvatarBadge(
      key: const ValueKey('badge_online'),
      backgroundColor: TectaColors.successMain,
      size: size,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }

  /// Factory for a yellow "Away" clock status dot badge.
  factory TectaAvatarBadge.away({
    double size = 12.0,
    Color borderColor = Colors.white,
    double borderWidth = 1.5,
  }) {
    return TectaAvatarBadge(
      key: const ValueKey('badge_away'),
      backgroundColor: TectaColors.warningMain,
      size: size,
      borderColor: borderColor,
      borderWidth: borderWidth,
      child: Icon(
        Icons.access_time_filled_rounded,
        size: size * 0.75,
        color: TectaColors.warningDarker,
      ),
    );
  }

  /// Factory for a red "Busy" horizontal minus status dot badge.
  factory TectaAvatarBadge.busy({
    double size = 12.0,
    Color borderColor = Colors.white,
    double borderWidth = 1.5,
  }) {
    return TectaAvatarBadge(
      key: const ValueKey('badge_busy'),
      backgroundColor: TectaColors.errorMain,
      size: size,
      borderColor: borderColor,
      borderWidth: borderWidth,
      child: Center(
        child: Container(width: size * 0.5, height: 1.5, color: Colors.white),
      ),
    );
  }

  /// Factory for a grey "Offline" circle-outline status dot badge.
  factory TectaAvatarBadge.offline({
    double size = 12.0,
    Color borderColor = Colors.white,
    double borderWidth = 1.5,
  }) {
    return TectaAvatarBadge(
      key: const ValueKey('badge_offline'),
      backgroundColor: TectaColors.grey500,
      size: size,
      borderColor: borderColor,
      borderWidth: borderWidth,
      child: Center(
        child: Container(
          width: size * 0.45,
          height: size * 0.45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localChild = child;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      alignment: Alignment.center,
      child: localChild,
    );
  }
}

/// A premium, highly customizable Avatar component for the Tecta Design System.
/// Support image, letter, and icon types with custom sizes, shapes, and badges.
class TectaAvatar extends StatelessWidget {
  /// The user profile image provider.
  final ImageProvider? image;

  /// Initials or letters for a text fallback avatar (e.g. "JD" or "A").
  final String? text;

  /// An icon or custom widget for an icon-type avatar.
  final Widget? icon;

  /// The diameter/size of the avatar. Defaults to `40.0`.
  final double size;

  /// The visual shape of the avatar card. Defaults to [TectaAvatarShape.circle].
  final TectaAvatarShape shape;

  /// Custom border radius if the shape is [TectaAvatarShape.rounded]. Defaults to `12.0`.
  final BorderRadiusGeometry? borderRadius;

  /// Custom background color override.
  /// If null, is automatically derived for letters or defaults to grey.
  final Color? backgroundColor;

  /// Custom text style override for initials/letters.
  final TextStyle? textStyle;

  /// Custom text color override.
  final Color? textColor;

  /// An optional status indicator or sub-avatar overlay widget placed at the bottom-right corner.
  final Widget? badge;

  /// Custom border decoration around the avatar.
  final BoxBorder? border;

  /// Creates a [TectaAvatar] to display user images, text initials, or icons.
  const TectaAvatar({
    super.key,
    this.image,
    this.text,
    this.icon,
    this.size = 40.0,
    this.shape = TectaAvatarShape.circle,
    this.borderRadius,
    this.backgroundColor,
    this.textStyle,
    this.textColor,
    this.badge,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final localImage = image;
    final localText = text;
    final localIcon = icon;
    final localBadge = badge;

    final resolvedBorderRadius = shape == TectaAvatarShape.circle
        ? null
        : (borderRadius ?? BorderRadius.circular(size * 0.28));

    // Resolve color pair based on text hash, or custom overrides, or generic defaults.
    final colorPair = _resolveColors(localText);
    final finalBgColor = backgroundColor ?? colorPair.bg;
    final finalTextColor = textColor ?? colorPair.text;

    final baseTextStyle =
        textStyle ??
        TectaTypography.subtitle2.copyWith(fontSize: size * 0.38, fontWeight: FontWeight.w700);
    final finalTextStyle = baseTextStyle.copyWith(color: finalTextColor);

    // Build the main avatar content area.
    Widget content;
    if (localImage != null) {
      Widget img = Image(
        image: localImage,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback(localText, localIcon, finalTextStyle, finalTextColor);
        },
      );

      // Explicitly clip the image based on shape to ensure robust circular/rounded rendering in all environments.
      if (shape == TectaAvatarShape.circle) {
        img = ClipOval(child: img);
      } else if (shape == TectaAvatarShape.rounded) {
        final radius = resolvedBorderRadius ?? BorderRadius.circular(size * 0.28);
        if (radius is BorderRadius) {
          img = ClipRRect(borderRadius: radius, child: img);
        }
      }
      content = img;
    } else {
      content = _buildFallback(localText, localIcon, finalTextStyle, finalTextColor);
    }

    Widget avatarWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: shape == TectaAvatarShape.circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: resolvedBorderRadius,
        color: finalBgColor,
        border: border,
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: content,
    );

    if (localBadge != null) {
      // Calculate layout offset based on shape and size
      final double offset = size * 0.03;
      avatarWidget = SizedBox(
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(child: avatarWidget),
            Positioned(right: -offset, bottom: -offset, child: localBadge),
          ],
        ),
      );
    }

    return Semantics(
      container: true,
      label: 'Avatar. ${localText != null ? "Initials: $localText" : "User profile"}',
      child: avatarWidget,
    );
  }

  Widget _buildFallback(
    String? localText,
    Widget? localIcon,
    TextStyle finalTextStyle,
    Color finalTextColor,
  ) {
    if (localText != null && localText.trim().isNotEmpty) {
      return Text(localText.trim().toUpperCase(), style: finalTextStyle);
    } else if (localIcon != null) {
      return IconTheme.merge(
        data: IconThemeData(color: finalTextColor, size: size * 0.55),
        child: localIcon,
      );
    }
    return Icon(Icons.person_rounded, color: finalTextColor, size: size * 0.6);
  }

  _ColorPair _resolveColors(String? text) {
    if (text == null || text.trim().isEmpty) {
      // Generic fallback (light grey background, dark grey text)
      return const _ColorPair(bg: TectaColors.grey200, text: TectaColors.grey600);
    }

    // Hash the input string to choose a color combination.
    // This allows different user initials to automatically render with distinct, beautiful palettes.
    final cleanText = text.trim();
    final int hash = cleanText.codeUnits.fold(0, (prev, val) => prev + val);
    final index = hash % _colorPairs.length;
    return _colorPairs[index];
  }

  // Pre-configured harmonious color pairings (matching Kalog palette specs)
  static final List<_ColorPair> _colorPairs = [
    const _ColorPair(bg: TectaColors.secondaryLighter, text: TectaColors.secondaryMain),
    const _ColorPair(bg: TectaColors.primaryLighter, text: TectaColors.primaryMain),
    const _ColorPair(bg: TectaColors.successLighter, text: TectaColors.successDarker),
    const _ColorPair(bg: TectaColors.infoLighter, text: TectaColors.infoDarker),
    const _ColorPair(bg: TectaColors.warningLighter, text: TectaColors.warningDarker),
    const _ColorPair(bg: TectaColors.errorLighter, text: TectaColors.errorDarker),
    const _ColorPair(bg: TectaColors.grey200, text: TectaColors.grey800),
    const _ColorPair(bg: TectaColors.grey900, text: TectaColors.white),
  ];
}

class _ColorPair {
  final Color bg;
  final Color text;

  const _ColorPair({required this.bg, required this.text});
}
