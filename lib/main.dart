import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:zanyar_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => SplashScreen()),
      //   GetPage(name: '/l', page: () => LoginScreen()),
      //   GetPage(name: '/h', page: () => HomeScreen()),
      // ],
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1F4E4C)),
        useMaterial3: true,
      ),
    );
  }
}
