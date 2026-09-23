// // This class is created so that the user can // reset his/her password in case they forgot their password.
// import 'package:flutter/material.dart';

// class ResetPassword extends StatefulWidget {
//   const ResetPassword({super.key});
//   @override
//   State<ResetPassword> createState() => _ResetPasswordState();
// }

// class _ResetPasswordState extends State<ResetPassword> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Reset your password",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1f4e4c),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "Enter your email to receive a password reset link.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Email
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 child: TextField(
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Enter Your Email",
//                     labelText: "Email",
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 25),
//               // Send Link Button
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Send Link',
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1F4E4C)),
                label: const Text(
                  'Back to login',
                  style: TextStyle(
                    color: Color(0xFF1F4E4C),
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Enter Your Email",
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Send Link',
                        style: TextStyle(
                          color: Colors.red,
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
