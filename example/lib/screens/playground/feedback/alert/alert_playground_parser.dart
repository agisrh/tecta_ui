import 'package:tecta_ui/tecta_ui.dart';

class AlertPlaygroundParser {
  static TectaAlertSeverity parseSeverity(String code, TectaAlertSeverity defaultValue) {
    final match = RegExp(r'TectaAlertSeverity\.([a-zA-Z]+)').firstMatch(code);
    if (match != null) {
      final val = match.group(1);
      return TectaAlertSeverity.values.firstWhere(
        (e) => e.toString().split('.').last == val,
        orElse: () => defaultValue,
      );
    }
    return defaultValue;
  }

  static TectaAlertVariant parseVariant(String code, TectaAlertVariant defaultValue) {
    final match = RegExp(r'TectaAlertVariant\.([a-zA-Z]+)').firstMatch(code);
    if (match != null) {
      final val = match.group(1);
      return TectaAlertVariant.values.firstWhere(
        (e) => e.toString().split('.').last == val,
        orElse: () => defaultValue,
      );
    }
    return defaultValue;
  }

  static String parseTitle(String code, String defaultValue) {
    final match = RegExp(r"title:\s*[''](.*?)['']").firstMatch(code);
    if (match != null) {
      return match.group(1) ?? defaultValue;
    }
    return defaultValue;
  }

  static bool parseIsClosable(String code, bool defaultValue) {
    final match = RegExp(r'isClosable:\s*(true|false)').firstMatch(code);
    if (match != null) {
      return match.group(1) == 'true';
    }
    return defaultValue;
  }

  static String parseMessage(String code, String defaultValue) {
    final match = RegExp(r"message:\s*[''](.*?)['']").firstMatch(code);
    if (match != null) {
      return match.group(1) ?? defaultValue;
    }
    return defaultValue;
  }
}
