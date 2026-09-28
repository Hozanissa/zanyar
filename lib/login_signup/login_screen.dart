import 'package:flutter/material.dart';

//import 'package:zanyar_app/admin/admin_panel.dart';

import 'register_new_account.dart';
import 'reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Welcome to Zanyar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Login to continue',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F4E4C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your journey starts here.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),          
                const Text('Or'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterNewAccount(),
                          ),
                        );
                      },
                      child: const Text(
                        'Click here',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text('to register a new account'),
                  ],
                ),
              ],

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Forgot your password?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPassword(),
                        ),
                      );
                    },
                    child: const Text(
                      'Reset password',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
          ], 
          ),
        ),
      ),
    );
  }

  Widget _buildUserForm({Key? key}) {
    return Column(
      key: key,
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Enter Your Username",
            labelText: "Username",
            prefixIcon: const Icon(Icons.person),
          ),
          validator: (t) {
            if (t == null || t.trim().isEmpty) {
              return "Please Enter a Valid Username";
            }
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Enter Your Password",
            labelText: "Password",
            prefixIcon: const Icon(Icons.lock),
          ),
          validator: (t) {
            if (t == null || t.trim().isEmpty) {
              return "Please Enter a Valid Password";
            }
          },
        ),
      ],
    );
  }

  Widget _buildAdminForm({Key? key}) {
    return Column(
      key: key,
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Enter Admin ID",
            labelText: "Admin ID",
            prefixIcon: const Icon(Icons.admin_panel_settings),
          ),
          validator: (t) {
            if (t == null || t.trim().isEmpty) {
              return "Please Enter a Valid ID";
            }
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Enter Admin Password",
            labelText: "Password",
            prefixIcon: const Icon(Icons.lock),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (t) {
            if (t == null || t.trim().isEmpty) {
              return "Please Enter a Valid ID";
            }
          },
        ),
      ],
    );
  }
}
