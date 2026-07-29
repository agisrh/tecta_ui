import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class TooltipShowcasePage extends StatelessWidget {
  const TooltipShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Tooltip',
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
            title: 'Tooltip Positions & Triggers',
            note: 'TectaTooltip wraps target child elements to display helper texts on hover/long-press. Supports top, bottom, left, right directions.',
            code: '''TectaTooltip(
  message: 'Top validation hint',
  position: TectaTooltipPosition.top,
  child: Icon(Icons.vpn_key),
)''',
            overview: SizedBox(
              width: 500,
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Tooltip Top'),
                    subtitle: const Text('Hover/long-press key icon'),
                    trailing: TectaTooltip(
                      message: 'Secure account key validation hint',
                      position: TectaTooltipPosition.top,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: TectaColors.primaryMain.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.vpn_key_outlined, color: TectaColors.primaryMain),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Tooltip Bottom'),
                    subtitle: const Text('Hover/long-press settings icon'),
                    trailing: TectaTooltip(
                      message: 'System configure preferences panel',
                      position: TectaTooltipPosition.bottom,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: TectaColors.successMain.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.settings_outlined, color: TectaColors.successMain),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Tooltip Left'),
                    subtitle: const Text('Hover/long-press info icon'),
                    trailing: TectaTooltip(
                      message: 'Left positioned details note',
                      position: TectaTooltipPosition.left,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: TectaColors.infoMain.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.info_outline, color: TectaColors.infoMain),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Tap Toggle & Visibility Durations',
            note: 'Set triggerOnTap to true to display the tooltip on single click, and custom displayDuration to set auto-hide delays.',
            code: '''TectaTooltip(
  message: 'Click trigger active',
  triggerOnTap: true,
  displayDuration: Duration(seconds: 4),
  child: Icon(Icons.touch_app),
)''',
            overview: SizedBox(
              width: 500,
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Tap to Toggle Tooltip'),
                    subtitle: const Text('Tap icon to toggle tooltip, tap outside to close'),
                    trailing: TectaTooltip(
                      message: 'Single tap trigger mode activated!',
                      triggerOnTap: true,
                      position: TectaTooltipPosition.top,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: TectaColors.warningMain.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.touch_app_outlined, color: TectaColors.warningMain),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Tap Trigger with Custom Duration'),
                    subtitle: const Text('Auto hides after 5 seconds'),
                    trailing: TectaTooltip(
                      message: 'Stays visible for 5s or until tapped outside',
                      trigger: TectaTooltipTrigger.tap,
                      displayDuration: const Duration(seconds: 5),
                      position: TectaTooltipPosition.bottom,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: TectaColors.secondaryMain.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.timer_outlined, color: TectaColors.secondaryMain),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
