import 'package:flutter/material.dart';

/// The ten locales that are first-class launch targets for Tensio.
///
/// Keep this list stable and explicit. A locale is not considered supported
/// merely because Flutter can render its script; product copy, reports,
/// notifications and accessibility text must also be translated and QA'd.
enum TensioLocale {
  turkish(
    locale: Locale('tr'),
    nativeName: 'Türkçe',
    englishName: 'Turkish',
  ),
  english(
    locale: Locale('en'),
    nativeName: 'English',
    englishName: 'English',
  ),
  spanish(
    locale: Locale('es'),
    nativeName: 'Español',
    englishName: 'Spanish',
  ),
  brazilianPortuguese(
    locale: Locale('pt', 'BR'),
    nativeName: 'Português (Brasil)',
    englishName: 'Brazilian Portuguese',
  ),
  french(
    locale: Locale('fr'),
    nativeName: 'Français',
    englishName: 'French',
  ),
  german(
    locale: Locale('de'),
    nativeName: 'Deutsch',
    englishName: 'German',
  ),
  arabic(
    locale: Locale('ar'),
    nativeName: 'العربية',
    englishName: 'Arabic',
    isRtl: true,
  ),
  simplifiedChinese(
    locale: Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    nativeName: '简体中文',
    englishName: 'Simplified Chinese',
  ),
  japanese(
    locale: Locale('ja'),
    nativeName: '日本語',
    englishName: 'Japanese',
  ),
  korean(
    locale: Locale('ko'),
    nativeName: '한국어',
    englishName: 'Korean',
  );

  const TensioLocale({
    required this.locale,
    required this.nativeName,
    required this.englishName,
    this.isRtl = false,
  });

  final Locale locale;
  final String nativeName;
  final String englishName;
  final bool isRtl;

  static List<Locale> get supportedLocales =>
      values.map((entry) => entry.locale).toList(growable: false);

  static TensioLocale? fromLocale(Locale locale) {
    for (final entry in values) {
      if (entry.locale.languageCode != locale.languageCode) continue;

      final expectedCountry = entry.locale.countryCode;
      if (expectedCountry != null &&
          expectedCountry != locale.countryCode &&
          locale.countryCode != null) {
        continue;
      }

      final expectedScript = entry.locale.scriptCode;
      if (expectedScript != null &&
          expectedScript != locale.scriptCode &&
          locale.scriptCode != null) {
        continue;
      }

      return entry;
    }

    return null;
  }
}
