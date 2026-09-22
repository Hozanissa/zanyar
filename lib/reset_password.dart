//This class is created so that the user can
//reset his/her password in case they forgot their password.
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
