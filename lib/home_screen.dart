import 'package:flutter/material.dart';
import 'package:zanyar_app/bnb.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("زانيار-ZANYAR", style: TextStyle(color: Colors.grey[500])),
          Text("Kurdistan", style: TextStyle(fontSize: 25)),
          Text("Historical Sites", style: TextStyle(fontSize: 25)),
        ],
      ),
      bottomNavigationBar: const BNB(),
    );
  }
}
