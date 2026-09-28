import 'package:flutter/material.dart';

import 'bnb.dart';

class Archive extends StatefulWidget {
  const Archive({super.key});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("CULTURAL ARCHIVE", style: TextStyle(color: Colors.grey[400])),
          Text("Kurdish Heritage", style: TextStyle(fontSize: 25)),
        ],
      ),
      bottomNavigationBar: const BNB(),
    );
  }
}
