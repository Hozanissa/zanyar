import 'package:flutter/material.dart';
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
  }

  void startProgress() async {
    for (int i = 0; i <= 100; i++) {
      if (!mounted) return;
      setState(() {
        counter = i;
      });
      Future.delayed(Duration(milliseconds: 50));
    }
    Future.delayed(Duration(seconds: 5), route);
  }

  void route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to my Application", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            LinearProgressIndicator(value: counter / 5),
          ],
        ),
      ),
    );
  }
}
