import 'package:flutter/material.dart';
import 'package:tecta_ui/src/foundation/tecta_colors.dart';
import 'package:tecta_ui/src/foundation/tecta_typography.dart';

/// Defines the global Light and Dark ThemeData for the Tecta Design System.
/// Adapts core colors, Google Sans typography, and custom widget themes.
class TectaTheme {
  TectaTheme._();

  /// Returns the configured Light ThemeData
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'packages/tecta_ui/Google Sans',
      scaffoldBackgroundColor: TectaColors.grey100,
      cardColor: TectaColors.white,
      dividerColor: TectaColors.grey300.withValues(alpha: 0.5),
      colorScheme: const ColorScheme.light(
        primary: TectaColors.primaryMain,
        secondary: TectaColors.secondaryMain,
        surface: TectaColors.white,
        error: TectaColors.errorMain,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: TectaColors.white,
        foregroundColor: TectaColors.grey800,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      textTheme: TextTheme(
        displayMedium: TectaTypography.h1,
        headlineLarge: TectaTypography.h2,
        headlineMedium: TectaTypography.h3,
        titleLarge: TectaTypography.h4,
        titleMedium: TectaTypography.h5,
        titleSmall: TectaTypography.h6,
        labelLarge: TectaTypography.subtitle1,
        labelMedium: TectaTypography.subtitle2,
        bodyLarge: TectaTypography.body1,
        bodyMedium: TectaTypography.body2,
        bodySmall: TectaTypography.caption,
        labelSmall: TectaTypography.overline,
      ),
    );
  }

  /// Returns the configured Dark ThemeData
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'packages/tecta_ui/Google Sans',
      scaffoldBackgroundColor: TectaColors.grey900,
      cardColor: TectaColors.grey800,
      dividerColor: TectaColors.grey700.withValues(alpha: 0.5),
      colorScheme: const ColorScheme.dark(
        primary: TectaColors.primaryMain,
        secondary: TectaColors.secondaryMain,
        surface: TectaColors.grey800,
        error: TectaColors.errorMain,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: TectaColors.grey900,
        foregroundColor: TectaColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      textTheme: TextTheme(
        displayMedium: TectaTypography.h1.copyWith(color: TectaColors.white),
        headlineLarge: TectaTypography.h2.copyWith(color: TectaColors.white),
        headlineMedium: TectaTypography.h3.copyWith(color: TectaColors.white),
        titleLarge: TectaTypography.h4.copyWith(color: TectaColors.white),
        titleMedium: TectaTypography.h5.copyWith(color: TectaColors.white),
        titleSmall: TectaTypography.h6.copyWith(color: TectaColors.white),
        labelLarge: TectaTypography.subtitle1.copyWith(color: TectaColors.white),
        labelMedium: TectaTypography.subtitle2.copyWith(color: TectaColors.white),
        bodyLarge: TectaTypography.body1.copyWith(color: TectaColors.white),
        bodyMedium: TectaTypography.body2.copyWith(color: TectaColors.grey400),
        bodySmall: TectaTypography.caption.copyWith(color: TectaColors.grey500),
        labelSmall: TectaTypography.overline.copyWith(color: TectaColors.grey400),
      ),
    );
  }
}
