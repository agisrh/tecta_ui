import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class TimelineShowcasePage extends StatelessWidget {
  const TimelineShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Timeline',
          style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: TectaColors.grey100,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          // ---------------------------------------------------------
          // STANDARD TIMELINE
          // ---------------------------------------------------------
          _buildSectionHeader('Delivery Tracking (Solid Line, Outlined Indicator)'),
          const SizedBox(height: 12),
          _buildCard(
            child: const TectaTimeline(
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
          const SizedBox(height: 24),

          // ---------------------------------------------------------
          // DASHED TIMELINE
          // ---------------------------------------------------------
          _buildSectionHeader('Project Progress (Dashed Line, Soft Indicator)'),
          const SizedBox(height: 12),
          _buildCard(
            child: const TectaTimeline(
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        title,
        style: TectaTypography.overline.copyWith(
          color: TectaColors.grey500,
          fontSize: 12,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Material(
      color: TectaColors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: TectaColors.grey200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: child,
      ),
    );
  }
}
