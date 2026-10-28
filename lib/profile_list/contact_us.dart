import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const Color _contactTeal = Color(0xFF1F4E4C);
const Color _contactTerracotta = Color(0xFFC4704B);

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  static const String phone = '+9647511292504';
  static const String email = 'hozanissa98@gmail.com';
  static const String githubUrl = 'https://github.com/Hozanissa';
  static const String facebookUrl =
      'https://www.facebook.com/profile.php?id=61581997766044';

  Future<void> _open(BuildContext context, Uri uri) async {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('contact_could_not_open'.tr)));
    }
  }

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
          'contact_us'.tr,
          style: GoogleFonts.lora(fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDark ? const Color(0xFF1A2220) : Colors.white,
        foregroundColor: isDark ? Colors.white : _contactTeal,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: _contactTeal.withValues(alpha: 0.1),
                  child: const Icon(
                    Icons.support_agent_outlined,
                    color: _contactTeal,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'contact_header_title'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : _contactTeal,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'contact_header_subtitle'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _contactTile(
            context,
            isDark: isDark,
            cardColor: cardColor,
            title: 'Facebook',
            subtitle: 'contact_facebook_subtitle'.tr,
            icon: const Icon(Icons.facebook, color: Color(0xFF1877F2)),
            onTap: () => _open(context, Uri.parse(facebookUrl)),
          ),
          const SizedBox(height: 8),
          _contactTile(
            context,
            isDark: isDark,
            cardColor: cardColor,
            title: 'email'.tr,
            subtitle: email,
            icon: const Icon(Icons.email_outlined, color: _contactTerracotta),
            onTap: () => _open(context, Uri(scheme: 'mailto', path: email)),
          ),
          const SizedBox(height: 8),
          _contactTile(
            context,
            isDark: isDark,
            cardColor: cardColor,
            title: 'contact_phone'.tr,
            subtitle: phone,
            icon: const Icon(Icons.call_outlined, color: _contactTeal),
            onTap: () => _open(context, Uri(scheme: 'tel', path: phone)),
          ),
          const SizedBox(height: 8),
          _contactTile(
            context,
            isDark: isDark,
            cardColor: cardColor,
            title: 'contact_sms'.tr,
            subtitle: 'contact_sms_subtitle'.tr,
            icon: const Icon(Icons.sms_outlined, color: Colors.orange),
            onTap: () => _open(context, Uri(scheme: 'sms', path: phone)),
          ),
          const SizedBox(height: 8),
          _contactTile(
            context,
            isDark: isDark,
            cardColor: cardColor,
            title: 'GitHub',
            subtitle: 'contact_github_subtitle'.tr,
            icon: const FaIcon(FontAwesomeIcons.github, color: _contactTeal),
            onTap: () => _open(context, Uri.parse(githubUrl)),
          ),
        ],
      ),
    );
  }

  Widget _contactTile(
    BuildContext context, {
    required bool isDark,
    required Color cardColor,
    required String title,
    required String subtitle,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      tileColor: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: CircleAvatar(
        backgroundColor: isDark
            ? const Color(0xFF273330)
            : const Color(0xFFF3F0EA),
        child: icon,
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
      trailing: Icon(
        Icons.chevron_right,
        color: isDark ? Colors.grey[500] : Colors.grey[500],
      ),
      onTap: onTap,
    );
  }
}
