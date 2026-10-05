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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              //The padding widget contain the header text for the page.
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CULTURAL ARCHIVE",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Text(
                    "Kurdish Heritage",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC4704B),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Color(0xFF1F4E4C)),
          ],
        ),
      ),
      bottomNavigationBar: const BNB(),
    );
  }
}
