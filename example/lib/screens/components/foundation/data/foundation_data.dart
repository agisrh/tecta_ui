import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../home_screen.dart';
import '../showcase/colors_showcase_screen.dart';
import '../showcase/typography_showcase_screen.dart';
import '../showcase/shadows_showcase_screen.dart';
import '../showcase/icons_showcase_screen.dart';

ShowcaseCategory buildFoundationCategory() {
  return ShowcaseCategory(
    title: 'FOUNDATION',
    items: [
      ShowcaseItem(
        title: 'Colors',
        description: 'Brand palette & shades',
        longDescription:
            'Tecta UI uses a semantic color system based on Material 3 tokens. Each color role (primary, secondary, info, success, warning, error) comes with main, light, and dark variants for consistent use across light and dark themes. All palette values are accessible from TectaColors and can be referenced directly in your widget tree or passed to TectaTheme for global application.',
        icon: Icons.palette_outlined,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const ColorsShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Typography',
        description: 'Dynamic text size scales',
        longDescription:
            'Tecta typography follows a fluid type scale from display headings (h1–h4) down to captions and overlines. All styles are pre-configured in TectaTypography and bind automatically to the active ThemeData. You can override any style using .copyWith() or extend the scale by defining custom TextStyle tokens.',
        icon: Icons.format_size_rounded,
        iconColor: TectaColors.secondaryMain,
        builder: (context) => const TypographyShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Shadows',
        description: 'Soft elevation styles',
        icon: Icons.layers_outlined,
        iconColor: TectaColors.infoMain,
        builder: (context) => const ShadowsShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Icons',
        description: 'Solar SVG icon assets',
        longDescription:
            'Tecta UI ships with the Solar icon set — a clean, two-weight SVG library designed for enterprise interfaces. Icons are accessed via SolarLinearIcons (line style) or SolarBoldIcons (filled style). They are scalable, theme-aware, and follow consistent padding and visual weight guidelines across all component sizes.',
        icon: Icons.emoji_symbols_outlined,
        iconColor: TectaColors.successMain,
        builder: (context) => const IconsShowcasePage(),
      ),
    ],
  );
}
