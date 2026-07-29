class CheckboxPlaygroundParser {
  static String parseLabel(String code, String defaultLabel) {
    final match = RegExp("label:\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultLabel;
    }
    return defaultLabel;
  }

  static bool parseChecked(String code, bool defaultChecked) {
    if (code.contains('value: true')) return true;
    if (code.contains('value: false')) return false;
    return defaultChecked;
  }

  static bool parseDisabled(String code, bool defaultDisabled) {
    if (code.contains('onChanged: null')) return true;
    return defaultDisabled;
  }
}
