## 0.0.6
* Added support for dynamic primary and secondary colors in design system components.
* Refactored component default colors to fallback to `Theme.of(context).colorScheme.primary` or `Theme.of(context).colorScheme.secondary` instead of hardcoded `TectaColors` constants.
* Updated `TectaTheme` to support custom brand colors via `buildTheme(primaryColor: ..., secondaryColor: ...)`.

## 0.0.5
* Enhanced package documentation and installation guides to direct users to pub.dev.
* Cleaned up unused methods and UI code across blocks layouts.
* Cooming soon Block Layouts.

## 0.0.4

* Added `TectaSegmentedControl` component with premium sliding animations and customizable style properties.
* Added `TectaDropdownMenu` component supporting context lists, customizable overlays, dividers, and disabled items.
* Added `TectaCalendar`, `TectaDatePicker`, `TectaDateRangePicker`, `TectaMonthPicker`, `TectaYearPicker`, and `TectaTimePicker` components with full customization and localization support.
* Added `TectaDivider` component.
* Enhanced color flexibility and customization options across components.
* Added comprehensive interactive playgrounds for all 18 remaining components and foundations (Typography, Shadows, Icons, Checkbox, Switch, Slider, Picker, SegmentedControl, Skeleton, Progress, Accordion, Timeline, Tabs, Label, Dialog, BottomSheet, Snackbar, Tooltip, DropdownMenu).
* Implemented fixed `maxWidth` layout constraints (e.g., max-width 360/320px) on all picker dialogs to prevent unnecessary horizontal stretching on larger web/desktop screens.
* Locked playground canvas theme mode to light to prevent styling color conflicts inside code preview.

## 0.0.3

* Fully documented all public widget constructors.

## 0.0.2

* Upgraded `flutter_svg` dependency constraint to `^2.3.0` and `google_fonts` to `^8.1.0`.
* Improved public API documentation comments coverage to exceed 20%.
* Made helper border painter `_DashedBorderPainter` private to clean up public API surface.

## 0.0.1

* TODO: Describe initial release.
