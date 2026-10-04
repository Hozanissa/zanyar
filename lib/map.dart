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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //The padding widget contain the header text for the page.
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
