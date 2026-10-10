import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zanyar_app/theme/app_theme.dart';
import 'package:zanyar_app/widgets/auth_toggles.dart';

import 'login_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();

  // Same email the login screen accepts.
  final String registeredEmail = "hozanissa98@gmail.com";

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[300],
        content: Text(
          message,
          style: const TextStyle(
            color: AppTheme.terracotta,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void sendLink() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      _showMessage('email_required'.tr);
    } else if (!email.contains('@') || !email.contains('.')) {
      _showMessage('invalid_email'.tr);
    } else if (email != registeredEmail) {
      _showMessage('no_account'.tr);
    } else {
      _showMessage('link_sent'.tr);
      emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppTheme.teal : AppTheme.teal;
    final captionColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 10,
                end: 8,
                top: 4,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton.icon(
                        // Login opens this page with Get.off, so there is no
                        // login screen left to go back to. Open it again.
                        onPressed: () => Get.off(const LoginScreen()),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppTheme.terracotta,
                        ),
                        label: Text(
                          'back_to_login'.tr,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppTheme.terracotta,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const AuthToggles(),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'reset_your_password'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: accent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'reset_instruction'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: captionColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'enter_email'.tr,
                            labelText: 'email'.tr,
                            prefixIcon: Icon(Icons.email, color: accent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: sendLink,
                        child: Text(
                          'send_link'.tr,
                          style: const TextStyle(
                            color: AppTheme.terracotta,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
