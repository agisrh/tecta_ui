import 'package:tecta_ui/tecta_ui.dart';

class TooltipPlaygroundParser {
  static String parseMessage(String code, String defaultMessage) {
    final match = RegExp("message:\\s*['\"](.*?)['\"]").firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? defaultMessage;
    }
    return defaultMessage;
  }

  static TectaTooltipPosition parsePosition(String code, TectaTooltipPosition defaultPosition) {
    if (code.contains('TectaTooltipPosition.bottom')) return TectaTooltipPosition.bottom;
    if (code.contains('TectaTooltipPosition.left')) return TectaTooltipPosition.left;
    if (code.contains('TectaTooltipPosition.right')) return TectaTooltipPosition.right;
    return TectaTooltipPosition.top;
  }
}
