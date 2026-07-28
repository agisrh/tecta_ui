import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class TooltipShowcasePage extends StatelessWidget {
  const TooltipShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Tooltip',
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
          _buildSectionHeader('Interactive Tooltip Directions'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              children: [
                // Top Tooltip
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
                const Divider(height: 1, color: TectaColors.grey200),

                // Bottom Tooltip
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
                const Divider(height: 1, color: TectaColors.grey200),

                // Left Tooltip
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
                const Divider(height: 1, color: TectaColors.grey200),

                // Right Tooltip
                ListTile(
                  title: const Text('Tooltip Right'),
                  subtitle: const Text('Hover/long-press delete icon'),
                  trailing: TectaTooltip(
                    message: 'Delete current record item permanently',
                    position: TectaTooltipPosition.right,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: TectaColors.errorMain.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.delete_outline, color: TectaColors.errorMain),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Tap Trigger Section
          _buildSectionHeader('Tap Trigger Tooltips (On Tap)'),
          const SizedBox(height: 12),
          _buildCard(
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
                const Divider(height: 1, color: TectaColors.grey200),
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
      child: child,
    );
  }
}
