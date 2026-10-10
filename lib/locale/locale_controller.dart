// locale_controller.dart
import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  static const en = Locale('en', 'US');
  static const ckb = Locale('ckb', 'IQ');
  static const _prefKey = 'lang';

  final isKurdish = false.obs;

  /// Locale the app starts with (call [load] first).
  Locale get initial => isKurdish.value ? ckb : en;

  /// Handy for data classes / helpers that have no BuildContext.
  static bool get kurdishNow => Get.find<LocaleController>().isKurdish.value;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    isKurdish.value = prefs.getString(_prefKey) == 'ckb';
  }

  Future<void> setLanguage(Locale locale) async {
    isKurdish.value = locale.languageCode == 'ckb';
    Get.updateLocale(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, locale.languageCode);
  }

  /// One-tap switch between English and Kurdish (used by the login screens).
  Future<void> toggle() => setLanguage(isKurdish.value ? en : ckb);
}
