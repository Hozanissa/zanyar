import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            color: Color(0xFFC4704B),
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
      _showMessage("Email is required");
    } else if (!email.contains('@') || !email.contains('.')) {
      _showMessage("Please enter a valid email");
    } else if (email != registeredEmail) {
      _showMessage("No account found with this email");
    } else {
      _showMessage("Reset link sent, check your email and go back to login");
      emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: TextButton.icon(
                onPressed: () {
                  // Login opens this page with pushReplacement, so there is
                  // no login screen left to go back to. Open it again.
                  Get.off(() => LoginScreen());
                },
                icon: const Icon(Icons.arrow_back, color: Color(0xFFC4704B)),
                label: const Text(
                  'Back to login',
                  style: TextStyle(
                    color: Color(0xFFC4704B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Reset your password",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1f4e4c),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Enter your email to receive a password reset link.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Your Email",
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xFF1F4E4C),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: sendLink,
                      child: const Text(
                        'Send Link',
                        style: TextStyle(
                          color: Color(0xFFC4704B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
