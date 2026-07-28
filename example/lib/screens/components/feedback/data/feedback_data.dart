import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../home_screen.dart';
import '../showcase/alert_showcase_screen.dart';
import '../showcase/avatar_showcase_screen.dart';
import '../showcase/badge_showcase_screen.dart';
import '../showcase/skeleton_showcase_screen.dart';
import '../showcase/empty_state_showcase_screen.dart';
import '../showcase/progress_showcase_screen.dart';

ShowcaseCategory buildFeedbackCategory() {
  return ShowcaseCategory(
    title: 'FEEDBACK',
    items: [
      ShowcaseItem(
        title: 'Alert',
        description: 'Status notifications',
        icon: Icons.info_outline,
        iconColor: TectaColors.infoMain,
        builder: (context) => const AlertShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Avatar',
        description: 'User profile badges',
        icon: Icons.account_circle_outlined,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const AvatarShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Badge',
        description: 'Dynamic overlap indicators',
        icon: Icons.notifications_active_outlined,
        iconColor: TectaColors.errorMain,
        builder: (context) => const BadgeShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Skeleton',
        description: 'Shimmering placeholders',
        icon: Icons.hourglass_empty_rounded,
        iconColor: TectaColors.grey400,
        builder: (context) => const SkeletonShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Empty State',
        description: 'No content illustrative frames',
        icon: Icons.inbox_outlined,
        iconColor: TectaColors.errorMain,
        builder: (context) => const EmptyStateShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Progress',
        description: 'Dynamic color cycling loaders',
        icon: Icons.rotate_right_rounded,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const ProgressShowcasePage(),
      ),
    ],
  );
}
