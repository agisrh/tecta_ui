import 'package:flutter/material.dart';
import 'tecta_colors.dart';

/// Defines the custom soft shadow styles for the Tecta Design System.
/// Uses a centralized double-layer shadow generator for professional depth.
class TectaShadows {
  TectaShadows._();

  /// Centralized master function to generate a smooth double-layer soft shadow.
  static List<BoxShadow> custom({
    Color color = TectaColors.grey500,
    double blur = 16,
    Offset offset = const Offset(0, 8),
    double opacity = 0.08,
  }) {
    return [
      BoxShadow(
        color: color.withValues(alpha: opacity),
        blurRadius: blur,
        offset: offset,
      ),
      BoxShadow(
        color: color.withValues(alpha: opacity / 2),
        blurRadius: blur * 1.5,
        offset: offset * 2,
      ),
    ];
  }

  // ===========================================================================
  // STANDARD SHADOW TOKENS
  // ===========================================================================

  /// z1 shadow - extremely subtle, for small elements (inputs, chips)
  static List<BoxShadow> get z1 => custom(blur: 4, offset: const Offset(0, 2), opacity: 0.05);

  /// z4 shadow - subtle elevation, for small cards or buttons
  static List<BoxShadow> get z4 => custom(blur: 8, offset: const Offset(0, 4), opacity: 0.06);

  /// z8 shadow - standard elevation, for primary cards and menus
  static List<BoxShadow> get z8 => custom(blur: 16, offset: const Offset(0, 8), opacity: 0.08);

  /// z12 shadow - medium elevation, for popovers and dropdowns
  static List<BoxShadow> get z12 => custom(blur: 24, offset: const Offset(0, 12), opacity: 0.10);

  /// z16 shadow - deep elevation, for popups, dialogs, and bottom sheets
  static List<BoxShadow> get z16 => custom(blur: 32, offset: const Offset(0, 16), opacity: 0.12);

  /// z20 shadow - high elevation
  static List<BoxShadow> get z20 => custom(blur: 40, offset: const Offset(0, 20), opacity: 0.14);

  /// z24 shadow - maximum elevation
  static List<BoxShadow> get z24 => custom(blur: 48, offset: const Offset(0, 24), opacity: 0.16);

  // ===========================================================================
  // SEMANTIC ALIASES
  // ===========================================================================

  /// card shadow - alias of z8
  static List<BoxShadow> get card => z8;

  /// dialog shadow - alias of z16
  static List<BoxShadow> get dialog => z16;

  /// dropdown shadow - alias of z12
  static List<BoxShadow> get dropdown => z12;

  // ===========================================================================
  // BRAND COLOR GLOW SHADOWS
  // ===========================================================================

  /// Primary color shadow - orange glow for active branding widgets
  static List<BoxShadow> get primary => custom(color: TectaColors.primaryMain, opacity: 0.24);

  /// Secondary color shadow - deep blue glow for active branding widgets
  static List<BoxShadow> get secondary => custom(color: TectaColors.secondaryMain, opacity: 0.24);

  /// Success color shadow - green glow for success status widgets
  static List<BoxShadow> get success => custom(color: TectaColors.successMain, opacity: 0.24);

  /// Warning color shadow - orange/yellow glow for warning status widgets
  static List<BoxShadow> get warning => custom(color: TectaColors.warningMain, opacity: 0.24);

  /// Error color shadow - red glow for error status widgets
  static List<BoxShadow> get error => custom(color: TectaColors.errorMain, opacity: 0.24);

  /// Info color shadow - light blue glow for info status widgets
  static List<BoxShadow> get info => custom(color: TectaColors.infoMain, opacity: 0.24);
}
