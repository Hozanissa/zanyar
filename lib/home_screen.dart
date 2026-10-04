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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //this is the top text defining what this page is for.
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Historical Sites",
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
