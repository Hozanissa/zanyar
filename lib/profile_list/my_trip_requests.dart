import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTripRequests extends StatefulWidget {
  const MyTripRequests({super.key});

  @override
  State<MyTripRequests> createState() => _MyTripRequestsState();
}

class _MyTripRequestsState extends State<MyTripRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Trip Requests".tr,
          style: GoogleFonts.lora(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.teal,
          ),
        ),
      ),
    );
  }
}
