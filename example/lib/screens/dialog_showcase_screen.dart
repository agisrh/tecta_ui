import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class DialogShowcasePage extends StatelessWidget {
  const DialogShowcasePage({super.key});

  void _showAlertConfirmation(BuildContext context) {
    showTectaDialog(
      context,
      child: TectaDialog(
        title: "Use Google's location service?",
        content: Text(
          'Let Google help apps determine location. This means sending anonymous location data to Google, even when no apps are running.',
          style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Disagree',
              style: TextStyle(color: TectaColors.errorMain, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: TectaColors.primaryMain,
              foregroundColor: TectaColors.white,
              elevation: 0,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Agree'),
          ),
        ],
      ),
    );
  }

  void _showFormDialog(BuildContext context) {
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
              style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: TectaColors.grey800,
              foregroundColor: TectaColors.white,
              elevation: 0,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Subscribe'),
          ),
        ],
      ),
    );
  }

  void _showScrollableDialog(BuildContext context) {
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
                style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
              ),
            );
          }),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: TectaColors.grey800,
              foregroundColor: TectaColors.white,
              elevation: 0,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
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
                const Divider(height: 1, color: TectaColors.grey200),
                ListTile(
                  title: const Text('Default notification sound'),
                  subtitle: const Text('Pixie dust'),
                  onTap: () {},
                ),
                const Divider(height: 1, color: TectaColors.grey200),
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
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Dialog',
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
          _buildSectionHeader('Interactive Examples'),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              children: [
                // Alert Confirmation
                ListTile(
                  title: const Text('Alert Dialog'),
                  subtitle: const Text('Google location confirmation pop-up'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => _showAlertConfirmation(context),
                ),
                const Divider(height: 1, color: TectaColors.grey200),

                // Form Input Dialog
                ListTile(
                  title: const Text('Form Dialog'),
                  subtitle: const Text('Email subscriber form modal'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => _showFormDialog(context),
                ),
                const Divider(height: 1, color: TectaColors.grey200),

                // Scrollable Content Dialog
                ListTile(
                  title: const Text('Scrollable Dialog'),
                  subtitle: const Text('Long paragraph text scrolling viewport'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => _showScrollableDialog(context),
                ),
                const Divider(height: 1, color: TectaColors.grey200),

                // Fullscreen Dialog
                ListTile(
                  title: const Text('Fullscreen Dialog'),
                  subtitle: const Text('Mobile-friendly full-viewport settings'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => _showFullscreenDialog(context),
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
