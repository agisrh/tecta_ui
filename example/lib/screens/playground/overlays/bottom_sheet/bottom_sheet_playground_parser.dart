class BottomSheetPlaygroundParser {
  static String parseTitle(String code, String defaultTitle) {
    final match = RegExp("title:\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultTitle;
    }
    return defaultTitle;
  }
}
