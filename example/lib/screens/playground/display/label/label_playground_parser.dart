import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class LabelPlaygroundParser {
  static String parseText(String code, String defaultText) {
    final match = RegExp("(text|label):\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 2) {
      return match.group(2) ?? defaultText;
    }
    return defaultText;
  }

  static TectaLabelVariant parseVariant(String code, TectaLabelVariant defaultVariant) {
    if (code.contains('TectaLabelVariant.filled')) return TectaLabelVariant.filled;
    if (code.contains('TectaLabelVariant.outlined')) return TectaLabelVariant.outlined;
    if (code.contains('TectaLabelVariant.inverted')) return TectaLabelVariant.inverted;
    return TectaLabelVariant.soft;
  }

  static Color parseColor(String code, Color defaultColor) {
    if (code.contains('TectaColors.successMain')) return TectaColors.successMain;
    if (code.contains('TectaColors.warningMain')) return TectaColors.warningMain;
    if (code.contains('TectaColors.errorMain')) return TectaColors.errorMain;
    if (code.contains('TectaColors.infoMain')) return TectaColors.infoMain;
    return defaultColor;
  }
}
