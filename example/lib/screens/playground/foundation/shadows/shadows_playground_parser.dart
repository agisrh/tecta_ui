import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class ShadowsPlaygroundParser {
  static List<BoxShadow> parseShadow(String code, List<BoxShadow> defaultShadow) {
    if (code.contains('TectaShadows.z1')) return TectaShadows.z1;
    if (code.contains('TectaShadows.z4')) return TectaShadows.z4;
    if (code.contains('TectaShadows.z8')) return TectaShadows.z8;
    if (code.contains('TectaShadows.z12')) return TectaShadows.z12;
    if (code.contains('TectaShadows.z16')) return TectaShadows.z16;
    if (code.contains('TectaShadows.z20')) return TectaShadows.z20;
    if (code.contains('TectaShadows.z24')) return TectaShadows.z24;
    return defaultShadow;
  }

  static String parseShadowName(String code, String defaultName) {
    final match = RegExp(r'(TectaShadows\.[a-zA-Z0-9]+)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultName;
    }
    return defaultName;
  }
}
