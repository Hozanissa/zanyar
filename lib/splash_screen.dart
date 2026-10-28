import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;

    if (isLoggedIn) {
      //navigate to home_screen.dart if the user is already logged in
      Get.offNamed('/homeScreen');
      //navigate to login screen if the user is not logged in.
    } else {
      Get.offNamed('/loginScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F4E4C),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            Text(
              'welcome_to_zanyar'.tr,
              style: GoogleFonts.lora(fontSize: 20, color: Color(0xFFC4704B)),
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
