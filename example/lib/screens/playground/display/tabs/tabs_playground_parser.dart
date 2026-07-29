import 'package:tecta_ui/tecta_ui.dart';

class TabsPlaygroundParser {
  static TectaTabsVariant parseVariant(String code, TectaTabsVariant defaultVariant) {
    if (code.contains('TectaTabsVariant.pill')) return TectaTabsVariant.pill;
    if (code.contains('TectaTabsVariant.contained')) return TectaTabsVariant.contained;
    return TectaTabsVariant.line;
  }

  static int parseSelectedIndex(String code, int defaultIndex) {
    final match = RegExp(r'selectedIndex:\s*(\d+)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return int.tryParse(match.group(1) ?? '') ?? defaultIndex;
    }
    return defaultIndex;
  }
}
