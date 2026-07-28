import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class BottomSheetShowcasePage extends StatelessWidget {
  const BottomSheetShowcasePage({super.key});

  void _showStandardSheet(BuildContext context) {
    showTectaBottomSheet(
      context,
      child: TectaBottomSheet(
        title: 'Permission Request',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Allow this app to access your contacts? This helps in finding friends easily.',
              style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Deny'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TectaColors.primaryMain,
                    foregroundColor: TectaColors.white,
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Allow'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showListMenuSheet(BuildContext context) {
    showTectaBottomSheet(
      context,
      child: TectaBottomSheet(
        title: 'Choose Action',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('Share Link'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(height: 1, color: TectaColors.grey200),
            ListTile(
              leading: const Icon(Icons.copy_outlined),
              title: const Text('Copy Link'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(height: 1, color: TectaColors.grey200),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit Details'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(height: 1, color: TectaColors.grey200),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: TectaColors.errorMain),
              title: Text('Delete File', style: TextStyle(color: TectaColors.errorMain)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showScrollableSheet(BuildContext context) {
    showTectaBottomSheet(
      context,
      child: TectaBottomSheet(
        title: 'Available Options',
        content: SizedBox(
          height: 300,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: 15,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: TectaColors.grey200),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: TectaColors.grey200,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: TectaColors.grey800),
                  ),
                ),
                title: Text('Option Title ${index + 1}'),
                subtitle: Text('Details for option item ${index + 1}'),
                onTap: () => Navigator.pop(context),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showActionsHeaderSheet(BuildContext context) {
    showTectaBottomSheet(
      context,
      child: TectaBottomSheet(
        title: 'Edit Profile',
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TectaTextField(
              label: 'Display Name',
              suffixIcon: Icon(Icons.person),
            ),
            SizedBox(height: 16.0),
            TectaTextField(
              label: 'Bio Description',
              suffixIcon: Icon(Icons.edit_note),
            ),
          ],
        ),
      ),
    );
  }

  void _showDraggableSheet(BuildContext context) {
    showTectaBottomSheet(
      context,
      isScrollControlled: true,
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return TectaBottomSheet(
            title: 'Draggable Sheet',
            content: ListView.separated(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: 25,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: TectaColors.grey200),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.drag_indicator, color: TectaColors.grey400),
                  title: Text('Scrollable Item ${index + 1}'),
                  subtitle: const Text('Drag me up to expand this sheet!'),
                  onTap: () => Navigator.pop(context),
                );
              },
            ),
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
          'Bottom Sheet',
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
                // Standard Modal
                ListTile(
                  title: const Text('Standard Bottom Sheet'),
                  subtitle: const Text('Simple informational bottom dialog'),
                  trailing: const Icon(Icons.keyboard_arrow_up),
                  onTap: () => _showStandardSheet(context),
                ),
                const Divider(height: 1, color: TectaColors.grey200),

                // Menu Options
                ListTile(
                  title: const Text('List Menu Bottom Sheet'),
                  subtitle: const Text('Contextual operations panel'),
                  trailing: const Icon(Icons.keyboard_arrow_up),
                  onTap: () => _showListMenuSheet(context),
                ),
                const Divider(height: 1, color: TectaColors.grey200),

                // Scrollable content
                ListTile(
                  title: const Text('Scrollable Bottom Sheet'),
                  subtitle: const Text('Long list inside a bottom viewport'),
                  trailing: const Icon(Icons.keyboard_arrow_up),
                  onTap: () => _showScrollableSheet(context),
                ),
                const Divider(height: 1, color: TectaColors.grey200),

                // Actions Header
                ListTile(
                  title: const Text('Actions Header Bottom Sheet'),
                  subtitle: const Text('Sheet containing done/close header buttons'),
                  trailing: const Icon(Icons.keyboard_arrow_up),
                  onTap: () => _showActionsHeaderSheet(context),
                ),
                const Divider(height: 1, color: TectaColors.grey200),

                // Draggable Expandable sheet
                ListTile(
                  title: const Text('Draggable Bottom Sheet'),
                  subtitle: const Text('Drag upwards to expand size dynamically'),
                  trailing: const Icon(Icons.keyboard_arrow_up),
                  onTap: () => _showDraggableSheet(context),
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
