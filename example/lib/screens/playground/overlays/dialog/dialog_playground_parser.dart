class DialogPlaygroundParser {
  static String parseTitle(String code, String defaultTitle) {
    final match = RegExp("title:\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultTitle;
    }
    return defaultTitle;
  }

  static String parseContent(String code, String defaultContent) {
    final match = RegExp("content:\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultContent;
    }
    return defaultContent;
  }
}
