import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../main.dart'; // To access themeNotifier

import 'colors_showcase_screen.dart';
import 'typography_showcase_screen.dart';
import 'shadows_showcase_screen.dart';
import 'icons_showcase_screen.dart';
import 'accordion_showcase_screen.dart';
import 'alert_showcase_screen.dart';
import 'avatar_showcase_screen.dart';
import 'badge_showcase_screen.dart';
import 'button_showcase_screen.dart';
import 'checkbox_showcase_screen.dart';
import 'chip_showcase_screen.dart';
import 'radio_showcase_screen.dart';
import 'switch_showcase_screen.dart';
import 'text_field_showcase_screen.dart';
import 'snackbar_showcase_screen.dart';
import 'label_showcase_screen.dart';
import 'upload_showcase_screen.dart';
import 'dialog_showcase_screen.dart';
import 'bottom_sheet_showcase_screen.dart';
import 'card_showcase_screen.dart';
import 'tooltip_showcase_screen.dart';
import 'rating_showcase_screen.dart';
import 'timeline_showcase_screen.dart';
import 'slider_showcase_screen.dart';
import 'tabs_showcase_screen.dart';
import 'skeleton_showcase_screen.dart';
import 'empty_state_showcase_screen.dart';
import 'progress_showcase_screen.dart';
import 'divider_showcase_screen.dart';
import 'picker_showcase_screen.dart';
import 'segmented_control_showcase_screen.dart';
import 'dropdown_menu_showcase_screen.dart';

class ShowcaseHomeScreen extends StatefulWidget {
  const ShowcaseHomeScreen({super.key});

  @override
  State<ShowcaseHomeScreen> createState() => _ShowcaseHomeScreenState();
}

enum PreviewDeviceMode { desktop, mobile }

class _ShowcaseItem {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final WidgetBuilder builder;

  const _ShowcaseItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.builder,
  });
}

class _ShowcaseCategory {
  final String title;
  final List<_ShowcaseItem> items;

  const _ShowcaseCategory({
    required this.title,
    required this.items,
  });
}

class _ShowcaseHomeScreenState extends State<ShowcaseHomeScreen> {
  bool _isGridView = false;
  PreviewDeviceMode _deviceMode = PreviewDeviceMode.desktop;
  late _ShowcaseItem _selectedItem;

  late List<_ShowcaseCategory> _categories;

  @override
  void initState() {
    super.initState();
    _categories = _buildShowcaseCategories();
    _selectedItem = _categories.first.items.first;
  }

