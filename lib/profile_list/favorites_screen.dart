import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanyar/notification/app_controller.dart';
import 'package:zanyar/trip_booking/site_detail_screen.dart';
import 'package:zanyar/trip_site_info/site_model.dart';

const Color _teal = Color(0xFF008080);

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
          'favorites'.tr,
          style: GoogleFonts.lora(fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDark ? const Color(0xFF1A2220) : Colors.white,
        foregroundColor: isDark ? Colors.white : _teal,
        elevation: 0,
      ),
      body: Obx(() {
        final ids = appCtrl.favoriteSiteIds;
        final sites = kAllSites.where((s) => ids.contains(s.id)).toList();
        if (sites.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.favorite_border, size: 56, color: Colors.grey),
                const SizedBox(height: 12),
                Text(
                  'no_favorites'.tr,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: sites.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (_, i) {
            final site = sites[i];
            return ListTile(
              tileColor: isDark ? const Color(0xFF1C2422) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: CircleAvatar(
                backgroundColor: _teal.withValues(alpha: 0.1),
                child: Icon(site.icon, color: _teal, size: 20),
              ),
              title: Text(
                site.localizedName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                site.city.tr,
                style: TextStyle(color: Colors.grey[500]),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red, size: 20),
                onPressed: () => appCtrl.toggleFavorite(site),
              ),
              onTap: () => Get.to(() => SiteDetailScreen(site: site)),
            );
          },
        );
      }),
    );
  }
}
