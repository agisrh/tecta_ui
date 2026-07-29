import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class DialogShowcasePage extends StatelessWidget {
  const DialogShowcasePage({super.key});

  void _showAlertConfirmation(BuildContext context, bool isDark) {
    showTectaDialog(
      context,
      child: TectaDialog(
        title: "Use Google's location service?",
        content: Text(
          'Let Google help apps determine location. This means sending anonymous location data to Google, even when no apps are running.',
          style: TectaTypography.body2.copyWith(color: isDark ? Colors.white60 : TectaColors.grey600),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Disagree',
              style: TextStyle(color: TectaColors.errorMain, fontWeight: FontWeight.bold),
            ),
          ),
          TectaButton(
            label: 'Agree',
            color: TectaColors.primaryMain,
            size: TectaButtonSize.small,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showFormDialog(BuildContext context, bool isDark) {
    showTectaDialog(
      context,
      child: TectaDialog(
        title: 'Subscribe',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To subscribe to this website, please enter your email address here. We will send updates occasionally.',
              style: TectaTypography.body2.copyWith(color: isDark ? Colors.white60 : TectaColors.grey600),
            ),
            const SizedBox(height: 16.0),
            const TectaTextField(
              label: 'Email Address',
              suffixIcon: Icon(Icons.mail),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TectaButton(
            label: 'Subscribe',
            color: TectaColors.primaryMain,
            size: TectaButtonSize.small,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showScrollableDialog(BuildContext context, bool isDark) {
    showTectaDialog(
      context,
      child: TectaDialog(
        title: 'Terms of Service',
        scrollable: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(15, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                '${index + 1}. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ac convallis lacus. Curabitur vel erat vel eros sollicitudin condimentum eu ac risus. Integer vestibulum, nisl sed pretium pretium, mauris lectus hendrerit metus, quis vestibulum metus dolor vitae lorem.',
                style: TectaTypography.body2.copyWith(color: isDark ? Colors.white60 : TectaColors.grey600),
              ),
            );
          }),
        ),
        actions: [
          TectaButton(
            label: 'Close',
            color: TectaColors.grey800,
            size: TectaButtonSize.small,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showFullscreenDialog(BuildContext context) {
    bool vibrate = true;

    showTectaDialog(
      context,
      child: StatefulBuilder(
        builder: (context, setState) {
          return TectaDialog(
            isFullscreen: true,
            title: 'Settings',
            onClose: () => Navigator.pop(context),
            content: ListView(
              children: [
                ListTile(
                  title: const Text('Phone Ringtone'),
                  subtitle: const Text('Flutey phone'),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Default notification sound'),
                  subtitle: const Text('Pixie dust'),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Vibrate for calls'),
                  trailing: TectaSwitch(
                    value: vibrate,
                    onChanged: (val) {
                      setState(() {
                        vibrate = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('SAVE', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Dialog',
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
            title: 'Alert Dialog',
            note: 'Standard alert confirmation layout wrapping title, description, and action button rows.',
            code: '''showTectaDialog(
  context,
  child: TectaDialog(
    title: 'Confirm deletion?',
    content: Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => {}, child: Text('Cancel')),
      TectaButton(label: 'Delete', onPressed: () => {}),
    ],
  ),
)''',
            overview: TectaButton(
              label: 'Trigger Alert Dialog',
              onPressed: () => _showAlertConfirmation(context, isDark),
            ),
          ),
          ShowcaseSection(
            title: 'Form Input Dialog',
            note: 'Pass forms, text fields, or options inside the content slot of TectaDialog.',
            code: '''TectaDialog(
  title: 'Input Form',
  content: Column(
    children: [TectaTextField(...)],
  ),
)''',
            overview: TectaButton(
              label: 'Trigger Form Dialog',
              color: TectaColors.successMain,
              onPressed: () => _showFormDialog(context, isDark),
            ),
          ),
          ShowcaseSection(
            title: 'Scrollable Long Content',
            note: 'Set scrollable parameter to true to automatically wrap dialog contents inside a scrolling viewport.',
            code: '''TectaDialog(
  scrollable: true,
  content: Column(...),
)''',
            overview: TectaButton(
              label: 'Trigger Scrollable Dialog',
              color: TectaColors.warningMain,
              onPressed: () => _showScrollableDialog(context, isDark),
            ),
          ),
          ShowcaseSection(
            title: 'Fullscreen Viewport',
            note: 'Set isFullscreen to true to stretch the dialog to occupy the full screen width and height.',
            code: '''TectaDialog(
  isFullscreen: true,
  content: ListView(...),
)''',
            overview: TectaButton(
              label: 'Trigger Fullscreen Dialog',
              color: Colors.purple,
              onPressed: () => _showFullscreenDialog(context),
            ),
          ),
        ],
      ),
    );
  }
}
