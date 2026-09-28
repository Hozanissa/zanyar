import 'package:flutter/material.dart';

import 'bnb.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("INTERACTIVE MAP", style: TextStyle(color: Colors.grey[400])),
          Text(
            "All Sites",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      bottomNavigationBar: const BNB(),
    );
  }
}
