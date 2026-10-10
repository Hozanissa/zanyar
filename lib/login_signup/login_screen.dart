import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zanyar_app/home_screen.dart';
import 'package:zanyar_app/theme/app_theme.dart';
import 'package:zanyar_app/widgets/auth_toggles.dart';

import 'register_new_account.dart';
import 'reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //variable used to hide/show password.
  bool _obsecureText = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String email = "hozanissa98@gmail.com";
  String password = "123456";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // One place for the snack bar style.
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

  void login() {
    if (_formKey.currentState!.validate()) {
      final enteredEmail = emailController.text.trim();
      final enteredPassword = passwordController.text.trim();

      if (enteredEmail == email && enteredPassword == password) {
        Get.off(HomeScreen(getData: enteredEmail, getPass: enteredPassword));
      } else if (enteredEmail == email) {
        _showMessage('incorrect_password'.tr);
      } else if (enteredPassword == password) {
        _showMessage('incorrect_email'.tr);
      } else {
        _showMessage('invalid_credentials'.tr);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Dark teal is hard to see on a dark background, so use a lighter teal.
    final accent = isDark ? AppTheme.teal : AppTheme.teal;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.grey[700];
    final captionColor = isDark ? Colors.grey[500] : Colors.grey[600];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Language + dark/light switches
            const Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: EdgeInsetsDirectional.only(end: 8, top: 4),
                child: AuthToggles(),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'welcome_to_zanyar'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              color: subtitleColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'login_to_continue'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.terracotta,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'journey_starts'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: captionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: accent, width: 1.2),
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    hintText: 'enter_email'.tr,
                                    labelText: 'email'.tr,
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: accent,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'email_required'.tr;
                                    }
                                    if (!value.endsWith('@gmail.com')) {
                                      return 'email_must_gmail'.tr;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: _obsecureText,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    hintText: 'enter_password'.tr,
                                    labelText: 'password'.tr,
                                    prefixIcon: Icon(Icons.lock, color: accent),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obsecureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: accent,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obsecureText = !_obsecureText;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'password_required'.tr;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: login,
                                  child: Text(
                                    'login'.tr,
                                    style: const TextStyle(
                                      color: AppTheme.terracotta,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //two other buttons that lead you to the reset_password page and
                      //register_new_account page.
                      const SizedBox(height: 20),
                      Text('or'.tr),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () =>
                                Get.off(const RegisterNewAccount()),
                            child: Text(
                              'sign_up'.tr,
                              style: const TextStyle(
                                color: AppTheme.terracotta,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text('to_register'.tr),
                        ],
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text('forgot_password'.tr),
                          TextButton(
                            onPressed: () => Get.off(const ResetPassword()),
                            child: Text(
                              'reset_password'.tr,
                              style: const TextStyle(
                                color: AppTheme.terracotta,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
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
