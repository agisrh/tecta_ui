import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TectaShowcaseApp());
}

/// Global notifier to manage theme mode state in the showcase application.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

class TectaShowcaseApp extends StatelessWidget {
  const TectaShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Tecta UI',
          debugShowCheckedModeBanner: false,
          theme: TectaTheme.lightTheme,
          themeMode: ThemeMode.light,
          home: const ShowcaseHomeScreen(),
        );
      },
    );
  }
}