  List<_ShowcaseCategory> _buildShowcaseCategories() {
    return [
      _ShowcaseCategory(
        title: 'FOUNDATION',
        items: [
          _ShowcaseItem(
            title: 'Colors',
            description: 'Brand palette & shades',
            icon: Icons.palette_outlined,
            iconColor: TectaColors.primaryMain,
            builder: (context) => const ColorsShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Typography',
            description: 'Dynamic text size scales',
            icon: Icons.format_size_rounded,
            iconColor: TectaColors.secondaryMain,
            builder: (context) => const TypographyShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Shadows',
            description: 'Soft elevation styles',
            icon: Icons.layers_outlined,
            iconColor: TectaColors.infoMain,
            builder: (context) => const ShadowsShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Icons',
            description: 'Solar SVG icon assets',
            icon: Icons.emoji_symbols_outlined,
            iconColor: TectaColors.successMain,
            builder: (context) => const IconsShowcasePage(),
          ),
        ],
      ),
      _ShowcaseCategory(
        title: 'COMPONENTS',
        items: [
          _ShowcaseItem(
            title: 'Buttons',
            description: 'Interactive actions',
            icon: Icons.smart_button_outlined,
            iconColor: TectaColors.successMain,
            builder: (context) => const ButtonShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Checkbox',
            description: 'Selection controls',
            icon: Icons.check_box_outlined,
            iconColor: TectaColors.warningMain,
            builder: (context) => const CheckboxShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Radio Button',
            description: 'Single selection controls',
            icon: Icons.radio_button_checked,
            iconColor: TectaColors.infoMain,
            builder: (context) => const RadioShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Switch',
            description: 'Toggle selections',
            icon: Icons.toggle_on_outlined,
            iconColor: TectaColors.successMain,
            builder: (context) => const SwitchShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Text Field',
            description: 'Text and select inputs',
            icon: Icons.edit_note_rounded,
            iconColor: TectaColors.warningMain,
            builder: (context) => const TextFieldShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Upload',
            description: 'File upload fields',
            icon: Icons.upload_file_outlined,
            iconColor: TectaColors.infoMain,
            builder: (context) => const UploadShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Segmented Control',
            description: 'Custom switch tabs',
            icon: Icons.splitscreen_outlined,
            iconColor: TectaColors.primaryMain,
            builder: (context) => const SegmentedControlShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Chip',
            description: 'Compact elements',
            icon: Icons.tag_outlined,
            iconColor: TectaColors.errorMain,
            builder: (context) => const ChipShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Label',
            description: 'Status colored badges',
            icon: Icons.label_important_outline,
            iconColor: TectaColors.secondaryMain,
            builder: (context) => const LabelShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Accordion',
            description: 'Collapsible text lists',
            icon: Icons.view_day_outlined,
            iconColor: TectaColors.primaryMain,
            builder: (context) => const AccordionShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Alert',
            description: 'Status notifications',
            icon: Icons.info_outline,
            iconColor: TectaColors.infoMain,
            builder: (context) => const AlertShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Avatar',
            description: 'User profile badges',
            icon: Icons.account_circle_outlined,
            iconColor: TectaColors.primaryMain,
            builder: (context) => const AvatarShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Badge',
            description: 'Dynamic overlap indicators',
            icon: Icons.notifications_active_outlined,
            iconColor: TectaColors.errorMain,
            builder: (context) => const BadgeShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Card',
            description: 'Compartment layout boxes',
            icon: Icons.credit_card_outlined,
            iconColor: TectaColors.secondaryMain,
            builder: (context) => const CardShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Divider',
            description: 'Sleek custom separating lines',
            icon: Icons.horizontal_rule_rounded,
            iconColor: TectaColors.grey500,
            builder: (context) => const DividerShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Dropdown Menu',
            description: 'Premium action list popovers',
            icon: Icons.arrow_drop_down_circle_outlined,
            iconColor: TectaColors.primaryMain,
            builder: (context) => const DropdownMenuShowcasePage(),
          ),
        ],
      ),
      _ShowcaseCategory(
        title: 'OVERLAYS & CONTROLS',
        items: [
          _ShowcaseItem(
            title: 'Dialog',
            description: 'Overlay popups',
            icon: Icons.picture_in_picture_outlined,
            iconColor: TectaColors.successMain,
            builder: (context) => const DialogShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Bottom Sheet',
            description: 'Slide up modal drawers',
            icon: Icons.call_to_action_outlined,
            iconColor: TectaColors.infoMain,
            builder: (context) => const BottomSheetShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Snackbar',
            description: 'Toast feedback messages',
            icon: Icons.sms_failed_outlined,
            iconColor: TectaColors.warningMain,
            builder: (context) => const SnackbarShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Tooltip',
            description: 'Hover bubble note tags',
            icon: Icons.label_outline_rounded,
            iconColor: TectaColors.primaryMain,
            builder: (context) => const TooltipShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Rating',
            description: 'Premium feedback stars',
            icon: Icons.star_rate_rounded,
            iconColor: TectaColors.warningMain,
            builder: (context) => const RatingShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Slider',
            description: 'Custom slider values',
            icon: Icons.linear_scale_rounded,
            iconColor: TectaColors.successMain,
            builder: (context) => const SliderShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Tabs',
            description: 'Interactive page switches',
            icon: Icons.tab_unselected_rounded,
            iconColor: TectaColors.primaryMain,
            builder: (context) => const TabsShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Timeline',
            description: 'Process step guides',
            icon: Icons.timeline_rounded,
            iconColor: TectaColors.secondaryMain,
            builder: (context) => const TimelineShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'DatePicker & TimePicker',
            description: 'Premium calendar dialogs',
            icon: Icons.calendar_month_outlined,
            iconColor: TectaColors.infoMain,
            builder: (context) => const PickerShowcasePage(),
          ),
        ],
      ),
      _ShowcaseCategory(
        title: 'FEEDBACK & PLACEHOLDERS',
        items: [
          _ShowcaseItem(
            title: 'Skeleton',
            description: 'Shimmering placeholders',
            icon: Icons.hourglass_empty_rounded,
            iconColor: TectaColors.grey400,
            builder: (context) => const SkeletonShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Empty State',
            description: 'No content illustrative frames',
            icon: Icons.inbox_outlined,
            iconColor: TectaColors.errorMain,
            builder: (context) => const EmptyStateShowcasePage(),
          ),
          _ShowcaseItem(
            title: 'Progress',
            description: 'Dynamic color cycling loaders',
            icon: Icons.rotate_right_rounded,
            iconColor: TectaColors.primaryMain,
            builder: (context) => const ProgressShowcasePage(),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            // Left Sidebar
            _buildSidebar(),
            // Main Playground Canvas
            Expanded(
              child: Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? TectaColors.grey900
                    : TectaColors.grey100,
                child: Column(
                  children: [
                    _buildPlaygroundHeader(),
                    Expanded(
                      child: Center(
                        child: _buildPreviewCanvas(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Mobile Viewport Default Layout (original fallback list/grid)
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tecta Design System',
          style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
              color: TectaColors.grey800,
            ),
            tooltip: _isGridView ? 'Switch to List View' : 'Switch to Grid View',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: Icon(
              themeNotifier.value == ThemeMode.dark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: TectaColors.grey800,
            ),
            onPressed: () {
              themeNotifier.value =
                  themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: _categories.map<Widget>((category) {
          return _buildMobileCategorySection(category);
        }).toList(),
      ),
    );
  }

  // ===========================================================================
  // PLAYGROUND PREVIEW RENDERING (DESKTOP MODE)
  // ===========================================================================

  Widget _buildPreviewCanvas() {
    final previewWidget = KeyedSubtree(
      key: ValueKey('${_selectedItem.title}_${themeNotifier.value}'),
      child: Builder(builder: (context) => _selectedItem.builder(context)),
    );

    if (_deviceMode == PreviewDeviceMode.mobile) {
      // Return a simulated iPhone device frame mockup
      return Container(
        width: 375,
        height: 780,
        margin: const EdgeInsets.symmetric(vertical: 24.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 32,
              offset: const Offset(0, 16),
            ),
          ],
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? TectaColors.grey700
                : TectaColors.grey300,
            width: 12.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28.0),
          child: Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 36.0), // Give room for iPhone notch/status bar
                    child: previewWidget,
                  ),
                ),
                // Simulated Status Bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 36,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '9:41',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.signal_cellular_4_bar_rounded,
                                size: 12,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black87),
                            const SizedBox(width: 4),
                            Icon(Icons.wifi,
                                size: 12,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black87),
                            const SizedBox(width: 4),
                            Icon(Icons.battery_5_bar_rounded,
                                size: 12,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black87),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Notch
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 110,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    String categoryTitle = 'Foundation';
    for (final cat in _categories) {
      if (cat.items.contains(_selectedItem)) {
        categoryTitle = cat.title;
        break;
      }
    }
    final formattedCategory =
        categoryTitle[0].toUpperCase() + categoryTitle.substring(1).toLowerCase();

    // Desktop view just renders the selected page directly on the flat page background
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedItem.title,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : TectaColors.grey800,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    formattedCategory,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : TectaColors.grey800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '•',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white30
                            : TectaColors.grey400,
                      ),
                    ),
                  ),
                  Text(
                    _selectedItem.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: TectaColors.grey500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: previewWidget,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaygroundHeader() {
    final theme = Theme.of(context);
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Row(
            children: [
              // Device Mode Segmented Switch
              Container(
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? TectaColors.grey800
                      : TectaColors.grey100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    _buildDeviceTab(
                      label: 'Desktop View',
                      icon: Icons.computer_rounded,
                      isActive: _deviceMode == PreviewDeviceMode.desktop,
                      onTap: () => setState(() => _deviceMode = PreviewDeviceMode.desktop),
                    ),
                    _buildDeviceTab(
                      label: 'Mobile View',
                      icon: Icons.phone_android_rounded,
                      isActive: _deviceMode == PreviewDeviceMode.mobile,
                      onTap: () => setState(() => _deviceMode = PreviewDeviceMode.mobile),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              // Theme Toggle Button
              IconButton(
                icon: Icon(
                  themeNotifier.value == ThemeMode.dark
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                  color: TectaColors.grey800,
                ),
                onPressed: () {
                  setState(() {
                    themeNotifier.value =
                        themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceTab({
    required String label,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isActive ? theme.cardColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive ? TectaColors.primaryMain : TectaColors.grey500,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isActive ? TectaColors.grey800 : TectaColors.grey500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    final theme = Theme.of(context);
    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(right: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Logo
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(
              color: theme.cardColor,
              border: Border(bottom: BorderSide(color: theme.dividerColor)),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: TectaColors.primaryMain,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'T',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Tecta UI',
                  style: TectaTypography.subtitle1.copyWith(
                    fontWeight: FontWeight.w800,
                    color: TectaColors.grey800,
                  ),
                ),
              ],
            ),
          ),
          // Scrollable Sidebar list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              children: _categories.map<Widget>((category) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: Text(
                        category.title,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: TectaColors.grey400,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    ...category.items.map((item) {
                      final isSelected = _selectedItem == item;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                        child: Material(
                          color: isSelected ? TectaColors.primaryLighter : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedItem = item;
                              });
                            },
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    item.icon,
                                    size: 20,
                                    color:
                                        isSelected ? TectaColors.primaryMain : TectaColors.grey500,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                        color: isSelected
                                            ? TectaColors.primaryMain
                                            : TectaColors.grey700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // MOBILE VIEWPORT RENDERING (FALLBACK VIEW)
  // ===========================================================================

  Widget _buildMobileCategorySection(_ShowcaseCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
          child: Text(
            category.title,
            style: TectaTypography.caption.copyWith(
              color: TectaColors.grey500,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
        ),
        _isGridView
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: category.items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final item = category.items[index];
                  return _buildGridCard(context, item);
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: category.items.length,
                itemBuilder: (context, index) {
                  final item = category.items[index];
                  return _buildListCard(context, item);
                },
              ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildGridCard(BuildContext context, _ShowcaseItem item) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item.builder(context)),
            );
          },
          borderRadius: BorderRadius.circular(16.0),
          splashColor: TectaColors.primaryLighter.withValues(alpha: 0.3),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: item.iconColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Icon(
                        item.icon,
                        color: item.iconColor,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  item.title,
                  style: (theme.textTheme.titleSmall ?? TectaTypography.subtitle2).copyWith(
                    color: TectaColors.grey800,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: (theme.textTheme.bodySmall ?? TectaTypography.caption).copyWith(
                    color: TectaColors.grey500,
                    fontSize: 11,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListCard(BuildContext context, _ShowcaseItem item) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item.builder(context)),
            );
          },
          borderRadius: BorderRadius.circular(12.0),
          splashColor: TectaColors.primaryLighter.withValues(alpha: 0.3),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: item.iconColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: (theme.textTheme.titleSmall ?? TectaTypography.subtitle2).copyWith(
                          color: TectaColors.grey800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.description,
                        style: (theme.textTheme.bodySmall ?? TectaTypography.caption).copyWith(
                          color: TectaColors.grey500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: TectaColors.grey400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
