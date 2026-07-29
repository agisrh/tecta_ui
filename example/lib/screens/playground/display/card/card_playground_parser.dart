class CardPlaygroundParser {
  static double parsePadding(String code, double defaultValue) {
    final match = RegExp(r'padding:\s*const\s*EdgeInsets\.all\((\d+)\)').firstMatch(code);
    if (match != null) {
      return double.tryParse(match.group(1) ?? '') ?? defaultValue;
    }
    return defaultValue;
  }

  static bool parseHasDivider(String code) {
    return code.contains('Divider(');
  }

  static String parseTitle(String code, String defaultValue) {
    final match = RegExp(r"header:\s*Text\(\s*[''](.*?)['']").firstMatch(code);
    if (match != null) {
      return match.group(1) ?? defaultValue;
    }
    return defaultValue;
  }

  static String parseContent(String code, String defaultValue) {
    final match = RegExp(r"content:\s*Text\(\s*[''](.*?)['']", dotAll: true).firstMatch(code);
    if (match != null) {
      return match.group(1)?.replaceAll('\n', ' ').trim() ?? defaultValue;
    }
    return defaultValue;
  }

  static String parseButtonLabel(String code, String defaultValue) {
    final match = RegExp(r"label:\s*[''](.*?)['']").firstMatch(code);
    if (match != null) {
      return match.group(1) ?? defaultValue;
    }
    return defaultValue;
  }
}
