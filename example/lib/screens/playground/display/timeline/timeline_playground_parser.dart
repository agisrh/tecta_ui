import 'package:tecta_ui/tecta_ui.dart';

class TimelinePlaygroundParser {
  static TectaTimelineIndicatorType parseIndicatorType(
      String code, TectaTimelineIndicatorType defaultType) {
    if (code.contains('TectaTimelineIndicatorType.outlined')) {
      return TectaTimelineIndicatorType.outlined;
    }
    if (code.contains('TectaTimelineIndicatorType.soft')) return TectaTimelineIndicatorType.soft;
    return TectaTimelineIndicatorType.solid;
  }

  static TectaTimelineLineType parseLineType(String code, TectaTimelineLineType defaultType) {
    if (code.contains('TectaTimelineLineType.dashed')) return TectaTimelineLineType.dashed;
    return TectaTimelineLineType.solid;
  }
}
