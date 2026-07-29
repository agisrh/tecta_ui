import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class SnackbarShowcasePage extends StatelessWidget {
  const SnackbarShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Snackbar & Toast',
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
            title: 'Component Variants',
            note: 'TectaSnackbar is a toast notification widget. Available in five variants: minimal (default), info, success, warning, error.',
            code: '''TectaSnackbar(
  message: 'Success! Your changes were saved.',
  variant: TectaSnackbarVariant.success,
)''',
            overview: SizedBox(
              width: 500,
              child: Column(
                children: const [
                  TectaSnackbar(
                    message: 'This is a default dark minimal snackbar',
                    variant: TectaSnackbarVariant.minimal,
                  ),
                  SizedBox(height: 12),
                  TectaSnackbar(
                    message: 'This is an info status notification',
                    variant: TectaSnackbarVariant.info,
                  ),
                  SizedBox(height: 12),
                  TectaSnackbar(
                    message: 'Success! Your changes were saved.',
                    variant: TectaSnackbarVariant.success,
                  ),
                  SizedBox(height: 12),
                  TectaSnackbar(
                    message: 'Warning: Please review your billing info.',
                    variant: TectaSnackbarVariant.warning,
                  ),
                  SizedBox(height: 12),
                  TectaSnackbar(
                    message: 'Error: Connection lost. Retry again.',
                    variant: TectaSnackbarVariant.error,
                  ),
                ],
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Action Button and Close Triggers',
            note: 'Attach interactive TextButtons as actions or add onClose callbacks to trigger right-aligned close icons.',
            code: '''TectaSnackbar(
  message: 'Event has been created',
  action: TextButton(
    onPressed: () {},
    child: Text('Undo'),
  ),
)''',
            overview: SizedBox(
              width: 500,
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
                  const SizedBox(height: 12),
                  TectaSnackbar(
                    message: 'File uploaded successfully.',
                    title: 'Upload Status',
                    variant: TectaSnackbarVariant.success,
                    onClose: () {},
                  ),
                ],
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Interactive Overlay Triggers',
            note: 'Call TectaSnackbar.show(context) statically to spawn temporary toast overlays floating on top of all widgets.',
            code: '''TectaSnackbar.show(
  context,
  variant: TectaSnackbarVariant.success,
  message: 'Event created!',
)''',
            overview: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                TectaButton(
                  label: 'Trigger Minimal',
                  variant: TectaButtonVariant.soft,
                  onPressed: () {
                    TectaSnackbar.show(
                      context,
                      message: 'Event has been created',
                    );
                  },
                ),
                TectaButton(
                  label: 'Trigger Success',
                  color: TectaColors.successMain,
                  onPressed: () {
                    TectaSnackbar.show(
                      context,
                      variant: TectaSnackbarVariant.success,
                      message: 'Data successfully synchronized!',
                    );
                  },
                ),
                TectaButton(
                  label: 'Trigger Warning',
                  color: TectaColors.warningMain,
                  onPressed: () {
                    TectaSnackbar.show(
                      context,
                      variant: TectaSnackbarVariant.warning,
                      message: 'Connection strength is poor.',
                    );
                  },
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Floating Positions',
            note: 'Pass alignment options to show notifications at the top, bottom (default), or center coordinates of the screen.',
            code: '''TectaSnackbar.show(
  context,
  alignment: Alignment.topCenter,
  message: 'Top notifications',
)''',
            overview: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                TectaButton(
                  label: 'Top Center',
                  variant: TectaButtonVariant.outlined,
                  onPressed: () {
                    TectaSnackbar.show(
                      context,
                      alignment: Alignment.topCenter,
                      message: 'Displayed at Top Center',
                    );
                  },
                ),
                TectaButton(
                  label: 'Center Screen',
                  variant: TectaButtonVariant.outlined,
                  onPressed: () {
                    TectaSnackbar.show(
                      context,
                      alignment: Alignment.center,
                      message: 'Displayed at Center Screen',
                    );
                  },
                ),
                TectaButton(
                  label: 'Bottom Center',
                  variant: TectaButtonVariant.outlined,
                  onPressed: () {
                    TectaSnackbar.show(
                      context,
                      alignment: Alignment.bottomCenter,
                      message: 'Displayed at Bottom Center',
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
