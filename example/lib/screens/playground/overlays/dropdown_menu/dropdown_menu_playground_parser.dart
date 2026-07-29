class DropdownMenuPlaygroundParser {
  static String parseTriggerLabel(String code, String defaultLabel) {
    final match = RegExp("label:\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultLabel;
    }
    return defaultLabel;
  }
}
