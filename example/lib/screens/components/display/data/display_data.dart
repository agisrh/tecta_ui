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
        description: 'Compact elements',
        icon: Icons.tag_outlined,
        iconColor: TectaColors.errorMain,
        builder: (context) => const ChipShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Label',
        description: 'Status colored badges',
        icon: Icons.label_important_outline,
        iconColor: TectaColors.secondaryMain,
        builder: (context) => const LabelShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Accordion',
        description: 'Collapsible text lists',
        icon: Icons.view_day_outlined,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const AccordionShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Card',
        description: 'Compartment layout boxes',
        icon: Icons.credit_card_outlined,
        iconColor: TectaColors.secondaryMain,
        builder: (context) => const CardShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Divider',
        description: 'Sleek custom separating lines',
        icon: Icons.horizontal_rule_rounded,
        iconColor: TectaColors.grey500,
        builder: (context) => const DividerShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Tabs',
        description: 'Interactive page switches',
        icon: Icons.tab_unselected_rounded,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const TabsShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Timeline',
        description: 'Process step guides',
        icon: Icons.timeline_rounded,
        iconColor: TectaColors.secondaryMain,
        builder: (context) => const TimelineShowcasePage(),
      ),
    ],
  );
}
