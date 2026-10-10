import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zanyar_app/login_signup/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int counter = 0;
  @override
  void initState() {
    super.initState();
    startProgress();
  }

  void startProgress() async {
    for (int i = 0; i <= 100; i++) {
      if (!mounted) return;
      setState(() {
        counter = i;
      });
      await Future.delayed(Duration(milliseconds: 50));
    }
    route();
  }

  void route() {
    Get.off(() => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('image/app-icon.png', width: 140),
            SizedBox(height: 24),
            Text(
              'welcome_to_zanyar'.tr,
              style: TextStyle(fontSize: 20, color: Color(0xFFC4704B)),
            ),
            SizedBox(height: 24),
            LinearProgressIndicator(
              value: counter / 100,
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFC4704B),
            ),
          ],
        ),
      ),
    );
  }
}
