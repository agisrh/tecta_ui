import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class ColorsPlaygroundParser {
  static double parseWidth(String code, double defaultValue) {
    final match = RegExp(r'width:\s*(\d+)').firstMatch(code);
    if (match != null) {
      return double.tryParse(match.group(1) ?? '') ?? defaultValue;
    }
    return defaultValue;
  }

  static double parseHeight(String code, double defaultValue) {
    final match = RegExp(r'height:\s*(\d+)').firstMatch(code);
    if (match != null) {
      return double.tryParse(match.group(1) ?? '') ?? defaultValue;
    }
    return defaultValue;
  }

  static double parseRadius(String code, double defaultValue) {
    final match = RegExp(r'BorderRadius\.circular\((\d+)\)').firstMatch(code);
    if (match != null) {
      return double.tryParse(match.group(1) ?? '') ?? defaultValue;
    }
    return defaultValue;
  }

  static String parseColorName(String code, String defaultValue) {
    final match = RegExp(r'TectaColors\.([a-zA-Z0-9]+)').firstMatch(code);
    if (match != null) {
      return match.group(1) ?? defaultValue;
    }
    return defaultValue;
  }

  static Color getColorFromName(String name) {
    switch (name) {
      case 'primaryLighter': return TectaColors.primaryLighter;
      case 'primaryLight': return TectaColors.primaryLight;
      case 'primaryMain': return TectaColors.primaryMain;
      case 'primaryDark': return TectaColors.primaryDark;
      case 'primaryDarker': return TectaColors.primaryDarker;
      case 'secondaryLighter': return TectaColors.secondaryLighter;
      case 'secondaryLight': return TectaColors.secondaryLight;
      case 'secondaryMain': return TectaColors.secondaryMain;
      case 'secondaryDark': return TectaColors.secondaryDark;
      case 'secondaryDarker': return TectaColors.secondaryDarker;
      case 'infoLighter': return TectaColors.infoLighter;
      case 'infoLight': return TectaColors.infoLight;
      case 'infoMain': return TectaColors.infoMain;
      case 'infoDark': return TectaColors.infoDark;
      case 'infoDarker': return TectaColors.infoDarker;
      case 'successLighter': return TectaColors.successLighter;
      case 'successLight': return TectaColors.successLight;
      case 'successMain': return TectaColors.successMain;
      case 'successDark': return TectaColors.successDark;
      case 'successDarker': return TectaColors.successDarker;
      case 'warningLighter': return TectaColors.warningLighter;
      case 'warningLight': return TectaColors.warningLight;
      case 'warningMain': return TectaColors.warningMain;
      case 'warningDark': return TectaColors.warningDark;
      case 'warningDarker': return TectaColors.warningDarker;
      case 'errorLighter': return TectaColors.errorLighter;
      case 'errorLight': return TectaColors.errorLight;
      case 'errorMain': return TectaColors.errorMain;
      case 'errorDark': return TectaColors.errorDark;
      case 'errorDarker': return TectaColors.errorDarker;
      default: return TectaColors.primaryMain;
    }
  }
}
