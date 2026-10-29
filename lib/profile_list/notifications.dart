import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanyar/notification/app_controller.dart';

const Color _teal = Color(0xFF2A7A70);
const Color _terracotta = Color(0xFFC66A4A);

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final appCtrl = Get.find<AppController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF141918)
          : const Color(0xFFF9F6F0),
      appBar: AppBar(
        title: Text(
          'notifications'.tr,
          style: GoogleFonts.lora(fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDark ? const Color(0xFF1A2220) : Colors.white,
        foregroundColor: isDark ? Colors.white : _teal,
        elevation: 0,
      ),
      body: Obx(() {
        final notes = appCtrl.notifications;
        if (notes.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.notifications_none,
                  size: 56,
                  color: Colors.grey,
                ),
                const SizedBox(height: 12),
                Text(
                  'no_notifications'.tr,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: notes.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final n = notes[i];
            return ListTile(
              tileColor: isDark ? const Color(0xFF1C2422) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: CircleAvatar(
                backgroundColor: _terracotta.withValues(alpha: 0.12),
                child: const Icon(
                  Icons.notifications,
                  color: _terracotta,
                  size: 20,
                ),
              ),
              title: Text(
                n.message,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              subtitle: Text(
                _timeAgo(n.time),
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
            );
          },
        );
      }),
    );
  }

  String _timeAgo(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
