//This class is to register a new account for the user.
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
      appBar: AppBar(
        backgroundColor: Color(0xFF1f4e4c),
        foregroundColor: Color(0xFFFFF8F0),
        toolbarHeight: 110,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.home)),

        title: Text('Zanyar, your go-to travel guide!!'),
        centerTitle: true,

        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
    );
  }
}
