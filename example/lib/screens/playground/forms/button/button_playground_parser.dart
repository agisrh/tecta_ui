import 'package:tecta_ui/tecta_ui.dart';

class ButtonPlaygroundParser {
  static TectaButtonVariant parseVariant(String code, TectaButtonVariant defaultValue) {
    final match = RegExp(r'TectaButtonVariant\.([a-zA-Z]+)').firstMatch(code);
    if (match != null) {
      final val = match.group(1);
      return TectaButtonVariant.values.firstWhere(
        (e) => e.toString().split('.').last == val,
        orElse: () => defaultValue,
      );
    }
    return defaultValue;
  }

  static TectaButtonSize parseSize(String code, TectaButtonSize defaultValue) {
    final match = RegExp(r'TectaButtonSize\.([a-zA-Z]+)').firstMatch(code);
    if (match != null) {
      final val = match.group(1);
      return TectaButtonSize.values.firstWhere(
        (e) => e.toString().split('.').last == val,
        orElse: () => defaultValue,
      );
    }
    return defaultValue;
  }

  static bool parseLoading(String code, bool defaultValue) {
    final match = RegExp(r'loading:\s*(true|false)').firstMatch(code);
    if (match != null) {
      return match.group(1) == 'true';
    }
    return defaultValue;
  }

  static bool parseHasIcon(String code, bool defaultValue) {
    final match = RegExp(r'hasIcon:\s*(true|false)').firstMatch(code);
    if (match != null) {
      return match.group(1) == 'true';
    }
    return defaultValue;
  }

  static String parseLabel(String code, String defaultValue) {
    final match = RegExp(r"label:\s*[''](.*?)['']").firstMatch(code);
    if (match != null) {
      return match.group(1) ?? defaultValue;
    }
    return defaultValue;
  }
}
