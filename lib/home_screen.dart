import 'package:flutter/material.dart';
import 'package:zanyar_app/bnb.dart';

class HomeScreen extends StatefulWidget {
  static String savedData = "";
  static String savedPass = "";

  final String getData;
  final String getPass;

  HomeScreen({super.key, this.getData = "", this.getPass = ""}) {
    if (getData.isNotEmpty) savedData = getData;
    if (getPass.isNotEmpty) savedPass = getPass;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final displayName = widget.getData.isNotEmpty
        ? widget.getData
        : HomeScreen.savedData;
    final displayPass = widget.getPass.isNotEmpty
        ? widget.getPass
        : HomeScreen.savedPass;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The padding widget contains the header text for the page.
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "زانيار-ZANYAR",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  const Text(
                    "Kurdistan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC4704B),
                    ),
                  ),
                  const Text(
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
            const Divider(color: Color(0xFF1F4E4C)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name: $displayName ",
                  style: const TextStyle(fontSize: 25, color: Colors.red),
                ),
                Text(
                  "Password: $displayPass ",
                  style: const TextStyle(fontSize: 25, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BNB(currentIndex: 0),
    );
  }
}
