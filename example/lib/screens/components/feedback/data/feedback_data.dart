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
        description:
            'Prominent contextual messages used to inform users about important status updates, warnings, or system outcomes.',
        icon: Icons.info_outline,
        iconColor: TectaColors.infoMain,
        builder: (context) => const AlertShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Avatar',
        description:
            'Visual representations of users or entities, supporting images, initials, or fallback icons in various sizes.',
        icon: Icons.account_circle_outlined,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const AvatarShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Badge',
        description:
            'Small indicator overlays attached to elements to display unread counts, status dots, or live notifications.',
        icon: Icons.notifications_active_outlined,
        iconColor: TectaColors.errorMain,
        builder: (context) => const BadgeShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Skeleton',
        description:
            'Shimmering placeholder shapes that mimic layout structure during asynchronous content loading to reduce perceived latency.',
        icon: Icons.hourglass_empty_rounded,
        iconColor: TectaColors.grey400,
        builder: (context) => const SkeletonShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Empty State',
        description:
            'Informative screens or components displayed when no data is available, guiding users on next actions or clear states.',
        icon: Icons.inbox_outlined,
        iconColor: TectaColors.errorMain,
        builder: (context) => const EmptyStateShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Progress',
        description:
            'Linear and circular indicators used to communicate ongoing background tasks, loading states, or completion percentages.',
        icon: Icons.rotate_right_rounded,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const ProgressShowcasePage(),
      ),
    ],
  );
}
