import 'package:flutter/material.dart';

/// Configuration helper to calculate responsive columns and aspect ratios.
class ResponsiveGridConfig {
  final int crossAxisCount;
  final double childAspectRatio;

  const ResponsiveGridConfig({
    required this.crossAxisCount,
    required this.childAspectRatio,
  });

  /// Factory helper that automatically reads the media query width and determines
  /// the appropriate grid layout configurations based on standard breakpoints.
  factory ResponsiveGridConfig.calculate(
    BuildContext context, {
    required int defaultCrossAxisCount,
    required double defaultAspectRatio,
    int? tabletCrossAxisCount,
    double? tabletAspectRatio,
    int? desktopCrossAxisCount,
    double? desktopAspectRatio,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width > 900) {
      return ResponsiveGridConfig(
        crossAxisCount: desktopCrossAxisCount ?? defaultCrossAxisCount,
        childAspectRatio: desktopAspectRatio ?? defaultAspectRatio,
      );
    } else if (width > 600) {
      return ResponsiveGridConfig(
        crossAxisCount: tabletCrossAxisCount ?? defaultCrossAxisCount,
        childAspectRatio: tabletAspectRatio ?? defaultAspectRatio,
      );
    }

    return ResponsiveGridConfig(
      crossAxisCount: defaultCrossAxisCount,
      childAspectRatio: defaultAspectRatio,
    );
  }
}
