import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:zanyar_app/locale/kurdish_localizations.dart';
import 'package:zanyar_app/locale/locale_controller.dart';
import 'package:zanyar_app/locale/translations.dart';
import 'package:zanyar_app/login_signup/login_screen.dart';
import 'package:zanyar_app/main_screens/home_screen.dart';
import 'package:zanyar_app/notification/app_controller.dart';
import 'package:zanyar_app/splash_screen.dart';
import 'package:zanyar_app/theme/app_theme.dart';
import 'package:zanyar_app/theme/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //the one line of code where you initialize the fire in addition to importing the newly created firebase_options.dart file and the firebase_core package.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final themeCtrl = Get.put(ThemeController());
  final localeCtrl = Get.put(LocaleController());
  Get.put(AppController());
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
      initialRoute: '/splashScreen',
      getPages: [
        GetPage(name: '/splashScreen', page: () => SplashScreen()),
        GetPage(name: '/loginScreen', page: () => LoginScreen()),
        GetPage(name: '/homeScreen', page: () => HomeScreen()),
      ],

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeCtrl.themeMode.value,
      translations: AppTranslations(),
      locale: localeCtrl.initial,
      fallbackLocale: LocaleController.en,
      localizationsDelegates: const [
        KurdishMaterialLocalizationsDelegate(),
        KurdishCupertinoLocalizationsDelegate(),
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
