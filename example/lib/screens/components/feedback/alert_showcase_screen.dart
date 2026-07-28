import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class AlertShowcasePage extends StatefulWidget {
  const AlertShowcasePage({super.key});

  @override
  State<AlertShowcasePage> createState() => _AlertShowcasePageState();
}

class _AlertShowcasePageState extends State<AlertShowcasePage> {
  bool _showSuccessAlert = true;
  bool _showInfoAlert = true;
  bool _showWarningAlert = true;
  bool _showErrorAlert = true;

  void _resetDismissedAlerts() {
    setState(() {
      _showSuccessAlert = true;
      _showInfoAlert = true;
      _showWarningAlert = true;
      _showErrorAlert = true;
    });
  }

  bool get _anyAlertDismissed =>
      !_showSuccessAlert || !_showInfoAlert || !_showWarningAlert || !_showErrorAlert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Alert',
          style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
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
            color: TectaColors.grey300.withValues(alpha: 0.5),
            height: 1.0,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          // ===========================================================================
          // SOFT ALERTS (STANDARD)
          // ===========================================================================
          _buildSectionHeader('SOFT ALERTS (STANDARD)'),
          const SizedBox(height: 16),
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

          const SizedBox(height: 32),

          // ===========================================================================
          // OUTLINED ALERTS
          // ===========================================================================
          _buildSectionHeader('OUTLINED ALERTS'),
          const SizedBox(height: 16),
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

          const SizedBox(height: 32),

          // ===========================================================================
          // PREMIUM GRID BANNERS
          // ===========================================================================
          _buildSectionHeader('PREMIUM GRID BANNERS'),
          const SizedBox(height: 16),
          const TectaAlert(
            severity: TectaAlertSeverity.info,
            variant: TectaAlertVariant.banner,
            title: 'Sistem Maintenance',
            message: 'Maintenance sistem absensi rutin terjadwal akan dilaksanakan pada tanggal 28 Juli 2026 pukul 23:00 WIB.',
          ),
          const SizedBox(height: 12),
          const TectaAlert(
            severity: TectaAlertSeverity.success,
            variant: TectaAlertVariant.banner,
            message: 'Data absensi Anda hari ini berhasil disinkronisasikan ke server pusat.',
          ),
          const SizedBox(height: 12),
          TectaAlert(
            severity: TectaAlertSeverity.warning,
            variant: TectaAlertVariant.banner,
            message: 'Sesi login Anda akan berakhir dalam 5 menit. Harap simpan pekerjaan Anda.',
            onClose: () {},
          ),
          const SizedBox(height: 12),
          TectaAlert(
            severity: TectaAlertSeverity.error,
            variant: TectaAlertVariant.banner,
            title: 'Koneksi Terputus',
            message: 'Tidak dapat terhubung ke jaringan internet. Mode offline diaktifkan.',
            action: TectaButton(
              label: 'Reload',
              size: TectaButtonSize.small,
              onPressed: () {},
            ),
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // FILLED ALERTS
          // ===========================================================================
          _buildSectionHeader('FILLED ALERTS'),
          const SizedBox(height: 16),
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

          const SizedBox(height: 32),

          // ===========================================================================
          // ALERTS WITH TITLE (RICH LAYOUT)
          // ===========================================================================
          _buildSectionHeader('ALERTS WITH TITLE (RICH LAYOUT)'),
          const SizedBox(height: 16),
          const TectaAlert(
            severity: TectaAlertSeverity.info,
            title: 'Information',
            message: 'This alert contains a title and detailed body message. Use this layout to offer a structured notification.',
          ),
          const SizedBox(height: 12),
          const TectaAlert(
            severity: TectaAlertSeverity.success,
            variant: TectaAlertVariant.outlined,
            title: 'Transaction Success',
            message: 'Your payment was successfully processed. You can now download your digital invoice.',
          ),
          const SizedBox(height: 12),
          const TectaAlert(
            severity: TectaAlertSeverity.error,
            variant: TectaAlertVariant.filled,
            title: 'Critical System Error',
            message: 'Failed to synchronize local databases with the remote servers. Please retry in a few moments.',
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // INTERACTIVE & ACTION ALERTS
          // ===========================================================================
          _buildSectionHeader('INTERACTIVE & ACTION ALERTS'),
          const SizedBox(height: 16),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Text(
                  'Undo',
                  style: TectaTypography.caption.copyWith(
                    color: TectaColors.warningDarker,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TectaAlert(
            severity: TectaAlertSeverity.info,
            variant: TectaAlertVariant.filled,
            message: 'Filled info with close button.',
            onClose: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Closed filled info alert')),
              );
            },
          ),

          const SizedBox(height: 32),

          // ===========================================================================
          // DYNAMIC STYLING CUSTOMIZATIONS
          // ===========================================================================
          _buildSectionHeader('DYNAMIC STYLING OVERRIDES'),
          const SizedBox(height: 16),
          TectaAlert(
            severity: TectaAlertSeverity.info,
            backgroundColor: TectaColors.secondaryMain,
            borderRadius: BorderRadius.circular(16.0),
            leading: const Icon(
              SolarLinearIcons.delivery,
              color: TectaColors.primaryMain,
              size: 24,
            ),
            title: 'Logistik Info',
            titleStyle: TectaTypography.subtitle2.copyWith(color: TectaColors.white, fontWeight: FontWeight.w700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Layanan logistik terintegrasi untuk pengiriman barang cepat, aman, dan efisien.',
                  style: TectaTypography.body2.copyWith(color: TectaColors.grey300),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Lacak paket diklik!')),
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: TectaColors.primaryMain,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Lacak',
                        style: TectaTypography.caption.copyWith(
                          color: TectaColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TectaAlert(
            severity: TectaAlertSeverity.warning,
            backgroundColor: TectaColors.primaryLighter.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: TectaColors.primaryLight.withValues(alpha: 0.4), width: 1.0),
            leading: const Icon(
              SolarLinearIcons.gift,
              color: TectaColors.primaryMain,
              size: 24,
            ),
            title: 'Promo Akhir Pekan!',
            message: 'Dapatkan potongan ongkir hingga 15% untuk kiriman paket Express di atas 50kg.',
            titleStyle: TectaTypography.subtitle2.copyWith(color: TectaColors.primaryDarker, fontWeight: FontWeight.w700),
            messageStyle: TectaTypography.body2.copyWith(color: TectaColors.primaryDark),
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
}
