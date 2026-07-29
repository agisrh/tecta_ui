# Tecta

[![pub package](https://img.shields.io/pub/v/tecta_ui.svg)](https://pub.dev/packages/tecta_ui)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A sleek, premium, and highly-customizable Flutter UI design system inspired by the modern **MUI (Material UI)** and **Minimals** design language. 

Tecta provides a complete set of visually stunning, flexible, and robust components designed to speed up development while offering custom theme structures (typography, shadow depths, and curated HSL palettes).

---

## 🚀 Key Features

* **Beautiful Foundations**: Comprehensive brand colors (Primary, Secondary, Success, Warning, Info, Error, and Grey shades), modern typography scale (using Google Sans), and smooth elevation shadows.
* **Segmented & Contained Controls**: Premium iOS/macOS styled contained tabs tray, capsule pill tabs, and classic line indicators with zero horizontal layout overflows.
* **Google-Style Progress Loaders**: Indeterminate progress bars that cycle smoothly through a list of custom brand colors.
* **Robust Feedback & Modals**: Overlay-based tooltip bubble notes with 4 direction support, rating star bars (half stars & tap gestures), timeline step guides, drag sliders, sheet drawers, dialogs, and snackbars.
* **Responsive & Adaptive**: Zero hardcoded overflows, flexible layout constraints, and cross-platform layout compatibility.

---

## 🤖 AI & Agent Ready

Tecta is built to be easily understood and integrated by AI coding assistants (such as Copilot, Cursor, Gemini, and GPT). We provide a single-file, structured API specification that you can feed directly to your AI agents:

*   **[TECTA_SPECS.md](TECTA_SPECS.md)**: A complete, structured cheatsheet containing all design tokens, signatures, constructor parameters, and code snippets for our 23+ components.

### How to use with AI:
When prompting your coding assistant, simply reference `@TECTA_SPECS.md` in your IDE context window (or copy its content to the system prompt) and say:
> *"Create a page using Tecta components. Refer to TECTA_SPECS.md for accurate widget signatures."*

---

## 📦 Installed Components

| Category | Components |
|---|---|
| **Foundation** | `TectaColors`, `TectaTypography`, `TectaShadows` |
| **Buttons** | `TectaButton`, `TectaIconButton`, `TectaFab` (Outlined, Soft, Contained) |
| **Inputs** | `TectaTextField` (Text & Selection), `TectaCheckbox`, `TectaRadio`, `TectaSwitch`, `TectaUpload` (Box & Avatar Upload zones) |
| **Data Display** | `TectaCard` (with compartment zones & hover lift animations), `TectaAccordion`, `TectaAvatar`, `TectaAvatarGroup`, `TectaBadge`, `TectaChip` (Tag style), `TectaLabel` (Status chips), `TectaTimeline` (Solid & dashed step paths) |
| **Feedback & Modal** | `TectaAlert`, `TectaSnackbar` (Toasts), `TectaDialog`, `TectaBottomSheet` (Scrollable / Draggable layout) |
| **Overlays & Controls** | `TectaTooltip` (4-direction overlays), `TectaRating` (half/full stars), `TectaSlider`, `TectaTabs` (Line, Pill, Contained) |
| **Loading & Placeholders** | `TectaSkeleton` (pulsing shimmers), `TectaEmptyState` (clean placeholder layout screens) |

---

## 🏁 Getting Started

### 1. Add dependency

Add `tecta_ui` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  tecta_ui: ^0.0.1 # Or latest version from pub.dev
```

Or run this command in your terminal:

```bash
flutter pub add tecta_ui
```

### 2. Import package

Import the library in your Dart code:

```dart
import 'package:tecta_ui/tecta_ui.dart';
```

---

## 💡 Usage Examples

### 1. Primary Button
```dart
TectaButton(
  label: 'Get Started',
  variant: TectaButtonVariant.contained,
  onPressed: () {
    print('Button Pressed!');
  },
)
```

### 2. Contained Segmented Tabs (iOS/macOS Control Style)
```dart
TectaTabs(
  selectedIndex: _activeIndex,
  variant: TectaTabsVariant.contained,
  tabs: const [
    TectaTab(label: 'Daily'),
    TectaTab(label: 'Weekly'),
    TectaTab(label: 'Monthly'),
  ],
  onTabChanged: (index) {
    setState(() => _activeIndex = index);
  },
)
```

### 3. Google-Style Multi-Color Progress Spinner
```dart
TectaCircularProgress(
  size: 40.0,
  strokeWidth: 4.0,
  colors: [
    TectaColors.infoMain,
    TectaColors.errorMain,
    TectaColors.warningMain,
    TectaColors.successMain,
  ],
)
```

### 4. Interactive Rating Star Bar
```dart
TectaRating(
  rating: 3.5,
  allowHalfRating: true,
  onRatingChanged: (newRating) {
    print('New rating: $newRating');
  },
)
```

### 5. Premium Empty State Screen
```dart
TectaEmptyState(
  title: 'No Mail Found',
  description: 'Your inbox is clear! Check back later for incoming messages.',
  iconData: Icons.folder_off_outlined,
  action: TectaButton(
    label: 'Refresh Inbox',
    onPressed: () => refresh(),
  ),
)
```

---

## 🛠️ Running the Showcase Application

To see all components in action and inspect their design parameters, run the included example app:

```bash
cd example
flutter run
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
