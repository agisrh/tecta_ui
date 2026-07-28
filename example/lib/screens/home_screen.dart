import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../main.dart'; // To access themeNotifier

import 'components/foundation/colors_showcase_screen.dart';
import 'components/foundation/typography_showcase_screen.dart';
import 'components/foundation/shadows_showcase_screen.dart';
import 'components/foundation/icons_showcase_screen.dart';
import 'components/display/accordion_showcase_screen.dart';
import 'components/feedback/alert_showcase_screen.dart';
import 'components/display/avatar_showcase_screen.dart';
import 'components/display/badge_showcase_screen.dart';
import 'components/buttons/button_showcase_screen.dart';
import 'components/inputs/checkbox_showcase_screen.dart';
import 'components/display/chip_showcase_screen.dart';
import 'components/inputs/radio_showcase_screen.dart';
import 'components/inputs/switch_showcase_screen.dart';
import 'components/inputs/text_field_showcase_screen.dart';
import 'components/feedback/snackbar_showcase_screen.dart';
import 'components/display/label_showcase_screen.dart';
import 'components/inputs/upload_showcase_screen.dart';
import 'components/feedback/dialog_showcase_screen.dart';
import 'components/feedback/bottom_sheet_showcase_screen.dart';
import 'components/display/card_showcase_screen.dart';
import 'components/feedback/tooltip_showcase_screen.dart';
import 'components/inputs/rating_showcase_screen.dart';
import 'components/display/timeline_showcase_screen.dart';
import 'components/inputs/slider_showcase_screen.dart';
import 'components/display/tabs_showcase_screen.dart';
import 'components/feedback/skeleton_showcase_screen.dart';
import 'components/feedback/empty_state_showcase_screen.dart';
import 'components/feedback/progress_showcase_screen.dart';
import 'components/display/divider_showcase_screen.dart';
import 'components/inputs/picker_showcase_screen.dart';
import 'components/inputs/segmented_control_showcase_screen.dart';
import 'components/feedback/dropdown_menu_showcase_screen.dart';

import 'home_screen_desktop.dart';
import 'home_screen_mobile.dart';

class ShowcaseItem {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final WidgetBuilder builder;

  const ShowcaseItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.builder,
  });
}

class ShowcaseCategory {
  final String title;
  final List<ShowcaseItem> items;

  const ShowcaseCategory({
    required this.title,
    required this.items,
  });
}

// Keep type aliases for backward compatibility inside this file's builder calls
typedef _ShowcaseItem = ShowcaseItem;
typedef _ShowcaseCategory = ShowcaseCategory;

class ShowcaseHomeScreen extends StatefulWidget {
  const ShowcaseHomeScreen({super.key});

  @override
  State<ShowcaseHomeScreen> createState() => _ShowcaseHomeScreenState();
}

class _ShowcaseHomeScreenState extends State<ShowcaseHomeScreen> {
  late ShowcaseItem _selectedItem;
  String _currentTab = 'Components';
  late List<ShowcaseCategory> _categories;

  @override
  void initState() {
    super.initState();
    _categories = _buildShowcaseCategories();
    _selectedItem = _categories.first.items.first;
  }

  List<ShowcaseCategory> _buildShowcaseCategories() {
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
      return ShowcaseDesktopView(
        categories: _categories,
        selectedItem: _selectedItem,
        currentTab: _currentTab,
        themeNotifier: themeNotifier,
        onSelectedItemChanged: (item) {
          setState(() {
            _selectedItem = item;
          });
        },
        onTabChanged: (tab) {
          setState(() {
            _currentTab = tab;
          });
        },
      );
    }

    return ShowcaseMobileView(
      categories: _categories,
      themeNotifier: themeNotifier,
    );
  }
}
