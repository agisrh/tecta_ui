import 'package:flutter/material.dart';
import 'tecta_colors.dart';

/// Defines the typography scale for the Tecta Design System.
/// Uses the Google Sans font family with configured font weights and heights.
class TectaTypography {
  TectaTypography._();

  // ===========================================================================
  // HEADINGS
  // ===========================================================================

  /// H1 - Display Medium
  static TextStyle get h1 => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: TectaColors.grey800,
    height: 1.2,
  );

  /// H2 - Headline Large
  static TextStyle get h2 => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: TectaColors.grey800,
    height: 1.25,
  );

  /// H3 - Headline Medium
  static TextStyle get h3 => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: TectaColors.grey800,
    height: 1.3,
  );

  /// H4 - Title Large
  static TextStyle get h4 => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: TectaColors.grey800,
    height: 1.35,
  );

  /// H5 - Title Medium
  static TextStyle get h5 => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: TectaColors.grey800,
    height: 1.4,
  );

  /// H6 - Title Small
  static TextStyle get h6 => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: TectaColors.grey800,
    height: 1.45,
  );

  // ===========================================================================
  // SUBTITLES
  // ===========================================================================

  /// Subtitle 1 - Label Large
  static TextStyle get subtitle1 => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: TectaColors.grey800,
    height: 1.5,
  );

  /// Subtitle 2 - Label Medium
  static TextStyle get subtitle2 => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: TectaColors.grey800,
    height: 1.57,
  );

  // ===========================================================================
  // BODY TEXT
  // ===========================================================================

  /// Body 1 - Body Large
  static TextStyle get body1 => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: TectaColors.grey800,
    height: 1.5,
  );

  /// Body 2 - Body Medium
  static TextStyle get body2 => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: TectaColors.grey600,
    height: 1.43,
  );

  // ===========================================================================
  // SMALL / CAPTIONS
  // ===========================================================================

  /// Caption - Body Small
  static TextStyle get caption => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: TectaColors.grey500,
    height: 1.5,
  );

  /// Overline - Label Small
  static TextStyle get overline => const TextStyle(
    fontFamily: 'Google Sans',
    package: 'tecta_ui',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
    color: TectaColors.grey600,
    height: 1.5,
  );
}
