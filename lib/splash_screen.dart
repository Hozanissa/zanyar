import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zanyar/admin/admin_panel.dart';
import 'package:get/get.dart';
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
    final userRole = prefs.getString('userRole');

    final currentUser = FirebaseAuth.instance.currentUser;
    var hasValidAdminSession = false;
    if (currentUser?.email != null && userRole == 'admin') {
      try {
        final admin = await FirebaseFirestore.instance
            .collection('admins')
            .doc(currentUser!.email!.toLowerCase())
            .get();
        hasValidAdminSession = currentUser.emailVerified &&
            admin.data()?['enabled'] == true &&
            admin.data()?['uid'] == currentUser.uid;
      } on FirebaseException {
        hasValidAdminSession = false;
      }
    }

    if (!mounted) return;

    if (isLoggedIn && currentUser != null) {
      if (userRole == 'admin' && hasValidAdminSession) {
        Get.off(() => const AdminPanel());
      } else if (userRole != 'admin') {
        Get.offNamed('/homeScreen');
      } else {
        await prefs.remove('isLoggedIn');
        await prefs.remove('userRole');
        await FirebaseAuth.instance.signOut();
        Get.offNamed('/loginScreen');
      }
    } else {
      await prefs.remove('isLoggedIn');
      await prefs.remove('userRole');
      Get.offNamed('/loginScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color teal = Color(0xFF1F4E4B);
    const Color niceGold = Color(0xFFD4AF37);
    const Color somehowWhite = Color(0xFFF5F0E6);

    return Scaffold(
      backgroundColor: teal,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),

                Image.asset(
                  'image/app-logo.png',
                  width: 112,
                  height: 112,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 28),

                // App Title
                const Text(
                  'ZANYAR',
                  style: TextStyle(
                    color: somehowWhite,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3.5,
                    fontFamily: 'serif',
                  ),
                ),

                const SizedBox(height: 10),

                // Subtle Cultural Tagline
                Text(
                  'Ancient Sites & Heritage of Kurdistan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: somehowWhite.withOpacity(0.75),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                  ),
                ),

                const Spacer(flex: 3),

                // Minimal, elegant loading indicator
                // Elegant Pill-shaped Linear Progress Indicator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: counter / 100,
                            minHeight: 8,
                            color: niceGold,
                            // Warm terracotta clay
                            backgroundColor: Colors.white.withOpacity(
                              0.12,
                            ), // Subtle translucent track
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Optional subtle percentage text
                      Text(
                        '$counter%',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 1),

                // Minimalist Footer
                Text(
                  'KURDISTAN',
                  style: TextStyle(
                    color: somehowWhite.withOpacity(0.35),
                    fontSize: 11,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
