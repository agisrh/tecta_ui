import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class AlertShowcasePage extends StatefulWidget {
  const AlertShowcasePage({super.key});

  @override
  State<AlertShowcasePage> createState() => _AlertShowcasePageState();
}

class _AlertShowcasePageState extends State<AlertShowcasePage> {
  bool _showSuccessAlert = true;
  bool _showInfoAlert = true;

  void _resetDismissedAlerts() {
    setState(() {
      _showSuccessAlert = true;
      _showInfoAlert = true;
    });
  }

  bool get _anyAlertDismissed => !_showSuccessAlert || !_showInfoAlert;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Alert',
                style: TectaTypography.h4.copyWith(
                  color: isDark ? Colors.white : TectaColors.grey800,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                if (_anyAlertDismissed)
                  TextButton(
                    onPressed: _resetDismissedAlerts,
                    child: const Text('Reset'),
                  ),
              ],
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
            title: 'Soft Alerts (Standard)',
            note: 'TectaAlert is inline feedback with 4 severities: info, success, warning, error. Soft variant features a light tinted background.',
            code: '''TectaAlert(
  severity: TectaAlertSeverity.info,
  message: 'This is an info alert.',
)''',
            overview: Column(
              children: [
                const TectaAlert(
                  severity: TectaAlertSeverity.info,
                  message: 'This is an info alert — check it out!',
                ),
                const SizedBox(height: 12),
                const TectaAlert(
                  severity: TectaAlertSeverity.success,
                  message: 'This is a success alert — check it out!',
                ),
                const SizedBox(height: 12),
                const TectaAlert(
                  severity: TectaAlertSeverity.warning,
                  message: 'This is a warning alert — check it out!',
                ),
                const SizedBox(height: 12),
                const TectaAlert(
                  severity: TectaAlertSeverity.error,
                  message: 'This is an error alert — check it out!',
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Outlined Alerts',
            note: 'Uses outline border design instead of solid colored backgrounds, ideal for low-contrast page positions.',
            code: '''TectaAlert(
  severity: TectaAlertSeverity.info,
  variant: TectaAlertVariant.outlined,
  message: 'This is an outlined alert.',
)''',
            overview: Column(
              children: [
                const TectaAlert(
                  severity: TectaAlertSeverity.info,
                  variant: TectaAlertVariant.outlined,
                  message: 'This is an outlined info alert.',
                ),
                const SizedBox(height: 12),
                const TectaAlert(
                  severity: TectaAlertSeverity.success,
                  variant: TectaAlertVariant.outlined,
                  message: 'This is an outlined success alert.',
                ),
                const SizedBox(height: 12),
                const TectaAlert(
                  severity: TectaAlertSeverity.warning,
                  variant: TectaAlertVariant.outlined,
                  message: 'This is an outlined warning alert.',
                ),
                const SizedBox(height: 12),
                const TectaAlert(
                  severity: TectaAlertSeverity.error,
                  variant: TectaAlertVariant.outlined,
                  message: 'This is an outlined error alert.',
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Filled Banners & Alerts',
            note: 'Featuring high-contrast solid backgrounds, best suited for immediate critical attention.',
            code: '''TectaAlert(
  severity: TectaAlertSeverity.info,
  variant: TectaAlertVariant.filled,
  message: 'Filled info alert',
)''',
            overview: Column(
              children: [
                const TectaAlert(
                  severity: TectaAlertSeverity.info,
                  variant: TectaAlertVariant.filled,
                  message: 'This is a filled info alert.',
                ),
                const SizedBox(height: 12),
                const TectaAlert(
                  severity: TectaAlertSeverity.success,
                  variant: TectaAlertVariant.filled,
                  message: 'This is a filled success alert.',
                ),
                const SizedBox(height: 12),
                const TectaAlert(
                  severity: TectaAlertSeverity.warning,
                  variant: TectaAlertVariant.filled,
                  message: 'This is a filled warning alert.',
                ),
                const SizedBox(height: 12),
                const TectaAlert(
                  severity: TectaAlertSeverity.error,
                  variant: TectaAlertVariant.filled,
                  message: 'This is a filled error alert.',
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Alerts with Action or Close Buttons',
            note: 'Pass a callback to onClose to trigger close icon, or add custom action buttons to resolve alerts.',
            code: '''TectaAlert(
  severity: TectaAlertSeverity.success,
  message: 'Dismissible alert',
  onClose: () => dismissAlert(),
)''',
            overview: Column(
              children: [
                if (_showSuccessAlert)
                  TectaAlert(
                    severity: TectaAlertSeverity.success,
                    message: 'Click the close icon to dismiss this success alert.',
                    onClose: () => setState(() => _showSuccessAlert = false),
                  ),
                if (_showSuccessAlert) const SizedBox(height: 12),
                if (_showInfoAlert)
                  TectaAlert(
                    severity: TectaAlertSeverity.info,
                    variant: TectaAlertVariant.outlined,
                    title: 'Dismissible Outlined Alert',
                    message: 'This is an outlined alert with close action.',
                    onClose: () => setState(() => _showInfoAlert = false),
                  ),
                if (_showInfoAlert) const SizedBox(height: 12),
                TectaAlert(
                  severity: TectaAlertSeverity.warning,
                  message: 'This alert contains an action button.',
                  action: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Action button tapped!')),
                      );
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text(
                        'Undo',
                        style: TectaTypography.caption.copyWith(
                          color: TectaColors.warningDarker,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
}
