import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../home_screen.dart';
import '../showcase/dialog_showcase_screen.dart';
import '../showcase/bottom_sheet_showcase_screen.dart';
import '../showcase/snackbar_showcase_screen.dart';
import '../showcase/tooltip_showcase_screen.dart';
import '../showcase/dropdown_menu_showcase_screen.dart';

ShowcaseCategory buildOverlaysCategory() {
  return ShowcaseCategory(
    title: 'OVERLAYS',
    items: [
      ShowcaseItem(
        title: 'Dialog',
        description:
            'Modal windows layered over the main content to require explicit user decisions, confirmations, or critical inputs.',
        icon: Icons.picture_in_picture_outlined,
        iconColor: TectaColors.successMain,
        builder: (context) => const DialogShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Bottom Sheet',
        description:
            'Slide-up modal panels anchored to the screen bottom, ideal for contextual menus, sub-tasks, or supplementary options.',
        icon: Icons.call_to_action_outlined,
        iconColor: TectaColors.infoMain,
        builder: (context) => const BottomSheetShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Snackbar',
        description:
            'Transient feedback banners that appear briefly at the bottom of the screen to inform users about background processes or system actions.',
        icon: Icons.sms_failed_outlined,
        iconColor: TectaColors.warningMain,
        builder: (context) => const SnackbarShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Tooltip',
        description:
            'Compact contextual popovers triggered by hover or long-press to clarify the purpose of interactive icons or truncated text.',
        icon: Icons.label_outline_rounded,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const TooltipShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Dropdown Menu',
        description:
            'Floating contextual overlays presenting a list of secondary actions or selectable values anchored to a target widget.',
        icon: Icons.arrow_drop_down_circle_outlined,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const DropdownMenuShowcasePage(),
      ),
    ],
  );
}
