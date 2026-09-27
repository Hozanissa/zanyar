import 'package:flutter/material.dart';

import 'bnb.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Interactive Map", style: TextStyle(color: Colors.grey[400])),
          Text("All Sites", style: TextStyle(fontSize: 25)),
        ],
      ),
      bottomNavigationBar: const BNB(),
    );
  }
}
