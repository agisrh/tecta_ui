import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium, highly customizable widget to group and stack multiple [TectaAvatar]s horizontally.
class TectaAvatarGroup extends StatelessWidget {
  /// The list of [TectaAvatar] children to stack.
  final List<TectaAvatar> children;

  /// The maximum number of avatars to show before adding a trailing `+count` indicator.
  /// If null, all avatars are rendered.
  final int? max;

  /// The overlap spacing distance in logical pixels. Defaults to `12.0`.
  final double overlap;

  /// Universal size override for all grouped avatars.
  /// If provided, overrides each child's individual size property.
  final double? size;

  /// Custom shape override for all grouped avatars.
  /// If provided, overrides each child's shape.
  final TectaAvatarShape? shape;

  /// Custom background color for the trailing `+count` indicator.
  /// Defaults to a soft success green background.
  final Color? placeholderBackgroundColor;

  /// Custom text style for the trailing `+count` text.
  final TextStyle? placeholderTextStyle;

  /// Custom separating border color. Defaults to [ThemeData.cardColor] (e.g. White).
  final Color? borderColor;

  /// Custom separating border width. Defaults to `2.0` logical pixels.
  final double borderWidth;

  /// Creates a [TectaAvatarGroup] to display a stacked list of avatars.
  const TectaAvatarGroup({
    super.key,
    required this.children,
    this.max,
    this.overlap = 12.0,
    this.size,
    this.shape,
    this.placeholderBackgroundColor,
    this.placeholderTextStyle,
    this.borderColor,
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final resolvedBorder = Border.all(color: borderColor ?? theme.cardColor, width: borderWidth);

    final localMax = max;
    final double resolvedSize = size ?? children.first.size;
    final TectaAvatarShape resolvedShape = shape ?? children.first.shape;

    // Determine how many avatars to display and how many to fold.
    List<Widget> itemsToDisplay = [];
    int foldCount = 0;

    if (localMax != null && children.length > localMax) {
      itemsToDisplay = children
          .take(localMax)
          .map((avatar) => _overrideAvatar(avatar, resolvedSize, resolvedShape, resolvedBorder))
          .toList();
      foldCount = children.length - localMax;
    } else {
      itemsToDisplay = children
          .map((avatar) => _overrideAvatar(avatar, resolvedSize, resolvedShape, resolvedBorder))
          .toList();
    }

    // Add the trailing +count placeholder if we folded any avatars.
    if (foldCount > 0) {
      final bg = placeholderBackgroundColor ?? TectaColors.successLighter;
      final textStyle =
          placeholderTextStyle ??
          TectaTypography.subtitle2.copyWith(
            fontSize: resolvedSize * 0.38,
            fontWeight: FontWeight.w700,
            color: TectaColors.successDarker,
          );

      final placeholder = TectaAvatar(
        key: const ValueKey('group_placeholder'),
        size: resolvedSize,
        shape: resolvedShape,
        backgroundColor: bg,
        text: '+$foldCount',
        textStyle: textStyle,
        border: resolvedBorder,
      );
      itemsToDisplay.add(placeholder);
    }

    // Calculate overlap factor.
    final double widthFactor = resolvedSize > 0
        ? ((resolvedSize - overlap) / resolvedSize).clamp(0.1, 1.0)
        : 0.7;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemsToDisplay.length, (index) {
        final child = itemsToDisplay[index];
        final isLast = index == itemsToDisplay.length - 1;

        if (isLast) {
          return child;
        }

        return Align(widthFactor: widthFactor, alignment: Alignment.centerLeft, child: child);
      }),
    );
  }

  /// Helper to override the size and shape properties of children to ensure consistency within the stack.
  Widget _overrideAvatar(
    TectaAvatar avatar,
    double resolvedSize,
    TectaAvatarShape resolvedShape,
    BoxBorder resolvedBorder,
  ) {
    return TectaAvatar(
      key: avatar.key,
      image: avatar.image,
      text: avatar.text,
      icon: avatar.icon,
      size: resolvedSize,
      shape: resolvedShape,
      borderRadius: avatar.borderRadius,
      backgroundColor: avatar.backgroundColor,
      textStyle: avatar.textStyle,
      textColor: avatar.textColor,
      badge: avatar.badge,
      border: avatar.border ?? resolvedBorder,
    );
  }
}
