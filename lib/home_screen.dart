import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  String getData = "";
  String getPass = "";
  HomeScreen({super.key, required this.getData, required this.getPass});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    "زانيار-ZANYAR",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  Text(
                    "Kurdistan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC4704B),
                    ),
                  ),
                  Text(
                    "Historical Sites",
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name: ${widget.getData} ",
                  style: TextStyle(fontSize: 25, color: Colors.red),
                ),
                Text(
                  "Password: ${widget.getPass} ",
                  style: TextStyle(fontSize: 25, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
