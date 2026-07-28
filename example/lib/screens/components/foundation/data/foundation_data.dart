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
        icon: Icons.palette_outlined,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const ColorsShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Typography',
        description: 'Dynamic text size scales',
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
        icon: Icons.emoji_symbols_outlined,
        iconColor: TectaColors.successMain,
        builder: (context) => const IconsShowcasePage(),
      ),
    ],
  );
}
