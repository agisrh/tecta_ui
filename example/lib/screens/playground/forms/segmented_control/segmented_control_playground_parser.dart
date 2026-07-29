class SegmentedControlPlaygroundParser {
  static int parseSelectedIndex(String code, int defaultIndex) {
    final match = RegExp(r'selectedIndex:\s*(\d+)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return int.tryParse(match.group(1) ?? '') ?? defaultIndex;
    }
    return defaultIndex;
  }
}
