import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class IconsPlaygroundParser {
  static IconData parseIcon(String code, IconData defaultIcon) {
    if (code.contains('SolarLinearIcons.star')) return SolarLinearIcons.star;
    if (code.contains('SolarLinearIcons.home')) return SolarLinearIcons.home;
    if (code.contains('SolarLinearIcons.settings')) return SolarLinearIcons.settings;
    if (code.contains('SolarLinearIcons.user')) return SolarLinearIcons.user;
    if (code.contains('SolarLinearIcons.bell')) return SolarLinearIcons.bell;
    if (code.contains('SolarLinearIcons.calendar')) return SolarLinearIcons.calendar;
    if (code.contains('SolarLinearIcons.infoCircle')) return SolarLinearIcons.infoCircle;
    if (code.contains('SolarLinearIcons.checkCircle')) return SolarLinearIcons.checkCircle;
    if (code.contains('SolarLinearIcons.letter')) return SolarLinearIcons.letter;
    return defaultIcon;
  }

  static double parseSize(String code, double defaultSize) {
    final match = RegExp(r'size:\s*(\d+\.?\d*)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return double.tryParse(match.group(1) ?? '') ?? defaultSize;
    }
    return defaultSize;
  }

  static String parseIconName(String code, String defaultName) {
    final match = RegExp(r'(SolarLinearIcons\.[a-zA-Z0-9]+)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultName;
    }
    return defaultName;
  }

  static Color parseColor(String code, Color defaultColor) {
    if (code.contains('TectaColors.primaryMain')) return TectaColors.primaryMain;
    if (code.contains('TectaColors.secondaryMain')) return TectaColors.secondaryMain;
    if (code.contains('TectaColors.successMain')) return TectaColors.successMain;
    if (code.contains('TectaColors.errorMain')) return TectaColors.errorMain;
    return defaultColor;
  }
}
