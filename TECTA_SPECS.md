# Tecta Design System — AI-Ready Specifications

This document contains structured technical specifications, design tokens (colors, typography, & shadows), and code integration patterns for the **Tecta Design System**. These specifications are optimized for AI Coding Agents and developers to ensure accurate widget instantiation and prevent styling discrepancies.

---

## 1. Foundation & Design Tokens

### A. TectaColors
Premium color tokens are defined in [TectaColors](https://github.com/agisrh/tecta-ui/blob/main/lib/src/foundation/tecta_colors.dart).

| Token Name | Default Value / Color | Description |
| :--- | :--- | :--- |
| `primaryMain` | `Color(0xFF225BFF)` | Primary brand color (blue) |
| `primaryDark` | `Color(0xFF0038D7)` | Brand color for dark themes or pressed states |
| `primaryLight` | `Color(0xFF6B8EFF)` | Brand color light variant |
| `primaryLighter` | `Color(0xFFE8EEFF)` | Semitransparent soft blue background tint |
| `secondaryMain` | `Color(0xFF4F5E7B)` | Supportive neutral-blue / slate color |
| `successMain` | `Color(0xFF00B27A)` | Success feedback / positive validation |
| `infoMain` | `Color(0xFF0091FF)` | General informational notice status |
| `warningMain` | `Color(0xFFFF9E00)` | Warning / attention status |
| `errorMain` | `Color(0xFFFF3B30)` | Critical error / destructive action status |
| `white` | `Color(0xFFFFFFFF)` | Absolute white |
| `grey100` to `grey900` | Light-to-dark grey scale | Neutral colors for borders, text, and surfaces |

### B. TectaTypography
The design system enforces the following premium font scales defined in [TectaTypography](https://github.com/agisrh/tecta-ui/blob/main/lib/src/foundation/tecta_typography.dart):

*   `h1` (32px, Bold) - Primary title for very large layouts.
*   `h2` (28px, Bold) - Primary title for standard screen headers.
*   `h3` (24px, Bold) - Large section header.
*   `h4` (20px, Bold) - Medium section header.
*   `h5` (18px, Bold) - Page subheadings.
*   `h6` (16px, Bold) - Dialog titles / minor section headers.
*   `subtitle1` (16px, Medium) - Thick body text / card titles.
*   `subtitle2` (14px, Medium) - Button labels / list headers.
*   `body1` (16px, Regular) - Main description text / paragraph text.
*   `body2` (14px, Regular) - Secondary description / form fields / dialog body text.
*   `caption` (12px, Regular) - Micro descriptions / captions / helper texts.

### C. TectaShadows
Custom smooth double-layer shadows for realistic depth, defined in [TectaShadows](https://github.com/agisrh/tecta-ui/blob/main/lib/src/foundation/tecta_shadows.dart).
*   **Elevation Tokens**: `z1`, `z4`, `z8`, `z12`, `z16`, `z20`, `z24`.
*   **Semantic Aliases**:
    *   `TectaShadows.card` (Standard z8 shadow)
    *   `TectaShadows.dropdown` (Standard z12 shadow)
    *   `TectaShadows.dialog` (Standard z16 shadow)
*   **Brand Glow Shadows**:
    *   `TectaShadows.primary` (Blue glow shadow)
    *   `TectaShadows.success` (Green glow shadow)
    *   `TectaShadows.warning` (Orange glow shadow)
    *   `TectaShadows.error` (Red glow shadow)
    *   `TectaShadows.info` (Light blue glow shadow)

### D. TectaTheme
Global design system parameters config defined in [TectaTheme](https://github.com/agisrh/tecta-ui/blob/main/lib/src/theme/tecta_theme.dart). Contains targeted parameters to control active typography styles and theme configurations.

---

## 2. Component Specifications

### A. Accordion
*   **Source File**: [tecta_accordion.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/accordion/tecta_accordion.dart)
*   **Signature**:
    ```dart
    const TectaAccordion({
      super.key,
      required String title,
      required Widget content,
      bool initiallyExpanded = false,
      Color? headerColor,
      TextStyle? titleStyle,
      EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    });
    ```

### B. Alert
*   **Source File**: [tecta_alert.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/alert/tecta_alert.dart)
*   **Signature**:
    ```dart
    const TectaAlert({
      super.key,
      String? title,
      String? message,
      Widget? child,
      TectaAlertSeverity severity = TectaAlertSeverity.info,
      TectaAlertVariant variant = TectaAlertVariant.soft,
      Widget? leading,
      Widget? action,
      VoidCallback? onClose,
      TextStyle? titleStyle,
      TextStyle? messageStyle,
      double? iconSize,
      Color? iconColor,
      Color? closeIconColor,
      Color? backgroundColor,
      BorderRadiusGeometry? borderRadius,
      BoxBorder? border,
      EdgeInsetsGeometry? margin = EdgeInsets.zero,
      EdgeInsetsGeometry? padding = const EdgeInsets.all(16.0),
      CrossAxisAlignment? crossAxisAlignment,
    });
    ```

### C. Avatar & AvatarGroup
*   **Source File**: [tecta_avatar.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/avatar/tecta_avatar.dart)
*   **Signature**:
    ```dart
    const TectaAvatar({
      super.key,
      String? imageUrl,
      String? initials,
      double size = 40.0,
      Color? backgroundColor,
      TextStyle? textStyle,
      bool showOnlineStatus = false,
      Color? statusColor,
    });
    ```
*   **AvatarGroup Signature**:
    ```dart
    const TectaAvatarGroup({
      super.key,
      required List<TectaAvatar> avatars,
      int maxVisible = 4,
      double overlapOffset = 16.0,
      TextStyle? counterStyle,
      Color? counterBackgroundColor,
    });
    ```

### D. Badge
*   **Source File**: [tecta_badge.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/badge/tecta_badge.dart)
*   **Signature**:
    ```dart
    const TectaBadge({
      super.key,
      required Widget child,
      String? label,
      Color? color,
      TextStyle? textStyle,
      bool isDot = false,
      double? offset,
    });
    ```

### E. Buttons
*   **TectaButton Signature**: [tecta_button.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/buttons/tecta_button.dart)
    ```dart
    const TectaButton({
      super.key,
      required String label,
      required VoidCallback? onPressed,
      TectaButtonVariant variant = TectaButtonVariant.filled,
      TectaButtonSize size = TectaButtonSize.medium,
      IconData? leadingIcon,
      IconData? trailingIcon,
      bool loading = false,
      bool disabled = false,
      Color? customBackgroundColor,
      Color? customTextColor,
      double? customBorderRadius,
    });
    ```
*   **TectaIconButton Signature**: [tecta_icon_button.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/buttons/tecta_icon_button.dart)
    ```dart
    const TectaIconButton({
      super.key,
      required IconData icon,
      required VoidCallback? onPressed,
      TectaButtonVariant variant = TectaButtonVariant.filled,
      TectaButtonSize size = TectaButtonSize.medium,
      bool loading = false,
      bool disabled = false,
      Color? customBackgroundColor,
      Color? customIconColor,
      double? customBorderRadius,
    });
    ```
*   **TectaFAB Signature**: [tecta_fab.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/buttons/tecta_fab.dart)
    ```dart
    const TectaFAB({
      super.key,
      required IconData icon,
      required VoidCallback onPressed,
      String? label,
      bool mini = false,
      Color? backgroundColor,
      Color? foregroundColor,
      double? elevation,
    });
    ```

### F. Inputs (Checkbox, Radio, Switch, Text Field, Upload)
*   **Checkbox**: [tecta_checkbox.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/inputs/tecta_checkbox.dart)
    ```dart
    const TectaCheckbox({
      super.key,
      required bool? value,
      required ValueChanged<bool?>? onChanged,
      String? label,
      bool disabled = false,
      Color? activeColor,
      Color? checkColor,
    });
    ```
*   **Radio**: [tecta_radio.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/inputs/tecta_radio.dart)
    ```dart
    const TectaRadio({
      super.key,
      required dynamic value,
      required dynamic groupValue,
      required ValueChanged<dynamic>? onChanged,
      String? label,
      bool disabled = false,
      Color? activeColor,
    });
    ```
*   **Switch**: [tecta_switch.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/inputs/tecta_switch.dart)
    ```dart
    const TectaSwitch({
      super.key,
      required bool value,
      required ValueChanged<bool>? onChanged,
      String? label,
      bool disabled = false,
      Color? activeTrackColor,
      Color? activeColor,
    });
    ```
*   **TextField**: [tecta_text_field.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/inputs/tecta_text_field.dart)
    ```dart
    const TectaTextField({
      super.key,
      TextEditingController? controller,
      String? labelText,
      String? placeholderText,
      String? helperText,
      String? errorText,
      bool isPassword = false,
      bool isEnabled = true,
      Widget? leadingIcon,
      Widget? trailingIcon,
      TextInputType keyboardType = TextInputType.text,
      int maxLines = 1,
      ValueChanged<String>? onChanged,
      List<String>? selectOptions,
      String? selectedOptionValue,
      ValueChanged<String?>? onSelectChanged,
      Color? focusedBorderColor,
      Color? enabledBorderColor,
      Color? fillColor,
      double? borderRadius,
    });
    ```
*   **Upload**: [tecta_upload.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/inputs/tecta_upload.dart)
    ```dart
    // Avatar Upload variant
    const TectaUpload.avatar({
      super.key,
      required VoidCallback onTap,
      String? imageUrl,
      double size = 80.0,
      bool disabled = false,
    });
    
    // Box Upload variant
    const TectaUpload.box({
      super.key,
      required VoidCallback onTap,
      String? title,
      String? subtitle,
      String? loadedFileName,
      bool disabled = false,
    });
    ```

### G. Calendar & Date/Time Pickers
*   **Calendar**: [tecta_calendar.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/date_picker/tecta_calendar.dart)
    ```dart
    const TectaCalendar({
      super.key,
      DateTime? selectedDate,
      ValueChanged<DateTime>? onDateSelected,
      DateTime? rangeStartDate,
      DateTime? rangeEndDate,
      void Function(DateTime? start, DateTime? end)? onRangeSelected,
      TectaCalendarSelectionMode selectionMode = TectaCalendarSelectionMode.single,
      DateTime? firstDate,
      DateTime? lastDate,
      Color? selectedColor,
      Color? todayColor,
      Color? rangeColor,
      TextStyle? headerTextStyle,
      TextStyle? weekdayTextStyle,
      TextStyle? dayTextStyle,
      TextStyle? selectedDayTextStyle,
      TextStyle? todayTextStyle,
      List<String>? weekdays,
      List<String>? monthNames,
      List<TectaCalendarEvent>? events,
      TextStyle? weekendHeaderTextStyle,
      TextStyle? weekendDayTextStyle,
    });
    ```
*   **MonthPicker**: [tecta_month_year_picker.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/date_picker/tecta_month_year_picker.dart)
    ```dart
    const TectaMonthPicker({
      super.key,
      required int selectedMonth,
      required ValueChanged<int> onMonthSelected,
      int? minMonth,
      int? maxMonth,
      Color? selectedColor,
      TextStyle? textStyle,
      TextStyle? selectedTextStyle,
      List<String>? monthNames,
    });
    ```
*   **YearPicker**: [tecta_month_year_picker.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/date_picker/tecta_month_year_picker.dart)
    ```dart
    const TectaYearPicker({
      super.key,
      required int selectedYear,
      required ValueChanged<int> onYearSelected,
      int firstYear = 1900,
      int lastYear = 2100,
      Color? selectedColor,
      TextStyle? textStyle,
      TextStyle? selectedTextStyle,
    });
    ```
*   **TimePicker**: [tecta_time_picker.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/date_picker/tecta_time_picker.dart)
    ```dart
    const TectaTimePicker({
      super.key,
      required TimeOfDay initialTime,
      required ValueChanged<TimeOfDay> onTimeChanged,
      bool use24hFormat = true,
      TectaTimePickerStyle style = TectaTimePickerStyle.clockDial,
      Color? activeColor,
    });
    ```
*   **Interactive Picker Dialogs Helpers**: [tecta_picker_dialogs.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/date_picker/tecta_picker_dialogs.dart)
    *   `showTectaDatePicker`: Returns `Future<DateTime?>`
    *   `showTectaDateRangePicker`: Returns `Future<DateTimeRange?>`
    *   `showTectaMonthPicker`: Returns `Future<int?>`
    *   `showTectaYearPicker`: Returns `Future<int?>`
    *   `showTectaTimePicker`: Returns `Future<TimeOfDay?>`

### H. SegmentedControl
*   **Source File**: [tecta_segmented_control.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/segmented_control/tecta_segmented_control.dart)
*   **Signature**:
    ```dart
    const TectaSegmentedControl({
      super.key,
      required List<TectaSegmentedOption> options,
      required String selectedValue,
      required ValueChanged<String> onValueChanged,
      bool disabled = false,
      Color? backgroundColor,
      Color? indicatorColor,
      BorderRadiusGeometry? borderRadius,
      double? height,
      EdgeInsetsGeometry? outerPadding,
      EdgeInsetsGeometry? itemPadding,
      BorderRadiusGeometry? indicatorBorderRadius,
    });
    ```

### I. Dialog, BottomSheet, Snackbar & Tooltip
*   **Dialog**: [tecta_dialog.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/dialog/tecta_dialog.dart)
    ```dart
    Future<T?> showTectaDialog<T>({
      required BuildContext context,
      required String title,
      required Widget content,
      List<Widget>? actions,
      bool barrierDismissible = true,
    });
    ```
*   **BottomSheet**: [tecta_bottom_sheet.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/bottom_sheet/tecta_bottom_sheet.dart)
    ```dart
    Future<T?> showTectaBottomSheet<T>({
      required BuildContext context,
      required Widget child,
      String? title,
      List<Widget>? headerActions,
      bool isScrollControlled = false,
    });
    ```
*   **Snackbar**: [tecta_snackbar.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/snackbar/tecta_snackbar.dart)
    ```dart
    const TectaSnackbar({
      super.key,
      required String message,
      String? title,
      Widget? leading,
      Widget? action,
      VoidCallback? onClose,
      Color? backgroundColor,
      TextStyle? titleStyle,
      TextStyle? messageStyle,
    });
    ```
*   **Tooltip**: [tecta_tooltip.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/tooltip/tecta_tooltip.dart)
    ```dart
    const TectaTooltip({
      super.key,
      required Widget child,
      required String message,
      TectaTooltipPosition position = TectaTooltipPosition.top,
      bool triggerOnTap = false,
    });
    ```

### J. Labels & Chips
*   **Chip**: [tecta_chip.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/labels/tecta_chip.dart)
    ```dart
    const TectaChip({
      super.key,
      required String label,
      bool isEnabled = true,
      VoidCallback? onTap,
      VoidCallback? onDelete,
      Color? backgroundColor,
      Color? textColor,
      Widget? leadingIcon,
    });
    ```
*   **Label**: [tecta_label.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/labels/tecta_label.dart)
    ```dart
    const TectaLabel({
      super.key,
      required String text,
      TectaLabelVariant variant = TectaLabelVariant.filled,
      Color? customColor,
      IconData? startIcon,
      IconData? endIcon,
    });
    ```

### K. Card, Divider, DropdownMenu, Rating, Slider, Tabs, Timeline
*   **Card**: [tecta_card.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/card/tecta_card.dart)
    ```dart
    const TectaCard({
      super.key,
      required Widget child,
      Widget? header,
      VoidCallback? onTap,
      Color? backgroundColor,
      double? borderRadius,
      double? elevation,
    });
    ```
*   **Divider**: [tecta_divider.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/divider/tecta_divider.dart)
    ```dart
    const TectaDivider({
      super.key,
      String? label,
      TectaDividerOrientation orientation = TectaDividerOrientation.horizontal,
      Color? color,
      double? thickness,
    });
    ```
*   **DropdownMenu**: [tecta_dropdown_menu.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/dropdown_menu/tecta_dropdown_menu.dart)
    ```dart
    const TectaDropdownMenu({
      super.key,
      required Widget child,
      required List<TectaDropdownMenuItem> items,
      bool disabled = false,
    });
    ```
*   **Rating**: [tecta_rating.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/rating/tecta_rating.dart)
    ```dart
    const TectaRating({
      super.key,
      required double rating,
      required ValueChanged<double> onRatingChanged,
      int maxStars = 5,
      Color? activeColor,
      Color? inactiveColor,
      double size = 24.0,
    });
    ```
*   **Slider**: [tecta_slider.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/slider/tecta_slider.dart)
    ```dart
    const TectaSlider({
      super.key,
      required double value,
      required ValueChanged<double> onChanged,
      double min = 0.0,
      double max = 1.0,
      Color? activeColor,
      Color? inactiveColor,
    });
    ```
*   **Tabs**: [tecta_tabs.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/tabs/tecta_tabs.dart)
    ```dart
    const TectaTabs({
      super.key,
      required List<String> tabLabels,
      required int initialIndex,
      required ValueChanged<int> onTabChanged,
      Color? activeColor,
      Color? inactiveColor,
    });
    ```
*   **Timeline**: [tecta_timeline.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/timeline/tecta_timeline.dart)
    ```dart
    const TectaTimeline({
      super.key,
      required List<TectaTimelineItem> items,
      Color? lineColor,
      double lineThickness = 2.0,
    });
    ```

### L. Feedback & Placeholders (Skeleton, EmptyState, Progress)
*   **Skeleton**: [tecta_skeleton.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/skeleton/tecta_skeleton.dart)
    ```dart
    const TectaSkeleton({
      super.key,
      required double width,
      required double height,
      bool isCircle = false,
      double? borderRadius,
      Duration animationDuration = const Duration(milliseconds: 1500),
    });
    ```
*   **EmptyState**: [tecta_empty_state.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/empty_state/tecta_empty_state.dart)
    ```dart
    const TectaEmptyState({
      super.key,
      required String title,
      required String description,
      Widget? illustration,
      String? actionLabel,
      VoidCallback? onActionPressed,
    });
    ```
*   **Progress**: [tecta_progress.dart](https://github.com/agisrh/tecta-ui/blob/main/lib/src/components/progress/tecta_progress.dart)
    ```dart
    const TectaProgress({
      super.key,
      TectaProgressType type = TectaProgressType.circular,
      double? value,
      Color? color,
      List<Color>? cyclingColors,
      double strokeWidth = 4.0,
    });
    ```

---

## 3. Best Practices for AI Agents

When constructing or modifying layouts using Tecta, always observe these instructions:
1.  **Prioritize Design Tokens**: Do not define hardcoded colors or fonts. Utilize `TectaColors`, `TectaTypography`, and `TectaShadows` to enforce visual consistency.
2.  **Avoid Wrapping in Ad-hoc Containers**: Check if the component exposes customization parameters (e.g. `itemPadding` and `borderRadius` are natively supported in `TectaSegmentedControl`).
3.  **Correct Event Instantiation**: Always supply calendar event tags using `TectaCalendarEvent` objects.
