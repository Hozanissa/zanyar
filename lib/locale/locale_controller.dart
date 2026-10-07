// locale_controller.dart
import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  static const en = Locale('en', 'US');
  static const ckb = Locale('ckb', 'IQ');

  final isKurdish = false.obs; // new

  Locale get initial => _saved ?? en;
  Locale? _saved;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('lang');
    if (code == 'ckb') {
      _saved = ckb;
      isKurdish.value = true; // new
    }
  }

  Future<void> setLanguage(Locale locale) async {
    isKurdish.value = locale == ckb; // new
    Get.updateLocale(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', locale.languageCode);
  }
}
