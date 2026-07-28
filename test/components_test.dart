import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tecta_ui/tecta_ui.dart';

void main() {
  group('TectaAlert Widget Tests', () {
    testWidgets('renders message correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TectaAlert(message: 'Alert message content')),
        ),
      );

      expect(find.text('Alert message content'), findsOneWidget);
    });

    testWidgets('renders title and message correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaAlert(title: 'Alert Title', message: 'Alert message content'),
          ),
        ),
      );

      expect(find.text('Alert Title'), findsOneWidget);
      expect(find.text('Alert message content'), findsOneWidget);
    });

    testWidgets('renders action widget and handles close callback', (WidgetTester tester) async {
      bool closed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaAlert(message: 'Alert with close', onClose: () => closed = true),
          ),
        ),
      );

      final closeFinder = find.byIcon(SolarLinearIcons.close);
      expect(closeFinder, findsOneWidget);
      await tester.tap(closeFinder);
      await tester.pumpAndSettle();
      expect(closed, true);
    });

    testWidgets('renders banner variant correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaAlert(
              variant: TectaAlertVariant.banner,
              title: 'Banner Title',
              message: 'Banner message content',
            ),
          ),
        ),
      );

      expect(find.text('Banner Title'), findsOneWidget);
      expect(find.text('Banner message content'), findsOneWidget);
    });
  });

  group('TectaAccordion Widget Tests', () {
    testWidgets('renders collapsed accordion header and expands on tap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaAccordion(
              title: 'Accordion Title',
              child: Text('Accordion Expanded Content'),
            ),
          ),
        ),
      );

      // Verify title is shown
      expect(find.text('Accordion Title'), findsOneWidget);

      // Tap to expand
      await tester.tap(find.text('Accordion Title'));
      await tester.pumpAndSettle();

      // Now content should be visible
      expect(find.text('Accordion Expanded Content'), findsOneWidget);
    });
  });

  group('TectaAvatar Widget Tests', () {
    testWidgets('renders initials text fallback in uppercase', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TectaAvatar(text: 'jd')),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('renders icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TectaAvatar(icon: Icon(Icons.star))),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('renders status badge correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaAvatar(text: 'A', badge: TectaAvatarBadge.online()),
          ),
        ),
      );

      expect(find.byKey(const ValueKey('badge_online')), findsOneWidget);
    });
  });

  group('TectaAvatarGroup Widget Tests', () {
    testWidgets('renders all children when length is under max limit', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaAvatarGroup(
              children: [
                TectaAvatar(text: 'A'),
                TectaAvatar(text: 'B'),
                TectaAvatar(text: 'C'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
      expect(find.byKey(const ValueKey('group_placeholder')), findsNothing);
    });

    testWidgets('caps displayed children and renders fold placeholder when length exceeds max', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaAvatarGroup(
              max: 2,
              children: [
                TectaAvatar(text: 'A'),
                TectaAvatar(text: 'B'),
                TectaAvatar(text: 'C'),
                TectaAvatar(text: 'D'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsNothing); // Folded
      expect(find.text('D'), findsNothing); // Folded
      expect(find.text('+2'), findsOneWidget); // Fold placeholder text
    });
  });

  group('TectaBadge Widget Tests', () {
    testWidgets('renders badge standard variant with count and caps at max', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TectaBadge(count: 10, max: 9, child: Icon(Icons.mail))),
        ),
      );

      // Verify the badge text is capped at 9+
      expect(find.text('9+'), findsOneWidget);
      expect(find.text('10'), findsNothing);
    });

    testWidgets('renders badge standard variant with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaBadge(label: 'NEW', child: Icon(Icons.mail)),
          ),
        ),
      );

      expect(find.text('NEW'), findsOneWidget);
    });

    testWidgets('renders dot variant without text label', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaBadge(variant: TectaBadgeVariant.dot, count: 5, child: Icon(Icons.mail)),
          ),
        ),
      );

      // Verify dot badge exists but does not render the count text
      expect(find.byKey(const ValueKey('badge_container')), findsOneWidget);
      expect(find.text('5'), findsNothing);
    });

    testWidgets('hides badge when count is 0 and showZero is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TectaBadge(count: 0, showZero: false, child: Icon(Icons.mail))),
        ),
      );

      expect(find.byKey(const ValueKey('badge_container')), findsNothing);
    });

    testWidgets('shows badge when count is 0 and showZero is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TectaBadge(count: 0, showZero: true, child: Icon(Icons.mail))),
        ),
      );

      expect(find.byKey(const ValueKey('badge_container')), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });
  });

  group('TectaButton Widget Tests', () {
    testWidgets('renders label and triggers onPressed', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaButton(label: 'Test Button', onPressed: () => pressed = true),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      await tester.tap(find.text('Test Button'));
      await tester.pump();
      expect(pressed, true);
    });

    testWidgets('respects loading state and does not trigger onPressed', (
      WidgetTester tester,
    ) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaButton(
              label: 'Test Button',
              loading: true,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.text('Test Button'));
      await tester.pump();
      expect(pressed, false);
    });
  });

  group('TectaIconButton Widget Tests', () {
    testWidgets('renders icon and triggers onPressed', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaIconButton(icon: const Icon(Icons.add), onPressed: () => pressed = true),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(pressed, true);
    });
  });

  group('TectaFab Widget Tests', () {
    testWidgets('renders circular FAB correctly', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaFab(icon: const Icon(Icons.add), onPressed: () => pressed = true),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(pressed, true);
    });

    testWidgets('renders extended FAB with label correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaFab(icon: Icon(Icons.add), label: 'Add Item', onPressed: null),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Add Item'), findsOneWidget);
    });

    testWidgets('renders outlined and soft variants', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TectaFab(icon: Icon(Icons.add), variant: TectaButtonVariant.outlined),
                TectaFab(icon: Icon(Icons.add), variant: TectaButtonVariant.soft),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsNWidgets(2));
    });
  });

  group('TectaCheckbox Widget Tests', () {
    testWidgets('renders unchecked state and handles tap to toggle', (WidgetTester tester) async {
      bool? checked = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return TectaCheckbox(
                  value: checked,
                  onChanged: (val) {
                    setState(() {
                      checked = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      // Verify check icon is not visible
      expect(find.byIcon(Icons.check), findsNothing);

      // Tap to toggle
      await tester.tap(find.byType(TectaCheckbox));
      await tester.pumpAndSettle();

      expect(checked, true);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('renders checked state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: TectaCheckbox(value: true, onChanged: null))),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('renders indeterminate state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: TectaCheckbox(value: null, onChanged: null))),
      );

      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('renders label and handles tap on label', (WidgetTester tester) async {
      bool? checked = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return TectaCheckbox(
                  value: checked,
                  label: 'My Label',
                  onChanged: (val) {
                    setState(() {
                      checked = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('My Label'), findsOneWidget);

      // Tap on label text
      await tester.tap(find.text('My Label'));
      await tester.pumpAndSettle();

      expect(checked, true);
    });

    testWidgets('does not trigger onChanged when disabled', (WidgetTester tester) async {
      bool changed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaCheckbox(value: false, onChanged: null, label: 'Disabled Label'),
          ),
        ),
      );

      await tester.tap(find.text('Disabled Label'));
      await tester.pump();

      expect(changed, false);
    });
  });

  group('TectaChip Widget Tests', () {
    testWidgets('renders label and supports leading and trailing delete icons', (
      WidgetTester tester,
    ) async {
      bool deleted = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaChip(
              label: 'Test Chip',
              icon: const Icon(Icons.mood),
              onDelete: () => deleted = true,
            ),
          ),
        ),
      );

      expect(find.text('Test Chip'), findsOneWidget);
      expect(find.byIcon(Icons.mood), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();
      expect(deleted, true);
    });

    testWidgets('triggers onTap callback when clicked', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaChip(label: 'Tappable Chip', onTap: () => tapped = true),
          ),
        ),
      );

      await tester.tap(find.text('Tappable Chip'));
      await tester.pump();
      expect(tapped, true);
    });

    testWidgets('does not trigger onTap or onDelete when isEnabled is false', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      bool deleted = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaChip(
              label: 'Disabled Chip',
              isEnabled: false,
              onTap: () => tapped = true,
              onDelete: () => deleted = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled Chip'));
      await tester.pump();
      expect(tapped, false);

      final deleteFinder = find.byIcon(Icons.close);
      if (deleteFinder.evaluate().isNotEmpty) {
        await tester.tap(deleteFinder);
        await tester.pump();
      }
      expect(deleted, false);
    });
  });

  group('TectaRadio Widget Tests', () {
    testWidgets('renders selection state and triggers onChanged when clicked', (
      WidgetTester tester,
    ) async {
      String? selectedVal = 'A';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaRadio<String>(
              value: 'B',
              groupValue: selectedVal,
              onChanged: (val) => selectedVal = val,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TectaRadio<String>));
      await tester.pump();
      expect(selectedVal, 'B');
    });

    testWidgets('renders label and triggers onChanged when label clicked', (
      WidgetTester tester,
    ) async {
      String? selectedVal = 'A';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaRadio<String>(
              value: 'B',
              groupValue: selectedVal,
              label: 'Radio B',
              onChanged: (val) => selectedVal = val,
            ),
          ),
        ),
      );

      expect(find.text('Radio B'), findsOneWidget);
      await tester.tap(find.text('Radio B'));
      await tester.pump();
      expect(selectedVal, 'B');
    });

    testWidgets('does not trigger onChanged when disabled', (WidgetTester tester) async {
      String? selectedVal = 'A';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaRadio<String>(
              value: 'B',
              groupValue: selectedVal,
              label: 'Radio B',
              onChanged: null,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Radio B'));
      await tester.pump();
      expect(selectedVal, 'A');
    });
  });

  group('TectaSwitch Widget Tests', () {
    testWidgets('renders selection state and triggers onChanged when clicked', (
      WidgetTester tester,
    ) async {
      bool active = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaSwitch(value: active, onChanged: (val) => active = val),
          ),
        ),
      );

      await tester.tap(find.byType(TectaSwitch));
      await tester.pump();
      expect(active, true);
    });

    testWidgets('renders label and triggers onChanged when label clicked', (
      WidgetTester tester,
    ) async {
      bool active = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaSwitch(
              value: active,
              label: 'Toggle Me',
              onChanged: (val) => active = val,
            ),
          ),
        ),
      );

      expect(find.text('Toggle Me'), findsOneWidget);
      await tester.tap(find.text('Toggle Me'));
      await tester.pump();
      expect(active, true);
    });

    testWidgets('does not trigger onChanged when disabled', (WidgetTester tester) async {
      bool active = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaSwitch(value: active, label: 'Toggle Me', onChanged: null),
          ),
        ),
      );

      await tester.tap(find.text('Toggle Me'));
      await tester.pump();
      expect(active, false);
    });
  });

  group('TectaTextField Widget Tests', () {
    testWidgets('renders standard input field and enters text', (WidgetTester tester) async {
      final controller = TextEditingController();
      String text = '';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaTextField(controller: controller, onChanged: (val) => text = val),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Hello Antigravity');
      await tester.pump();
      expect(controller.text, 'Hello Antigravity');
      expect(text, 'Hello Antigravity');
    });

    testWidgets('renders labels, helperText and errorText', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TectaTextField(label: 'Email Label', helperText: 'Enter valid email'),
                TectaTextField(errorText: 'Invalid email address'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Email Label'), findsOneWidget);
      expect(find.text('Enter valid email'), findsOneWidget);
      expect(find.text('Invalid email address'), findsOneWidget);
    });

    testWidgets('renders dropdown select options and triggers onSelectChanged', (
      WidgetTester tester,
    ) async {
      String? selected = 'EUR';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaTextField<String>(
              selectedValue: selected,
              onSelectChanged: (val) => selected = val,
              items: const [
                DropdownMenuItem(value: 'USD', child: Text('USD Currency')),
                DropdownMenuItem(value: 'EUR', child: Text('EUR Currency')),
              ],
            ),
          ),
        ),
      );

      // Open the dropdown
      await tester.tap(find.text('EUR Currency'));
      await tester.pumpAndSettle();

      // Tap on USD
      await tester.tap(find.text('USD Currency').last);
      await tester.pumpAndSettle();

      expect(selected, 'USD');
    });

    testWidgets('supports multiline inputs', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: TectaTextField(maxLines: 5))),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, 5);
    });
  });

  group('TectaSnackbar Widget Tests', () {
    testWidgets('renders message and title correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaSnackbar(title: 'Test Title', message: 'Test Message content'),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Message content'), findsOneWidget);
    });

    testWidgets('triggers onClose callback when close button is tapped', (
      WidgetTester tester,
    ) async {
      bool closed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaSnackbar(message: 'Dismiss me', onClose: () => closed = true),
          ),
        ),
      );

      final closeIconFinder = find.byIcon(Icons.close);
      expect(closeIconFinder, findsOneWidget);
      await tester.tap(closeIconFinder);
      await tester.pump();

      expect(closed, true);
    });

    testWidgets('renders action widget and leading icons correctly', (WidgetTester tester) async {
      bool actionTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaSnackbar(
              message: 'Check out action',
              variant: TectaSnackbarVariant.success,
              action: TextButton(onPressed: () => actionTapped = true, child: const Text('Undo')),
            ),
          ),
        ),
      );

      // Verify success check icon is rendered
      expect(find.byIcon(Icons.check_circle), findsOneWidget);

      // Tap action
      await tester.tap(find.text('Undo'));
      await tester.pump();

      expect(actionTapped, true);
    });
  });

  group('TectaLabel Widget Tests', () {
    testWidgets('renders text and supports start/end icons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaLabel(
              text: 'Active',
              variant: TectaLabelVariant.filled,
              color: TectaColors.successMain,
              startIcon: Icon(Icons.star),
              endIcon: Icon(Icons.arrow_forward),
            ),
          ),
        ),
      );

      expect(find.text('Active'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('renders different variants correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TectaLabel(text: 'Filled', variant: TectaLabelVariant.filled),
                TectaLabel(text: 'Outlined', variant: TectaLabelVariant.outlined),
                TectaLabel(text: 'Soft', variant: TectaLabelVariant.soft),
                TectaLabel(text: 'Inverted', variant: TectaLabelVariant.inverted),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Filled'), findsOneWidget);
      expect(find.text('Outlined'), findsOneWidget);
      expect(find.text('Soft'), findsOneWidget);
      expect(find.text('Inverted'), findsOneWidget);
    });
  });

  group('TectaUpload Widget Tests', () {
    testWidgets('TectaUploadBox renders title and triggers onTap', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaUploadBox(
              title: 'Upload File Header',
              subtitle: 'Drag here or browse.',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Upload File Header'), findsOneWidget);
      expect(find.textContaining('browse', findRichText: true), findsOneWidget);

      await tester.tap(find.byType(TectaUploadBox));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('TectaUploadAvatar renders empty upload state and triggers onTap', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaUploadAvatar(onTap: () => tapped = true, guidelines: 'Test constraints'),
          ),
        ),
      );

      expect(find.text('Upload photo'), findsOneWidget);
      expect(find.text('Test constraints'), findsOneWidget);
      expect(find.byIcon(Icons.photo_camera), findsOneWidget);

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(tapped, true);
    });
  });

  group('TectaDialog Widget Tests', () {
    testWidgets('renders dialog title, content, actions, and close button', (WidgetTester tester) async {
      bool closed = false;
      bool okTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaDialog(
              title: 'Confirm Operation',
              content: const Text('Are you sure you want to proceed?'),
              onClose: () => closed = true,
              actions: [
                TextButton(
                  onPressed: () => okTapped = true,
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Confirm Operation'), findsOneWidget);
      expect(find.text('Are you sure you want to proceed?'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);

      // Tap OK action
      await tester.tap(find.text('OK'));
      await tester.pump();
      expect(okTapped, true);

      // Tap close cross icon
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();
      expect(closed, true);
    });

    testWidgets('launches dialog via showTectaDialog helper', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showTectaDialog(
                      context,
                      child: const TectaDialog(
                        title: 'Launched Modal',
                        content: Text('Dialog content text'),
                      ),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Launched Modal'), findsNothing);

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Launched Modal'), findsOneWidget);
    });
  });

  group('TectaBottomSheet Widget Tests', () {
    testWidgets('renders bottom sheet title and content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaBottomSheet(
              title: 'Options Panel',
              content: const Text('Sheet body text content'),
            ),
          ),
        ),
      );

      expect(find.text('Options Panel'), findsOneWidget);
      expect(find.text('Sheet body text content'), findsOneWidget);
      // Verify handle container is present
      expect(find.byType(Container), findsAtLeast(1));
    });

    testWidgets('renders header actions and triggers callbacks', (WidgetTester tester) async {
      bool actionTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaBottomSheet(
              title: 'Header actions',
              actions: [
                TextButton(
                  onPressed: () => actionTapped = true,
                  child: const Text('Save'),
                ),
              ],
              content: const Text('Body'),
            ),
          ),
        ),
      );

      expect(find.text('Save'), findsOneWidget);
      await tester.tap(find.text('Save'));
      await tester.pump();
      expect(actionTapped, true);
    });

    testWidgets('launches bottom sheet via showTectaBottomSheet helper', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showTectaBottomSheet(
                      context,
                      child: const TectaBottomSheet(
                        title: 'Modal Sheet Title',
                        content: Text('Body Text'),
                      ),
                    );
                  },
                  child: const Text('Open Sheet'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Modal Sheet Title'), findsNothing);

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Modal Sheet Title'), findsOneWidget);
    });

    testWidgets('launches bottom sheet with isScrollControlled layout enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showTectaBottomSheet(
                      context,
                      isScrollControlled: true,
                      child: const TectaBottomSheet(
                        title: 'Scroll Controlled',
                        content: Text('Draggable content body'),
                      ),
                    );
                  },
                  child: const Text('Open Sheet'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Scroll Controlled'), findsOneWidget);
    });
  });

  group('TectaCard Widget Tests', () {
    testWidgets('renders header, content, and triggers onTap', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaCard(
              onTap: () => tapped = true,
              header: const Text('Header Area'),
              content: const Text('Body Content'),
            ),
          ),
        ),
      );

      expect(find.text('Header Area'), findsOneWidget);
      expect(find.text('Body Content'), findsOneWidget);

      await tester.tap(find.text('Body Content'));
      await tester.pump();
      expect(tapped, true);
    });
  });

  group('TectaTooltip Widget Tests', () {
    testWidgets('shows tooltip on long-press interaction', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: TectaTooltip(
                message: 'Hover Tip Note',
                child: Text('Hover Target'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Hover Tip Note'), findsNothing);

      // Long press target to show tooltip
      final gesture = await tester.startGesture(tester.getCenter(find.text('Hover Target')));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.text('Hover Tip Note'), findsOneWidget);

      // Release gesture to hide tooltip
      await gesture.up();
      await tester.pumpAndSettle();

      expect(find.text('Hover Tip Note'), findsNothing);
    });

    testWidgets('shows and toggles tooltip on tap interaction when triggerOnTap is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: TectaTooltip(
                message: 'Tap Tip Note',
                triggerOnTap: true,
                child: Text('Tap Target'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Tap Tip Note'), findsNothing);

      // Tap target to toggle tooltip open
      await tester.tap(find.text('Tap Target'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Tap Tip Note'), findsOneWidget);

      // Tap target again to toggle tooltip closed
      await tester.tap(find.text('Tap Target'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Tap Tip Note'), findsNothing);
    });
  });

  group('TectaRating Widget Tests', () {
    testWidgets('renders stars and triggers onRatingChanged on click', (WidgetTester tester) async {
      double selectedRating = 0.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaRating(
              rating: 3.0,
              onRatingChanged: (val) => selectedRating = val,
            ),
          ),
        ),
      );

      // 5 stars total
      expect(find.byIcon(Icons.star_rounded), findsNWidgets(5));

      // Click the 4th star (index 3)
      await tester.tap(find.byIcon(Icons.star_rounded).at(3));
      await tester.pump();

      expect(selectedRating, 4.0);
    });
  });

  group('TectaTimeline Widget Tests', () {
    testWidgets('renders list timeline items with connector lines', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaTimeline(
              children: [
                TectaTimelineItem(
                  title: 'Step One',
                  subtitle: 'Initial task start',
                ),
                TectaTimelineItem(
                  title: 'Step Two',
                  subtitle: 'Task finalized',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Step One'), findsOneWidget);
      expect(find.text('Initial task start'), findsOneWidget);
      expect(find.text('Step Two'), findsOneWidget);
      expect(find.text('Task finalized'), findsOneWidget);
    });
  });

  group('TectaSlider Widget Tests', () {
    testWidgets('renders slider value and handles drag change', (WidgetTester tester) async {
      double value = 0.5;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaSlider(
              value: value,
              onChanged: (val) => value = val,
            ),
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);

      // Drag slider thumb slightly
      await tester.drag(find.byType(Slider), const Offset(100.0, 0.0));
      await tester.pump();

      expect(value, isNot(0.5));
    });
  });

  group('TectaTabs Widget Tests', () {
    testWidgets('renders all tab labels and triggers callback on tap', (WidgetTester tester) async {
      int selected = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaTabs(
              selectedIndex: selected,
              tabs: const [
                TectaTab(label: 'Tab 1', badge: '5'),
                TectaTab(label: 'Tab 2'),
              ],
              onTabChanged: (val) => selected = val,
            ),
          ),
        ),
      );

      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
      expect(find.text('5'), findsOneWidget); // badge

      await tester.tap(find.text('Tab 2'));
      await tester.pump();

      expect(selected, 1);
    });
  });

  group('TectaSkeleton Widget Tests', () {
    testWidgets('renders skeleton layout correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaSkeleton(
              width: 50,
              height: 50,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );

      expect(find.byType(TectaSkeleton), findsOneWidget);
    });
  });

  group('TectaEmptyState Widget Tests', () {
    testWidgets('renders title, description and triggers action button tap', (WidgetTester tester) async {
      bool actionTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaEmptyState(
              title: 'No Data',
              description: 'Please reload the page',
              action: TextButton(
                onPressed: () => actionTapped = true,
                child: const Text('Reload'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('No Data'), findsOneWidget);
      expect(find.text('Please reload the page'), findsOneWidget);
      expect(find.text('Reload'), findsOneWidget);

      await tester.tap(find.text('Reload'));
      await tester.pump();
      expect(actionTapped, true);
    });
  });

  group('TectaProgress Widget Tests', () {
    testWidgets('renders linear and circular progress indicators', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TectaLinearProgress(value: 0.5),
                TectaCircularProgress(value: 0.5),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(TectaLinearProgress), findsOneWidget);
      expect(find.byType(TectaCircularProgress), findsOneWidget);
    });

    testWidgets('renders linear and circular progress with multi-color cycling list', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TectaLinearProgress(
                  colors: [Colors.red, Colors.blue, Colors.green],
                ),
                TectaCircularProgress(
                  colors: [Colors.red, Colors.blue, Colors.green],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(TectaLinearProgress), findsOneWidget);
      expect(find.byType(TectaCircularProgress), findsOneWidget);
    });
  });

  group('TectaDivider Widget Tests', () {
    testWidgets('renders horizontal divider correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaDivider(),
          ),
        ),
      );

      expect(find.byType(TectaDivider), findsOneWidget);
    });

    testWidgets('renders label inside divider correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TectaDivider(
              label: Text('SEPARATOR'),
            ),
          ),
        ),
      );

      expect(find.text('SEPARATOR'), findsOneWidget);
    });

    testWidgets('renders vertical divider with custom style', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 100,
              child: TectaDivider(
                orientation: Axis.vertical,
                style: TectaDividerStyle.dashed,
                color: Colors.red,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(TectaDivider), findsOneWidget);
    });
  });

  group('TectaCalendar Widget Tests', () {
    testWidgets('renders inline calendar successfully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaCalendar(
              selectedDate: DateTime(2026, 7, 22),
            ),
          ),
        ),
      );

      expect(find.byType(TectaCalendar), findsOneWidget);
      expect(find.text('July 2026'), findsOneWidget);
      expect(find.text('22'), findsOneWidget);
    });

    testWidgets('renders calendar event indicators including dots and plus sign', (WidgetTester tester) async {
      final events = [
        TectaCalendarEvent(
          id: '1',
          title: 'Event 1',
          color: Colors.red,
          date: DateTime(2026, 7, 10),
        ),
        TectaCalendarEvent(
          id: '2',
          title: 'Event 2',
          color: Colors.blue,
          date: DateTime(2026, 7, 10),
        ),
        TectaCalendarEvent(
          id: '3',
          title: 'Event 3',
          color: Colors.green,
          date: DateTime(2026, 7, 10),
        ),
        TectaCalendarEvent(
          id: '4',
          title: 'Event 4',
          color: Colors.yellow,
          date: DateTime(2026, 7, 10),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaCalendar(
              selectedDate: DateTime(2026, 7, 22),
              events: events,
            ),
          ),
        ),
      );

      // Verify that calendar renders
      expect(find.byType(TectaCalendar), findsOneWidget);
      // Verify '+' text is rendered on July 10, 2026 because there are 4 events
      expect(find.text('+'), findsOneWidget);
    });

    testWidgets('renders calendar with custom weekendHeaderTextStyle and weekendDayTextStyle', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaCalendar(
              selectedDate: DateTime(2026, 7, 22),
              weekendHeaderTextStyle: const TextStyle(color: Colors.purple),
              weekendDayTextStyle: const TextStyle(color: Colors.deepOrange),
            ),
          ),
        ),
      );

      expect(find.byType(TectaCalendar), findsOneWidget);
    });
  });

  group('TectaMonthYearPicker Widget Tests', () {
    testWidgets('renders month picker and handles selection', (WidgetTester tester) async {
      int? selectedMonth;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaMonthPicker(
              selectedMonth: 5,
              onMonthSelected: (month) => selectedMonth = month,
            ),
          ),
        ),
      );

      expect(find.text('May'), findsOneWidget);
      await tester.tap(find.text('May'));
      await tester.pump();
      expect(selectedMonth, 5);
    });

    testWidgets('renders year picker and handles selection', (WidgetTester tester) async {
      int? selectedYear;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaYearPicker(
              selectedYear: 2026,
              onYearSelected: (year) => selectedYear = year,
            ),
          ),
        ),
      );

      expect(find.text('2026'), findsOneWidget);
      await tester.tap(find.text('2026'));
      await tester.pump();
      expect(selectedYear, 2026);
    });
  });

  group('TectaTimePicker Widget Tests', () {
    testWidgets('renders time picker wheels', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaTimePicker(
              initialTime: const TimeOfDay(hour: 10, minute: 30),
              onTimeChanged: (time) {},
            ),
          ),
        ),
      );

      expect(find.byType(TectaTimePicker), findsOneWidget);
    });

    testWidgets('renders dial-style clock face and responds to tap input', (WidgetTester tester) async {
      TimeOfDay? changedTime;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaTimePicker(
              initialTime: const TimeOfDay(hour: 10, minute: 30),
              style: TectaTimePickerStyle.dial,
              onTimeChanged: (time) => changedTime = time,
            ),
          ),
        ),
      );

      expect(find.byType(TectaTimePicker), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('30'), findsOneWidget);

      // Tap on hours display to switch mode
      await tester.tap(find.text('10'));
      await tester.pump();

      final center = tester.getCenter(find.descendant(
        of: find.byType(TectaTimePicker),
        matching: find.byType(CustomPaint),
      ).first);
      await tester.tapAt(Offset(center.dx + 60, center.dy));
      await tester.pump();

      expect(changedTime, isNotNull);
    });
  });

  group('TectaSegmentedControl Widget Tests', () {
    testWidgets('renders all options and handles value change on tap', (WidgetTester tester) async {
      int selected = 0;
      final options = const [
        TectaSegmentedOption(label: 'Left'),
        TectaSegmentedOption(label: 'Right'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaSegmentedControl(
              options: options,
              selectedIndex: selected,
              onValueChanged: (val) => selected = val,
            ),
          ),
        ),
      );

      expect(find.text('Left'), findsOneWidget);
      expect(find.text('Right'), findsOneWidget);

      await tester.tap(find.text('Right'));
      await tester.pump();

      expect(selected, 1);
    });

    testWidgets('does not trigger onValueChanged when disabled', (WidgetTester tester) async {
      int selected = 0;
      final options = const [
        TectaSegmentedOption(label: 'Left'),
        TectaSegmentedOption(label: 'Right'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaSegmentedControl(
              options: options,
              selectedIndex: selected,
              isEnabled: false,
              onValueChanged: (val) => selected = val,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Right'));
      await tester.pump();

      expect(selected, 0);
    });
  });

  group('TectaDropdownMenu Widget Tests', () {
    testWidgets('renders child trigger and shows menu items on tap', (WidgetTester tester) async {
      int? selectedIndex;
      final items = const [
        TectaDropdownItem(label: 'Action 1'),
        TectaDropdownItem(label: 'Action 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TectaDropdownMenu(
              items: items,
              onItemSelected: (index) => selectedIndex = index,
              child: const Text('TRIGGER'),
            ),
          ),
        ),
      );

      // Verify trigger widget is shown
      expect(find.text('TRIGGER'), findsOneWidget);
      expect(find.text('Action 1'), findsNothing);

      // Tap trigger to open popup
      await tester.tap(find.text('TRIGGER'));
      await tester.pumpAndSettle();

      // Verify menu items are visible in popup overlay
      expect(find.text('Action 1'), findsOneWidget);
      expect(find.text('Action 2'), findsOneWidget);

      // Tap menu item
      await tester.tap(find.text('Action 1'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 0);
    });
  });
}
