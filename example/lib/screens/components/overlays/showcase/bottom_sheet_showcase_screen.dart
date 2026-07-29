import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class BottomSheetShowcasePage extends StatelessWidget {
  const BottomSheetShowcasePage({super.key});

  void _showStandardSheet(BuildContext context, bool isDark) {
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
              style: TectaTypography.body2.copyWith(color: isDark ? Colors.white60 : TectaColors.grey600),
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
                TectaButton(
                  label: 'Allow',
                  color: TectaColors.primaryMain,
                  size: TectaButtonSize.small,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showListMenuSheet(BuildContext context, bool isDark) {
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
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.copy_outlined),
              title: const Text('Copy Link'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded, color: TectaColors.errorMain),
              title: const Text('Delete File', style: TextStyle(color: TectaColors.errorMain)),
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
          height: 240,
          child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: TectaColors.grey200,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: TectaColors.grey800, fontSize: 13),
                  ),
                ),
                title: Text('Option Title ${index + 1}'),
                onTap: () => Navigator.pop(context),
              );
            },
          ),
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
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return TectaBottomSheet(
            title: 'Draggable Sheet',
            content: ListView.separated(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: 20,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.drag_indicator_rounded, color: TectaColors.grey400),
                  title: Text('Scrollable Item ${index + 1}'),
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Bottom Sheet',
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
            title: 'Standard Bottom Sheet',
            note: 'TectaBottomSheet is anchored to the bottom edge of the viewport. Supports title headers, handle bars, and action parameters.',
            code: '''showTectaBottomSheet(
  context,
  child: TectaBottomSheet(
    title: 'Permission Request',
    content: Column(
      children: [Text('Allow access?')],
    ),
  ),
)''',
            overview: TectaButton(
              label: 'Trigger Standard Sheet',
              onPressed: () => _showStandardSheet(context, isDark),
            ),
          ),
          ShowcaseSection(
            title: 'List Menu Options',
            note: 'Embed operations menu or action tiles inside the content area of the sheet.',
            code: '''TectaBottomSheet(
  title: 'Choose Action',
  content: Column(
    children: [
      ListTile(title: Text('Share')),
    ],
  ),
)''',
            overview: TectaButton(
              label: 'Trigger List Menu Sheet',
              color: TectaColors.successMain,
              onPressed: () => _showListMenuSheet(context, isDark),
            ),
          ),
          ShowcaseSection(
            title: 'Scrollable Viewport',
            note: 'Add scrolling components inside the content slot. Recommended to wrap in sized constraints boxes.',
            code: '''TectaBottomSheet(
  content: SizedBox(
    height: 250,
    child: ListView.builder(...),
  ),
)''',
            overview: TectaButton(
              label: 'Trigger Scrollable Sheet',
              color: TectaColors.warningMain,
              onPressed: () => _showScrollableSheet(context),
            ),
          ),
          ShowcaseSection(
            title: 'Draggable Expandable Sheet',
            note: 'Wrap TectaBottomSheet inside DraggableScrollableSheet to enable swipe-to-expand capabilities.',
            code: '''showTectaBottomSheet(
  context,
  isScrollControlled: true,
  child: DraggableScrollableSheet(
    builder: (context, controller) {
      return TectaBottomSheet(
        content: ListView(controller: controller, ...),
      );
    },
  ),
)''',
            overview: TectaButton(
              label: 'Trigger Draggable Sheet',
              color: Colors.purple,
              onPressed: () => _showDraggableSheet(context),
            ),
          ),
        ],
      ),
    );
  }
}
