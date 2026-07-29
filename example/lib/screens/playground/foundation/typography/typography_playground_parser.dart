import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class TypographyPlaygroundParser {
  static TextStyle parseStyle(String code, TextStyle defaultStyle) {
    if (code.contains('TectaTypography.h1')) return TectaTypography.h1;
    if (code.contains('TectaTypography.h2')) return TectaTypography.h2;
    if (code.contains('TectaTypography.h3')) return TectaTypography.h3;
    if (code.contains('TectaTypography.h4')) return TectaTypography.h4;
    if (code.contains('TectaTypography.h5')) return TectaTypography.h5;
    if (code.contains('TectaTypography.h6')) return TectaTypography.h6;
    if (code.contains('TectaTypography.subtitle1')) return TectaTypography.subtitle1;
    if (code.contains('TectaTypography.subtitle2')) return TectaTypography.subtitle2;
    if (code.contains('TectaTypography.body1')) return TectaTypography.body1;
    if (code.contains('TectaTypography.body2')) return TectaTypography.body2;
    if (code.contains('TectaTypography.caption')) return TectaTypography.caption;
    return defaultStyle;
  }

  static String parseText(String code, String defaultText) {
    final match = RegExp("text:\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultText;
    }
    return defaultText;
  }

  static String parseStyleName(String code, String defaultName) {
    final match = RegExp(r'(TectaTypography\.[a-zA-Z0-9]+)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultName;
    }
    return defaultName;
  }
}
