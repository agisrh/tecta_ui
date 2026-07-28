import 'package:flutter_test/flutter_test.dart';
import 'package:tecta_ui/tecta_ui.dart';

void main() {
  test('verify tecta_ui color palette is loaded', () {
    expect(TectaColors.primaryMain, isNotNull);
    expect(TectaColors.primaryMain.toARGB32(), 0xFF0F2B5C);
  });

  test('verify tecta_ui shadows are loaded', () {
    expect(TectaShadows.z8, isNotEmpty);
    expect(TectaShadows.primary, isNotEmpty);
  });
}
