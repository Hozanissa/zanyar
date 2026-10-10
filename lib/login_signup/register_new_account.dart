import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zanyar_app/login_signup/login_screen.dart';
import 'package:zanyar_app/theme/app_theme.dart';
import 'package:zanyar_app/widgets/auth_toggles.dart';

class RegisterNewAccount extends StatefulWidget {
  const RegisterNewAccount({super.key});
  @override
  State<RegisterNewAccount> createState() => _RegisterNewAccountState();
}

class _RegisterNewAccountState extends State<RegisterNewAccount> {
  bool _obsecureText = true;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // One place for the snack bar style so every message looks the same
  // as the ones on the login screen.
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

  void register() {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (firstName.isEmpty) {
      _showMessage('first_name_required'.tr);
    } else if (lastName.isEmpty) {
      _showMessage('last_name_required'.tr);
    } else if (phone.isEmpty) {
      _showMessage('phone_required'.tr);
    } else if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      _showMessage('phone_digits'.tr);
    } else if (phone.length < 10) {
      _showMessage('phone_short'.tr);
    } else if (email.isEmpty) {
      _showMessage('email_required'.tr);
    } else if (!email.contains('@') || !email.contains('.')) {
      _showMessage('invalid_email'.tr);
    } else if (password.isEmpty) {
      _showMessage('password_required'.tr);
    } else if (password.length < 6) {
      _showMessage('password_short'.tr);
    } else {
      // Every field passed, so the account is "created".
      _showMessage('account_created'.tr);

      firstNameController.clear();
      lastNameController.clear();
      phoneController.clear();
      emailController.clear();
      passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppTheme.teal : AppTheme.teal;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Back button on the start side, switches on the end side.
            // (Start/end flip automatically in right-to-left Kurdish.)
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
                        'create_account_title'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.terracotta,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: accent, width: 1.2),
                          ),
                          child: Column(
                            children: [
                              TextField(
                                controller: firstNameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'enter_first_name'.tr,
                                  labelText: 'first_name'.tr,
                                  prefixIcon: Icon(Icons.person, color: accent),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: lastNameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'enter_last_name'.tr,
                                  labelText: 'last_name'.tr,
                                  prefixIcon: Icon(Icons.person, color: accent),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'enter_phone'.tr,
                                  labelText: 'phone'.tr,
                                  prefixIcon: Icon(Icons.phone, color: accent),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'enter_email'.tr,
                                  labelText: 'email'.tr,
                                  prefixIcon: Icon(Icons.email, color: accent),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
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
                              ),
                              const SizedBox(height: 25),
                              ElevatedButton(
                                onPressed: register,
                                child: Text(
                                  'create_account'.tr,
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
                      const SizedBox(height: 20),
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
