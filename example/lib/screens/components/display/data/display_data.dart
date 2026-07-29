import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../home_screen.dart';
import '../showcase/chip_showcase_screen.dart';
import '../showcase/label_showcase_screen.dart';
import '../showcase/accordion_showcase_screen.dart';
import '../showcase/card_showcase_screen.dart';
import '../showcase/divider_showcase_screen.dart';
import '../showcase/tabs_showcase_screen.dart';
import '../showcase/timeline_showcase_screen.dart';

ShowcaseCategory buildDisplayCategory() {
  return ShowcaseCategory(
    title: 'DATA DISPLAY',
    items: [
      ShowcaseItem(
        title: 'Chip',
        description:
            'Compact interactive elements used to represent inputs, attributes, filters, or actions in a clean and organized layout.',
        icon: Icons.tag_outlined,
        iconColor: TectaColors.errorMain,
        builder: (context) => const ChipShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Label',
        description:
            'Visual badges used to highlight statuses, categories, or key metadata, providing instant context at a quick glance.',
        icon: Icons.label_important_outline,
        iconColor: TectaColors.secondaryMain,
        builder: (context) => const LabelShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Accordion',
        description:
            'Collapsible content panels that allow users to expand and collapse sections, saving vertical screen real estate.',
        icon: Icons.view_day_outlined,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const AccordionShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Card',
        description:
            'Flexible container surfaces used to group related information, media, and actions into distinct visual modules.',
        icon: Icons.credit_card_outlined,
        iconColor: TectaColors.secondaryMain,
        builder: (context) => const CardShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Divider',
        description:
            'Thin visual rules used to separate content sections, establish visual grouping, and improve overall layout readability.',
        icon: Icons.horizontal_rule_rounded,
        iconColor: TectaColors.grey500,
        builder: (context) => const DividerShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Tabs',
        description:
            'Navigation controls that organize content across different views or sub-pages within the same high-level context.',
        icon: Icons.tab_unselected_rounded,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const TabsShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Timeline',
        description:
            'Chronological step indicators designed to display process workflows, order tracking, or historical event progress.',
        icon: Icons.timeline_rounded,
        iconColor: TectaColors.secondaryMain,
        builder: (context) => const TimelineShowcasePage(),
      ),
    ],
  );
}
