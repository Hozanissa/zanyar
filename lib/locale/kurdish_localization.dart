// kurdish_localizations.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Flutter has NO built-in Material / Cupertino / Widgets localizations for
/// Central Kurdish (Sorani, language code "ckb").
///
/// Without these delegates, switching the app to `Locale('ckb', 'IQ')` leaves
/// widgets like Scaffold, TextField, SnackBar and BottomNavigationBar without
/// a MaterialLocalizations object, which throws and shows the red error screen.
///
/// The delegates below answer for "ckb" by loading the Arabic ("ar") strings,
/// which share the same script and right-to-left direction. Our own texts come
/// from AppTranslations, so only Flutter's built-in labels (e.g. "Back",
/// "Paste", date pickers) use the Arabic wording.
class KurdishLocalizations {
  static const List<LocalizationsDelegate<dynamic>> delegates = [
    _CkbMaterialDelegate(),
    _CkbCupertinoDelegate(),
    _CkbWidgetsDelegate(),
  ];
}

const _fallback = Locale('ar');

class _CkbMaterialDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _CkbMaterialDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ckb';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(_fallback);

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<MaterialLocalizations> old,
  ) => false;
}

class _CkbCupertinoDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _CkbCupertinoDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ckb';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(_fallback);

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<CupertinoLocalizations> old,
  ) => false;
}

class _CkbWidgetsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const _CkbWidgetsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ckb';

  // Loading "ar" also gives us TextDirection.rtl for the whole app.
  @override
  Future<WidgetsLocalizations> load(Locale locale) =>
      GlobalWidgetsLocalizations.delegate.load(_fallback);

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<WidgetsLocalizations> old,
  ) => false;
}
