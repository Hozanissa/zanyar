// import 'package:flutter/material.dart';

// import 'register_new_account.dart';
// import 'reset_password.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Column(
//               children: [
//                 Text(
//                   'Welcome to Zanyar',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[700],
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'Login to continue',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1F4E4C),
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Your journey starts here.',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0),
//               child: TextField(
//                 keyboardType: TextInputType.name,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: "Enter Your Username",
//                   labelText: "Username",
//                   prefixIcon: Icon(Icons.person),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0),
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: "Enter Your Password",
//                   labelText: "Password",
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('Login', style: TextStyle(color: Colors.red)),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Text('Or'),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const RegisterNewAccount(),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'Click here',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text('to register a new account'),
//               ],
//             ),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Forgot your password?'),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ResetPassword(),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'Reset password',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'register_new_account.dart';
import 'reset_password.dart';

enum UserRole { user, admin }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserRole _selectedRole = UserRole.user;

  Widget _buildRoleButton({
    required UserRole role,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = _selectedRole == role;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1F4E4C) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF1F4E4C) : Colors.grey[400]!,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = _selectedRole == UserRole.admin;

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

              // Role selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRoleButton(
                    role: UserRole.user,
                    icon: Icons.person,
                    label: 'User',
                  ),
                  const SizedBox(width: 20),
                  _buildRoleButton(
                    role: UserRole.admin,
                    icon: Icons.admin_panel_settings,
                    label: 'Admin',
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Container that changes based on selected role
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isAdmin
                    ? _buildAdminForm(key: const ValueKey('admin'))
                    : _buildUserForm(key: const ValueKey('user')),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      isAdmin ? 'Login as Admin' : 'Login',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),

              if (!isAdmin) ...[
                const SizedBox(height: 10),
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

  // Regular user login fields
  Widget _buildUserForm({Key? key}) {
    return Column(
      key: key,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Enter Your Username",
              labelText: "Username",
              prefixIcon: const Icon(Icons.person),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Enter Your Password",
              labelText: "Password",
              prefixIcon: const Icon(Icons.lock),
            ),
          ),
        ),
      ],
    );
  }

  // Admin login fields (e.g. admin ID + password)
  Widget _buildAdminForm({Key? key}) {
    return Column(
      key: key,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Enter Admin ID",
              labelText: "Admin ID",
              prefixIcon: const Icon(Icons.admin_panel_settings),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Enter Admin Password",
              labelText: "Password",
              prefixIcon: const Icon(Icons.lock),
            ),
          ),
        ),
      ],
    );
  }
}
