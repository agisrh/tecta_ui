class SliderPlaygroundParser {
  static double parseValue(String code, double defaultValue) {
    final match = RegExp(r'value:\s*(\d+\.?\d*)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return double.tryParse(match.group(1) ?? '') ?? defaultValue;
    }
    return defaultValue;
  }

  static double parseMin(String code, double defaultMin) {
    final match = RegExp(r'min:\s*(\d+\.?\d*)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return double.tryParse(match.group(1) ?? '') ?? defaultMin;
    }
    return defaultMin;
  }

  static double parseMax(String code, double defaultMax) {
    final match = RegExp(r'max:\s*(\d+\.?\d*)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return double.tryParse(match.group(1) ?? '') ?? defaultMax;
    }
    return defaultMax;
  }
}
