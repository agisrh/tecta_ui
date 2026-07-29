class TextFieldPlaygroundParser {
  static String parseLabel(String code, String defaultValue) {
    final match = RegExp(r"label:\s*[''](.*?)['']").firstMatch(code);
    if (match != null) {
      return match.group(1) ?? defaultValue;
    }
    return defaultValue;
  }

  static String parsePlaceholder(String code, String defaultValue) {
    final match = RegExp(r"placeholder:\s*[''](.*?)['']").firstMatch(code);
    if (match != null) {
      return match.group(1) ?? defaultValue;
    }
    return defaultValue;
  }

  static String parseHelperText(String code, String defaultValue) {
    final match = RegExp(r"helperText:\s*[''](.*?)['']").firstMatch(code);
    if (match != null) {
      return match.group(1) ?? defaultValue;
    }
    return defaultValue;
  }

  static String parseErrorText(String code, String defaultValue) {
    final match = RegExp(r"errorText:\s*[''](.*?)['']").firstMatch(code);
    if (match != null) {
      return match.group(1) ?? defaultValue;
    }
    return defaultValue;
  }
}
