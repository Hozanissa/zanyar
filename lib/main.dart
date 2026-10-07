import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:zanyar_app/locale/locale_controller.dart';
import 'package:zanyar_app/locale/translations.dart';
import 'package:zanyar_app/splash_screen.dart';
import 'package:zanyar_app/theme/app_theme.dart';
import 'package:zanyar_app/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeCtrl = Get.put(ThemeController());
  final localeCtrl = Get.put(LocaleController());
  await themeCtrl.load();
  await localeCtrl.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    final localeCtrl = Get.find<LocaleController>();

    return GetMaterialApp(
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
    );
  }
}

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       // initialRoute: '/',
//       // getPages: [
//       //   GetPage(name: '/', page: () => SplashScreen()),
//       //   GetPage(name: '/l', page: () => LoginScreen()),
//       //   GetPage(name: '/h', page: () => HomeScreen()),
//       // ],
//       home: SplashScreen(),
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1F4E4C)),
//         useMaterial3: true,
//       ),
//     );
//   }
// }
