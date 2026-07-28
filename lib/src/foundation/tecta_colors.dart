import 'package:flutter/material.dart';

/// Defines the color palette for the Tecta Design System.
/// Consists of brand colors (Deep Blue & Orange), semantic colors, and neutral greys.
class TectaColors {
  TectaColors._();

  // ===========================================================================
  // BRAND COLORS
  // ===========================================================================

  /// Primary (Deep Blue) - Lighter shade
  static const Color primaryLighter = Color(0xFFE6EDFA);

  /// Primary (Deep Blue) - Light shade
  static const Color primaryLight = Color(0xFF7D9ECF);

  /// Primary (Deep Blue) - Main brand color (e.g. primary buttons, active icons)
  static const Color primaryMain = Color(0xFF0F2B5C);

  /// Primary (Deep Blue) - Dark shade (e.g. hover/pressed states)
  static const Color primaryDark = Color(0xFF0A1E42);

  /// Primary (Deep Blue) - Darkest shade
  static const Color primaryDarker = Color(0xFF050F22);

  /// Secondary (Orange) - Lighter shade (e.g. background of chip/badge)
  static const Color secondaryLighter = Color(0xFFFFECE4);

  /// Secondary (Orange) - Light shade (e.g. light borders)
  static const Color secondaryLight = Color(0xFFFFB399);

  /// Secondary (Orange) - Main brand color
  static const Color secondaryMain = Color(0xFFF05A24);

  /// Secondary (Orange) - Dark shade
  static const Color secondaryDark = Color(0xFFC84517);

  /// Secondary (Orange) - Darkest shade (e.g. contrast text on light orange background)
  static const Color secondaryDarker = Color(0xFF802B0E);

  // ===========================================================================
  // SEMANTIC COLORS
  // ===========================================================================

  // Success
  /// Success color - Lighter shade
  static const Color successLighter = Color(0xFFE1F8EB);
  /// Success color - Light shade
  static const Color successLight = Color(0xFF86EFAC);
  /// Success color - Main semantic shade
  static const Color successMain = Color(0xFF22C55E);
  /// Success color - Dark shade
  static const Color successDark = Color(0xFF16A34A);
  /// Success color - Darkest shade
  static const Color successDarker = Color(0xFF115E59);

  // Warning
  /// Warning color - Lighter shade
  static const Color warningLighter = Color(0xFFFFF5CC);
  /// Warning color - Light shade
  static const Color warningLight = Color(0xFFFFD666);
  /// Warning color - Main semantic shade
  static const Color warningMain = Color(0xFFFFAB00);
  /// Warning color - Dark shade
  static const Color warningDark = Color(0xFFB77900);
  /// Warning color - Darkest shade
  static const Color warningDarker = Color(0xFF7A4F01);

  // Error
  /// Error color - Lighter shade
  static const Color errorLighter = Color(0xFFFFE9D5);
  /// Error color - Light shade
  static const Color errorLight = Color(0xFFFFAC82);
  /// Error color - Main semantic shade
  static const Color errorMain = Color(0xFFFF5630);
  /// Error color - Dark shade
  static const Color errorDark = Color(0xFFB7211F);
  /// Error color - Darkest shade
  static const Color errorDarker = Color(0xFF7A0C2E);

  // Info
  /// Info color - Lighter shade
  static const Color infoLighter = Color(0xFFCAFDF5);
  /// Info color - Light shade
  static const Color infoLight = Color(0xFF61F3F3);
  /// Info color - Main semantic shade
  static const Color infoMain = Color(0xFF00B8D9);
  /// Info color - Dark shade
  static const Color infoDark = Color(0xFF006C9C);
  /// Info color - Darkest shade
  static const Color infoDarker = Color(0xFF003768);

  // ===========================================================================
  // NEUTRAL COLORS (Greys)
  // ===========================================================================

  /// Neutral grey 50
  static const Color grey50 = Color(0xFFFDFDFD);
  /// Neutral grey 100
  static const Color grey100 = Color(0xFFF9FAFB);
  /// Neutral grey 200
  static const Color grey200 = Color(0xFFF4F6F8);
  /// Neutral grey 300
  static const Color grey300 = Color(0xFFDFE3E8);
  /// Neutral grey 400
  static const Color grey400 = Color(0xFFC4CDD5);
  /// Neutral grey 500
  static const Color grey500 = Color(0xFF919EAB);
  /// Neutral grey 600
  static const Color grey600 = Color(0xFF637381);
  /// Neutral grey 700
  static const Color grey700 = Color(0xFF454F5B);
  /// Neutral grey 800
  static const Color grey800 = Color(0xFF212B36);
  /// Neutral grey 900
  static const Color grey900 = Color(0xFF161C24);

  // Common Constants
  /// Common solid white color
  static const Color white = Color(0xFFFFFFFF);
  /// Common solid black color
  static const Color black = Color(0xFF000000);

  /// Dynamically resolves the color to its adaptive dark-mode equivalent if dark mode is active.
  static Color resolve(BuildContext context, Color color) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    if (!isDark) return color;

    if (color == TectaColors.primaryMain) {
      return theme.colorScheme.primary;
    } else if (color == TectaColors.secondaryMain) {
      return theme.colorScheme.secondary;
    } else if (color == TectaColors.infoMain) {
      return TectaColors.infoLight;
    } else if (color == TectaColors.successMain) {
      return TectaColors.successLight;
    } else if (color == TectaColors.warningMain) {
      return TectaColors.warningLight;
    } else if (color == TectaColors.errorMain) {
      return theme.colorScheme.error;
    }
    return color;
  }

  /// Context-dependent helper for primary color
  static Color primary(BuildContext context) => resolve(context, primaryMain);

  /// Context-dependent helper for secondary color
  static Color secondary(BuildContext context) => resolve(context, secondaryMain);

  /// Context-dependent helper for info color
  static Color info(BuildContext context) => resolve(context, infoMain);

  /// Context-dependent helper for success color
  static Color success(BuildContext context) => resolve(context, successMain);

  /// Context-dependent helper for warning color
  static Color warning(BuildContext context) => resolve(context, warningMain);

  /// Context-dependent helper for error color
  static Color error(BuildContext context) => resolve(context, errorMain);
}
