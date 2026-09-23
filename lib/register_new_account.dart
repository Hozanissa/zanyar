// // This class is to register a new account for the user.
// import 'package:flutter/material.dart';

// class RegisterNewAccount extends StatefulWidget {
//   const RegisterNewAccount({super.key});
//   @override
//   State<RegisterNewAccount> createState() => _RegisterNewAccountState();
// }

// class _RegisterNewAccountState extends State<RegisterNewAccount> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Create a new account",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1f4e4c),
//                 ),
//               ),
//               SizedBox(height: 20), // First Name
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 child: TextField(
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Enter Your First Name",
//                     labelText: "First Name",
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20), // Last Name
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 child: TextField(
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Enter Your Last Name",
//                     labelText: "Last Name",
//                     prefixIcon: Icon(Icons.person),
//                   ),
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
//               SizedBox(height: 20),
//               // Phone Number
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 child: TextField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Enter Your Phone Number",
//                     labelText: "Phone Number",
//                     prefixIcon: Icon(Icons.phone),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20), // Password
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 child: TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Enter Your Password",
//                     labelText: "Password",
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 25), // Create Account Button
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Create Account',
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class RegisterNewAccount extends StatefulWidget {
  const RegisterNewAccount({super.key});
  @override
  State<RegisterNewAccount> createState() => _RegisterNewAccountState();
}

class _RegisterNewAccountState extends State<RegisterNewAccount> {
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
                    const SizedBox(height: 40),
                    const Text(
                      "Create a new account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1f4e4c),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Enter Your First Name",
                          labelText: "First Name",
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Enter Your Last Name",
                          labelText: "Last Name",
                          prefixIcon: const Icon(Icons.person),
                        ),
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
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Enter Your Phone Number",
                          labelText: "Phone Number",
                          prefixIcon: const Icon(Icons.phone),
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
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
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
