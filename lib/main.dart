import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:zanyar_app/locale/locale_controller.dart';
import 'package:zanyar_app/locale/translations.dart';
import 'package:zanyar_app/login_signup/login_screen.dart';
import 'package:zanyar_app/splash_screen.dart';
import 'package:zanyar_app/theme/app_theme.dart';
import 'package:zanyar_app/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeCtrl = Get.put(ThemeController());
  final localeCtrl = Get.put(LocaleController());
  await themeCtrl.load();
  await localeCtrl.load();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    final localeCtrl = Get.find<LocaleController>();

    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/loginScreen', page: () => LoginScreen()),
      ],
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeCtrl.themeMode.value,
      translations: AppTranslations(),
      locale: localeCtrl.initial,
      fallbackLocale: LocaleController.en,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('ckb', 'IQ')],
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
