class PickerPlaygroundParser {
  static String parsePickerType(String code, String defaultType) {
    if (code.contains('showTectaDatePicker')) return 'date';
    if (code.contains('showTectaTimePicker')) return 'time';
    if (code.contains('showTectaMonthPicker')) return 'month';
    if (code.contains('showTectaYearPicker')) return 'year';
    return defaultType;
  }

  static String parseLabel(String code, String defaultLabel) {
    final match = RegExp("label:\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultLabel;
    }
    return defaultLabel;
  }
}
