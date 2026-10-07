import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zanyar_app/login_signup/login_screen.dart';

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
            color: Color(0xFFC4704B),
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
      _showMessage("First name is required");
    } else if (lastName.isEmpty) {
      _showMessage("Last name is required");
    } else if (phone.isEmpty) {
      _showMessage("Phone number is required");
    } else if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      _showMessage("Phone number must contain digits only");
    } else if (phone.length < 10) {
      _showMessage("Phone number is too short");
    } else if (email.isEmpty) {
      _showMessage("Email is required");
    } else if (!email.contains('@') || !email.contains('.')) {
      _showMessage("Please enter a valid email");
    } else if (password.isEmpty) {
      _showMessage("Password is required");
    } else if (password.length < 6) {
      _showMessage("Password must be at least 6 characters");
    } else {
      // Every field passed, so the account is "created".
      _showMessage("Account created, go back to login screen");

      firstNameController.clear();
      lastNameController.clear();
      phoneController.clear();
      emailController.clear();
      passwordController.clear();
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
                  Get.off(LoginScreen());
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
                    const SizedBox(height: 40),
                    const Text(
                      "Create a new account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC4704B),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF1F4E4C),
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: firstNameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Your First Name",
                                labelText: "First Name",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xFF1F4E4C),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: lastNameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Your Last Name",
                                labelText: "Last Name",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xFF1F4E4C),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Your Phone Number",
                                labelText: "Phone Number",
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Color(0xFF1F4E4C),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
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
                            const SizedBox(height: 20),
                            TextField(
                              controller: passwordController,
                              obscureText: _obsecureText,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Enter Your Password",
                                labelText: "Password",
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Color(0xFF1F4E4C),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obsecureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xFF1F4E4C),
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
                              child: const Text(
                                'Create Account',
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
                    const SizedBox(height: 20),
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
