import 'package:flutter/material.dart';

class RegisterNewAccount extends StatefulWidget {
  const RegisterNewAccount({super.key});
  @override
  State<RegisterNewAccount> createState() => _RegisterNewAccountState();
}

class _RegisterNewAccountState extends State<RegisterNewAccount> {
  String dValue = "Slemani";
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
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xFF1F4E4C),
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Enter Your First Name",
                                labelText: "First Name",
                                prefixIcon: const Icon(Icons.person),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Enter Your Last Name",
                                labelText: "Last Name",
                                prefixIcon: const Icon(Icons.person),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Enter Your Phone Number",
                                labelText: "Phone Number",
                                prefixIcon: const Icon(Icons.phone),
                              ),
                            ),
                            const SizedBox(height: 20),
                            DropdownButton(
                              value: dValue,
                              items: [
                                DropdownMenuItem(
                                  value: "Select your city",
                                  child: Text("Select your city"),
                                ),
                                DropdownMenuItem(
                                  value: "Slemani",
                                  child: Text("Slemani"),
                                ),
                                DropdownMenuItem(
                                  value: "Erbil",
                                  child: Text("Hawler"),
                                ),
                                DropdownMenuItem(
                                  value: "Duhok",
                                  child: Text("Duhok"),
                                ),
                                DropdownMenuItem(
                                  value: "Halabja",
                                  child: Text("Halabja"),
                                ),
                                DropdownMenuItem(
                                  value: "Kerkuk",
                                  child: Text("Kerkuk"),
                                ),
                                DropdownMenuItem(
                                  value: "Qamishlo",
                                  child: Text("Qamishlo"),
                                ),
                              ],
                              onChanged: (d) {
                                setState(() {
                                  dValue = d!;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Enter Your Email",
                                labelText: "Email",
                                prefixIcon: const Icon(Icons.email),
                              ),
                            ),

                            const SizedBox(height: 20),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Enter Your Password",
                                labelText: "Password",
                                prefixIcon: const Icon(Icons.lock),
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
