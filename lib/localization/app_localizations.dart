import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  bool get isArabic => locale.languageCode == 'ar';

  String welcome(String appName) =>
      isArabic ? 'مرحباً بك في $appName' : 'Welcome to $appName';
  String get foundationLabel => isArabic
      ? 'أساس متين لتطبيقات الهاتف'
      : 'A considered foundation for mobile apps';
  String get appearance => isArabic ? 'المظهر' : 'Appearance';
  String get language => isArabic ? 'اللغة' : 'Language';
  String get system => isArabic ? 'النظام' : 'System';
  String get light => isArabic ? 'فاتح' : 'Light';
  String get dark => isArabic ? 'داكن' : 'Dark';
  String get notFoundTitle =>
      isArabic ? 'هذه الصفحة غير متاحة' : 'This page is unavailable';
  String get notFoundBody => isArabic
      ? 'قد يكون الرابط غير صحيح أو أن الصفحة نُقلت.'
      : 'The link may be incorrect or the page may have moved.';
  String get backHome => isArabic ? 'العودة للرئيسية' : 'Back to home';
  String get english => 'English';
  String get arabic => 'العربية';

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.any(
    (Locale supported) => supported.languageCode == locale.languageCode,
  );

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
