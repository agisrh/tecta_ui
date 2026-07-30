import 'package:flutter/material.dart';
import 'package:tecta_ui/src/foundation/tecta_colors.dart';
import 'package:tecta_ui/src/foundation/tecta_typography.dart';

/// Defines the global Light and Dark ThemeData for the Tecta Design System.
/// Adapts core colors, Google Sans typography, and custom widget themes.
class TectaTheme {
  TectaTheme._();

  /// Returns the configured Light ThemeData
  static ThemeData get lightTheme => buildTheme(brightness: Brightness.light);

  /// Returns the configured Dark ThemeData
  static ThemeData get darkTheme => buildTheme(brightness: Brightness.dark);

  /// Builds a customized ThemeData with dynamic colors
  static ThemeData buildTheme({
    required Brightness brightness,
    Color? primaryColor,
    Color? secondaryColor,
  }) {
    final isDark = brightness == Brightness.dark;
    final primary = primaryColor ?? TectaColors.primaryMain;
    final secondary = secondaryColor ?? TectaColors.secondaryMain;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'packages/tecta_ui/Google Sans',
      scaffoldBackgroundColor: isDark ? TectaColors.grey900 : TectaColors.grey100,
      cardColor: isDark ? TectaColors.grey800 : TectaColors.white,
      dividerColor: (isDark ? TectaColors.grey700 : TectaColors.grey300).withValues(alpha: 0.5),
      colorScheme: isDark
          ? ColorScheme.dark(
              primary: primary,
              secondary: secondary,
              surface: TectaColors.grey800,
              error: TectaColors.errorMain,
            )
          : ColorScheme.light(
              primary: primary,
              secondary: secondary,
              surface: TectaColors.white,
              error: TectaColors.errorMain,
            ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? TectaColors.grey900 : TectaColors.white,
        foregroundColor: isDark ? TectaColors.white : TectaColors.grey800,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      textTheme: TextTheme(
        displayMedium: isDark
            ? TectaTypography.h1.copyWith(color: TectaColors.white)
            : TectaTypography.h1,
        headlineLarge: isDark
            ? TectaTypography.h2.copyWith(color: TectaColors.white)
            : TectaTypography.h2,
        headlineMedium: isDark
            ? TectaTypography.h3.copyWith(color: TectaColors.white)
            : TectaTypography.h3,
        titleLarge: isDark
            ? TectaTypography.h4.copyWith(color: TectaColors.white)
            : TectaTypography.h4,
        titleMedium: isDark
            ? TectaTypography.h5.copyWith(color: TectaColors.white)
            : TectaTypography.h5,
        titleSmall: isDark
            ? TectaTypography.h6.copyWith(color: TectaColors.white)
            : TectaTypography.h6,
        labelLarge: isDark
            ? TectaTypography.subtitle1.copyWith(color: TectaColors.white)
            : TectaTypography.subtitle1,
        labelMedium: isDark
            ? TectaTypography.subtitle2.copyWith(color: TectaColors.white)
            : TectaTypography.subtitle2,
        bodyLarge: isDark
            ? TectaTypography.body1.copyWith(color: TectaColors.white)
            : TectaTypography.body1,
        bodyMedium: isDark
            ? TectaTypography.body2.copyWith(color: TectaColors.grey400)
            : TectaTypography.body2,
        bodySmall: isDark
            ? TectaTypography.caption.copyWith(color: TectaColors.grey500)
            : TectaTypography.caption,
        labelSmall: isDark
            ? TectaTypography.overline.copyWith(color: TectaColors.grey400)
            : TectaTypography.overline,
      ),
    );
  }
}
