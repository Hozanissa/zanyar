import 'package:flutter/material.dart';

import 'bnb.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "INTERACTIVE MAP",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Text(
                    "All Sites",
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
    );
  }
}
