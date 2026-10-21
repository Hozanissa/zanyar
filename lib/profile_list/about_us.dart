import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _aboutTeal = Color(0xFF1F4E4C);
const Color _aboutTerracotta = Color(0xFFC4704B);

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1C2422) : Colors.white;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF141918)
          : const Color(0xFFF9F6F0),
      appBar: AppBar(
        title: Text(
          'about_us'.tr,
          style: GoogleFonts.lora(fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDark ? const Color(0xFF1A2220) : Colors.white,
        foregroundColor: isDark ? Colors.white : _aboutTeal,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: _aboutTeal.withValues(alpha: 0.1),
                  child: const Icon(
                    Icons.explore_outlined,
                    size: 34,
                    color: _aboutTeal,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Discover Kurdistan with Zanyar',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : _aboutTeal,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Zanyar helps you explore places across Kurdistan and plan your next trip. Find destinations, connect with travel companies, and keep your plans together in one place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 14,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 10),
            child: Text(
              'What you can do',
              style: GoogleFonts.lora(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : _aboutTeal,
              ),
            ),
          ),
          _featureTile(
            isDark: isDark,
            cardColor: cardColor,
            icon: Icons.place_outlined,
            title: 'Explore destinations',
            subtitle: 'Discover cultural and natural places to visit.',
          ),
          const SizedBox(height: 8),
          _featureTile(
            isDark: isDark,
            cardColor: cardColor,
            icon: Icons.tour_outlined,
            title: 'Plan a trip',
            subtitle: 'Browse travel companies and send trip requests.',
          ),
          const SizedBox(height: 8),
          _featureTile(
            isDark: isDark,
            cardColor: cardColor,
            icon: Icons.favorite_border,
            title: 'Save your favorites',
            subtitle: 'Keep the places you like close at hand.',
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Made for discovering Kurdistan',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.grey[500] : _aboutTerracotta,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureTile({
    required bool isDark,
    required Color cardColor,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      tileColor: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: CircleAvatar(
        backgroundColor: isDark
            ? const Color(0xFF273330)
            : const Color(0xFFF3F0EA),
        child: Icon(icon, color: _aboutTeal),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
      ),
    );
  }
}
