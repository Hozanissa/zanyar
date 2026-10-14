import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanyar_app/bnb.dart';

const Color _terracotta = Color(0xFFC4704B);

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.6,
                      color: isDark ? Colors.grey[400] : _terracotta,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kurdistan'.tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.6,
                      color: isDark ? Colors.grey[400] : _terracotta,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'historical_sites'.tr,
                    style: GoogleFonts.lora(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary,
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
                  "${'name_label'.tr}: Hey $displayName ",
                  style: GoogleFonts.lora(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.teal,
                  ),
                ),
                // Text(
                //   "${'password'.tr}: $displayPass ",
                //   style: const TextStyle(fontSize: 25, color: Colors.red),
                // ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BNB(currentIndex: 0),
    );
  }
}
