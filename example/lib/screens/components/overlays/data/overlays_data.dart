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
        description: 'Overlay popups',
        icon: Icons.picture_in_picture_outlined,
        iconColor: TectaColors.successMain,
        builder: (context) => const DialogShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Bottom Sheet',
        description: 'Slide up modal drawers',
        icon: Icons.call_to_action_outlined,
        iconColor: TectaColors.infoMain,
        builder: (context) => const BottomSheetShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Snackbar',
        description: 'Toast feedback messages',
        icon: Icons.sms_failed_outlined,
        iconColor: TectaColors.warningMain,
        builder: (context) => const SnackbarShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Tooltip',
        description: 'Hover bubble note tags',
        icon: Icons.label_outline_rounded,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const TooltipShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Dropdown Menu',
        description: 'Premium action list popovers',
        icon: Icons.arrow_drop_down_circle_outlined,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const DropdownMenuShowcasePage(),
      ),
    ],
  );
}
