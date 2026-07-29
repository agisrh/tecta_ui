import 'package:tecta_ui/tecta_ui.dart';

class SnackbarPlaygroundParser {
  static String parseMessage(String code, String defaultMessage) {
    final match = RegExp("message:\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultMessage;
    }
    return defaultMessage;
  }

  static TectaSnackbarVariant parseVariant(String code, TectaSnackbarVariant defaultVariant) {
    if (code.contains('TectaSnackbarVariant.success')) return TectaSnackbarVariant.success;
    if (code.contains('TectaSnackbarVariant.warning')) return TectaSnackbarVariant.warning;
    if (code.contains('TectaSnackbarVariant.error')) return TectaSnackbarVariant.error;
    if (code.contains('TectaSnackbarVariant.info')) return TectaSnackbarVariant.info;
    return defaultVariant;
  }
}
