import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class TimelineShowcasePage extends StatelessWidget {
  const TimelineShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Timeline',
                style: TectaTypography.h4.copyWith(
                  color: isDark ? Colors.white : TectaColors.grey800,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: theme.dividerColor,
                  height: 1.0,
                ),
              ),
            ),
      body: ShowcasePageLayout(
        sections: [
          ShowcaseSection(
            title: 'Delivery Tracking (Solid Line, Outlined Indicator)',
            note: 'TectaTimelineItem supports title, subtitle, time metadata, along with outlined circle node indicators.',
            code: '''TectaTimeline(
  children: [
    TectaTimelineItem(
      title: 'Order Placed',
      subtitle: 'Your order has been received.',
      time: '09:30 AM',
      indicatorType: TectaTimelineIndicatorType.outlined,
      indicatorColor: TectaColors.primaryMain,
    ),
  ],
)''',
            overview: const TectaTimeline(
              children: [
                TectaTimelineItem(
                  title: 'Order Placed',
                  subtitle: 'Your order has been received and confirmed',
                  time: '09:30 AM',
                  indicatorType: TectaTimelineIndicatorType.outlined,
                  indicatorColor: TectaColors.primaryMain,
                ),
                TectaTimelineItem(
                  title: 'Processing',
                  subtitle: 'Item picked and packed at sorting facility',
                  time: '11:15 AM',
                  indicatorType: TectaTimelineIndicatorType.outlined,
                  indicatorColor: TectaColors.infoMain,
                ),
                TectaTimelineItem(
                  title: 'Out for Delivery',
                  subtitle: 'Courier is delivering your package now',
                  time: '02:00 PM',
                  indicatorType: TectaTimelineIndicatorType.outlined,
                  indicatorColor: TectaColors.warningMain,
                ),
                TectaTimelineItem(
                  title: 'Delivered',
                  subtitle: 'Successfully handed over to receptionist',
                  time: '03:45 PM',
                  indicatorType: TectaTimelineIndicatorType.outlined,
                  indicatorColor: TectaColors.successMain,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Project Progress (Dashed Line, Soft Indicator)',
            note: 'Set lineType to TectaTimelineLineType.dashed and indicatorType to TectaTimelineIndicatorType.soft to render soft status backdrops.',
            code: '''TectaTimelineItem(
  title: 'Planning',
  indicatorType: TectaTimelineIndicatorType.soft,
  lineType: TectaTimelineLineType.dashed,
)''',
            overview: const TectaTimeline(
              children: [
                TectaTimelineItem(
                  title: 'Requirement Analysis',
                  subtitle: 'Sprint planning and backlog grooming',
                  time: 'Mon',
                  indicatorType: TectaTimelineIndicatorType.soft,
                  lineType: TectaTimelineLineType.dashed,
                  indicatorColor: TectaColors.primaryMain,
                ),
                TectaTimelineItem(
                  title: 'UI Design Refinement',
                  subtitle: 'Figma mockups approved by steering committee',
                  time: 'Tue',
                  indicatorType: TectaTimelineIndicatorType.soft,
                  lineType: TectaTimelineLineType.dashed,
                  indicatorColor: TectaColors.infoMain,
                ),
                TectaTimelineItem(
                  title: 'Component Development',
                  subtitle: 'Coding custom widget components in Flutter',
                  time: 'Wed',
                  indicatorType: TectaTimelineIndicatorType.soft,
                  lineType: TectaTimelineLineType.dashed,
                  indicatorColor: TectaColors.warningMain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
