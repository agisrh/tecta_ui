import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class DropdownMenuShowcasePage extends StatefulWidget {
  const DropdownMenuShowcasePage({super.key});

  @override
  State<DropdownMenuShowcasePage> createState() => _DropdownMenuShowcasePageState();
}

class _DropdownMenuShowcasePageState extends State<DropdownMenuShowcasePage> {
  final List<TectaDropdownItem> _contextItems = const [
    TectaDropdownItem(label: 'Edit', icon: Icons.edit_outlined),
    TectaDropdownItem(label: 'Share', icon: Icons.share_outlined),
    TectaDropdownItem(label: 'Delete', icon: Icons.delete_outline, isDestructive: true),
  ];

  final List<TectaDropdownItem> _profileItems = [
    const TectaDropdownItem(label: 'My Profile', icon: Icons.person_outline),
    const TectaDropdownItem(label: 'Account Settings', icon: Icons.settings_outlined),
    TectaDropdownItem.divider(),
    const TectaDropdownItem(label: 'Logout', icon: Icons.logout_rounded, isDestructive: true),
  ];

  final List<TectaDropdownItem> _disabledItems = [
    const TectaDropdownItem(label: 'Download PDF', icon: Icons.picture_as_pdf_outlined),
    const TectaDropdownItem(
        label: 'Download CSV (Premium)', icon: Icons.table_chart_outlined, isEnabled: false),
    TectaDropdownItem.divider(),
    const TectaDropdownItem(label: 'Print', icon: Icons.print_outlined),
  ];

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
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
                'Dropdown Menu',
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
            title: 'Contextual Actions',
            note: 'TectaDropdownMenu attaches contextual operation panels anchored to specific interactive trigger widgets.',
            code: '''TectaDropdownMenu(
  items: const [
    TectaDropdownItem(label: 'Edit', icon: Icons.edit),
    TectaDropdownItem(label: 'Delete', isDestructive: true),
  ],
  onItemSelected: (index) => handleSelection(index),
  child: Icon(Icons.more_vert),
)''',
            overview: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Card options trigger:', style: TextStyle(color: isDark ? Colors.white70 : TectaColors.grey700)),
                TectaDropdownMenu(
                  items: _contextItems,
                  onItemSelected: (index) {
                    _showFeedback('Selected Action: ${_contextItems[index].label}');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withValues(alpha: 0.1) : TectaColors.grey200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.more_vert_rounded, size: 20, color: isDark ? Colors.white70 : TectaColors.grey700),
                  ),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Profile Menu (with Divider)',
            note: 'Add items and structure categories cleanly using dividing rules with TectaDropdownItem.divider().',
            code: '''TectaDropdownMenu(
  items: [
    TectaDropdownItem(label: 'Profile'),
    TectaDropdownItem.divider(),
    TectaDropdownItem(label: 'Logout', isDestructive: true),
  ],
)''',
            overview: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Avatar profile trigger:', style: TextStyle(color: isDark ? Colors.white70 : TectaColors.grey700)),
                TectaDropdownMenu(
                  items: _profileItems,
                  onItemSelected: (index) {
                    final item = _profileItems[index];
                    if (item.label != null) {
                      _showFeedback('Clicked: ${item.label}');
                    }
                  },
                  child: const TectaAvatar(
                    size: 40.0,
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
                    ),
                  ),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Disabled Option Items',
            note: 'Deactivate specific options inside the list by setting isEnabled to false on the individual items.',
            code: '''TectaDropdownItem(
  label: 'Download CSV (Premium)',
  isEnabled: false,
)''',
            overview: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Export options dropdown:', style: TextStyle(color: isDark ? Colors.white70 : TectaColors.grey700)),
                TectaDropdownMenu(
                  items: _disabledItems,
                  onItemSelected: (index) {
                    _showFeedback('Selected Export: ${_disabledItems[index].label}');
                  },
                  child: const TectaButton(
                    label: 'Export Data',
                    icon: Icon(Icons.download_rounded),
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
