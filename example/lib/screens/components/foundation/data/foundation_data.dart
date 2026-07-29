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
        description:
            'A foundational color palette and shade system designed to maintain brand identity and visual consistency across all app interfaces.',
        icon: Icons.palette_outlined,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const ColorsShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Typography',
        description:
            'A structured typography system that defines scale, font weight, and line height. Designed to create a strong visual hierarchy, allowing users to scan and digest information quickly and comfortably across various screen sizes.',
        icon: Icons.format_size_rounded,
        iconColor: TectaColors.secondaryMain,
        builder: (context) => const TypographyShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Shadows',
        description:
            'An elevation system that defines visual depth levels across the interface. Its main purpose is to distinguish surface layers—separating components like cards, dropdowns, or modal dialogs from the background—to reinforce interaction hierarchy.',
        icon: Icons.layers_outlined,
        iconColor: TectaColors.infoMain,
        builder: (context) => const ShadowsShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Icons',
        description:
            'A standardized set of visual symbols designed to clarify meaning, speed up navigation, and provide immediate context for actions or information without relying solely on text.',
        icon: Icons.emoji_symbols_outlined,
        iconColor: TectaColors.successMain,
        builder: (context) => const IconsShowcasePage(),
      ),
    ],
  );
}
