import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class SnackbarShowcasePage extends StatelessWidget {
  const SnackbarShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Snackbar & Toast',
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
          // SECTION 1: INLINE COMPONENT SAMPLES
          // ---------------------------------------------------------
          _buildSectionHeader('Component Variants'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              children: [
                const TectaSnackbar(
                  message: 'This is a default dark minimal snackbar',
                  variant: TectaSnackbarVariant.minimal,
                ),
                const SizedBox(height: 16),
                const TectaSnackbar(
                  message: 'This is an info status notification',
                  variant: TectaSnackbarVariant.info,
                ),
                const SizedBox(height: 16),
                const TectaSnackbar(
                  message: 'Success! Your changes were saved.',
                  variant: TectaSnackbarVariant.success,
                ),
                const SizedBox(height: 16),
                const TectaSnackbar(
                  message: 'Warning: Please review your billing info.',
                  variant: TectaSnackbarVariant.warning,
                ),
                const SizedBox(height: 16),
                const TectaSnackbar(
                  message: 'Error: Connection lost. Retry again.',
                  variant: TectaSnackbarVariant.error,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ---------------------------------------------------------
          // SECTION 2: SNACKBAR WITH ACTION & DISMISS
          // ---------------------------------------------------------
          _buildSectionHeader('Adornments & Details'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              children: [
                TectaSnackbar(
                  message: 'Event has been created',
                  variant: TectaSnackbarVariant.minimal,
                  action: TextButton(
                    onPressed: () {},
                    child: const Text('Undo', style: TextStyle(color: TectaColors.primaryLight, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 16),
                TectaSnackbar(
                  message: 'Success! File uploaded successfully.',
                  title: 'Title',
                  variant: TectaSnackbarVariant.success,
                  onClose: () {},
                ),
                const SizedBox(height: 16),
                TectaSnackbar(
                  message: 'Event has been created',
                  subText: 'Monday, January 3rd at 6:00pm',
                  variant: TectaSnackbarVariant.minimal,
                  onClose: () {},
                ),
                const SizedBox(height: 16),
                TectaSnackbar(
                  title: 'Title',
                  message: 'Description',
                  variant: TectaSnackbarVariant.warning,
                  action: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Action', style: TextStyle(color: TectaColors.warningDark, fontWeight: FontWeight.bold)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Dismiss', style: TextStyle(color: TectaColors.grey800, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TectaSnackbar(
                  title: 'New Notification',
                  message: 'Event start time cannot be earlier than 8am',
                  variant: TectaSnackbarVariant.warning,
                  action: TextButton(
                    onPressed: () {},
                    child: const Text('Action', style: TextStyle(color: TectaColors.warningDarker, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ---------------------------------------------------------
          // SECTION 3: INTERACTIVE GLOBAL TRIGGER DEMOS
          // ---------------------------------------------------------
          _buildSectionHeader('Interactive Overlay Triggers'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TectaButton(
                    label: 'Trigger Dark Minimal',
                    variant: TectaButtonVariant.soft,
                    color: TectaColors.secondaryMain,
                    onPressed: () {
                      TectaSnackbar.show(
                        context,
                        message: 'Event has been created',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TectaButton(
                    label: 'Trigger Success Toast',
                    variant: TectaButtonVariant.contained,
                    color: TectaColors.successMain,
                    onPressed: () {
                      TectaSnackbar.show(
                        context,
                        variant: TectaSnackbarVariant.success,
                        message: 'Event has been created',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TectaButton(
                    label: 'Trigger Warning Toast',
                    variant: TectaButtonVariant.contained,
                    color: TectaColors.warningMain,
                    onPressed: () {
                      TectaSnackbar.show(
                        context,
                        variant: TectaSnackbarVariant.warning,
                        message: 'Event start time cannot be earlier than 8am',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TectaButton(
                    label: 'Trigger Info with Subtext',
                    variant: TectaButtonVariant.contained,
                    color: TectaColors.infoMain,
                    onPressed: () {
                      TectaSnackbar.show(
                        context,
                        variant: TectaSnackbarVariant.info,
                        title: 'Syncing Data',
                        message: 'Be at the area 10 minutes before the event time',
                        subText: 'Running synchronizations...',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TectaButton(
                    label: 'Trigger Action Notification',
                    variant: TectaButtonVariant.contained,
                    color: TectaColors.errorMain,
                    onPressed: () {
                      TectaSnackbar.show(
                        context,
                        variant: TectaSnackbarVariant.error,
                        message: 'Unable to reach backend servers.',
                        action: TextButton(
                          onPressed: () {},
                          child: const Text('Retry', style: TextStyle(color: TectaColors.errorDarker, fontWeight: FontWeight.bold)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ---------------------------------------------------------
          // SECTION 4: POSITIONING DEMOS (TOP, CENTER, BOTTOM)
          // ---------------------------------------------------------
          _buildSectionHeader('Positions (Top, Center, Bottom)'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TectaButton(
                    label: 'Trigger Top Center',
                    variant: TectaButtonVariant.outlined,
                    color: TectaColors.secondaryMain,
                    onPressed: () {
                      TectaSnackbar.show(
                        context,
                        alignment: Alignment.topCenter,
                        message: 'Displayed at Top Center',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TectaButton(
                    label: 'Trigger Center',
                    variant: TectaButtonVariant.outlined,
                    color: TectaColors.secondaryMain,
                    onPressed: () {
                      TectaSnackbar.show(
                        context,
                        alignment: Alignment.center,
                        message: 'Displayed exactly at the Center',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TectaButton(
                    label: 'Trigger Bottom Center',
                    variant: TectaButtonVariant.outlined,
                    color: TectaColors.secondaryMain,
                    onPressed: () {
                      TectaSnackbar.show(
                        context,
                        alignment: Alignment.bottomCenter,
                        message: 'Displayed at Bottom Center',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ---------------------------------------------------------
          // SECTION 5: CUSTOM STYLE OVERRIDES (DYNAMICS)
          // ---------------------------------------------------------
          _buildSectionHeader('Dynamic Custom Styling'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TectaButton(
                    label: 'Trigger Custom styled Snackbar',
                    variant: TectaButtonVariant.contained,
                    color: TectaColors.primaryMain,
                    onPressed: () {
                      TectaSnackbar.show(
                        context,
                        title: 'Dynamic Override',
                        message: 'Custom gradient, soft shadows, and clean typography!',
                        leadingIcon: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 20),
                        ),
                        decorationOverride: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF7F00FF), // Violet neon
                              Color(0xFFE100FF), // Pink neon
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7F00FF).withValues(alpha: 0.35),
                              blurRadius: 16.0,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        textColorOverride: Colors.white,
                        titleStyle: TectaTypography.h6.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        messageStyle: TectaTypography.body2.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      );
                    },
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: TectaColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: child,
    );
  }
}
