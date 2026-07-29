class AccordionPlaygroundParser {
  static String parseTitle(String code, String defaultTitle) {
    final match = RegExp("title:\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultTitle;
    }
    return defaultTitle;
  }

  static String parseSubtitle(String code, String defaultSubtitle) {
    final match = RegExp("subtitle:\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultSubtitle;
    }
    return defaultSubtitle;
  }
}
