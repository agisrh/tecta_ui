import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

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
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Dropdown Menu',
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
          _buildSectionHeader('CONTEXTUAL ACTIONS (THREE DOTS)'),
          const SizedBox(height: 16),
          _buildCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Card Item Options',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TectaDropdownMenu(
                  items: _contextItems,
                  onItemSelected: (index) {
                    _showFeedback('Selected Action: ${_contextItems[index].label}');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: TectaColors.grey200,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.more_vert_rounded,
                        size: 20, color: TectaColors.grey700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('PROFILE OPTIONS (WITH DIVIDER)'),
          const SizedBox(height: 16),
          _buildCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Tap Avatar to open menu',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
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
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('CUSTOM COLOR (DARK PURPLE OVERLAY)'),
          const SizedBox(height: 16),
          _buildCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Trigger with custom Chip style',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TectaDropdownMenu(
                  items: _contextItems,
                  backgroundColor: Colors.deepPurple.shade900,
                  borderRadius: BorderRadius.circular(16.0),
                  textStyle: const TextStyle(color: Colors.white, fontSize: 13),
                  onItemSelected: (index) {
                    _showFeedback('Selected: ${_contextItems[index].label}');
                  },
                  child: const TectaChip(
                    label: 'Options',
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('DISABLED OPTION ITEMS'),
          const SizedBox(height: 16),
          _buildCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Download / Export options',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
      decoration: BoxDecoration(
        color: TectaColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: child,
    );
  }
}
