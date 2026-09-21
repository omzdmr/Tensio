import 'package:flutter_test/flutter_test.dart';
import 'package:tensio/core/localization/tensio_locale.dart';

void main() {
  group('TensioLocale', () {
    test('contains exactly the ten launch languages', () {
      expect(TensioLocale.values, hasLength(10));
      expect(TensioLocale.supportedLocales, hasLength(10));
    });

    test('Arabic is explicitly RTL', () {
      expect(TensioLocale.arabic.isRtl, isTrue);
      expect(
        TensioLocale.values.where((locale) => locale.isRtl),
        [TensioLocale.arabic],
      );
    });

    test('Brazilian Portuguese keeps region information', () {
      expect(TensioLocale.brazilianPortuguese.locale.languageCode, 'pt');
      expect(TensioLocale.brazilianPortuguese.locale.countryCode, 'BR');
    });

    test('Simplified Chinese keeps Hans script information', () {
      expect(TensioLocale.simplifiedChinese.locale.languageCode, 'zh');
      expect(TensioLocale.simplifiedChinese.locale.scriptCode, 'Hans');
    });
  });
}
