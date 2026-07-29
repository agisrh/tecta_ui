class ProgressPlaygroundParser {
  static double? parseValue(String code, double? defaultValue) {
    if (code.contains('value: null')) return null;
    final match = RegExp(r'value:\s*(\d+\.?\d*)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return double.tryParse(match.group(1) ?? '') ?? defaultValue;
    }
    return defaultValue;
  }

  static String parseProgressType(String code, String defaultType) {
    if (code.contains('TectaCircularProgress')) return 'circular';
    return 'linear';
  }
}
