import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zanyar/bnb.dart';
import 'package:zanyar/locale/locale_controller.dart';
import 'package:zanyar/notification/app_controller.dart';
import 'package:zanyar/profile_list/about_us.dart';
import 'package:zanyar/profile_list/contact_us.dart';
import 'package:zanyar/profile_list/favorites_screen.dart';
import 'package:zanyar/profile_list/notifications.dart';
import 'package:zanyar/profile_list/trip_requests.dart';
import 'package:zanyar/theme/theme_controller.dart';
import 'package:zanyar/widgets/auth_toggles.dart';

const Color _terracotta = Color(0xFFB76E50);
const Color _teal = Color(0xFF1F4E4C);

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final themeCtrl = Get.find<ThemeController>();
  final localeCtrl = Get.find<LocaleController>();
  final appCtrl = Get.find<AppController>();

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');

    Get.offAllNamed('/loginScreen');
  }

  void _confirmLogout() {
    Get.dialog(
      AlertDialog(
        title: Text('sign_out'.tr),
        content: Text('logout_confirm'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // closes the dialog only
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () async {
              Get.back(); // close the dialog first
              await _logout();
            },
            child: Text(
              'sign_out'.tr,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile'.tr,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.6,
                          color: isDark ? Colors.grey[400] : _terracotta,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Account'.tr,
                        style: GoogleFonts.lora(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : scheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const AuthToggles(),
                ],
              ),
            ),
            const Divider(color: Color(0xFF1F4E4C)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  // User card
                  const Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('H')),
                      title: Text('Hozan Issa'),
                      subtitle: Text('hozan@example.com'),
                    ),
                  ),

                  // Language toggle
                  Card(
                    child: ListTile(
                      title: Text('language'.tr),
                      subtitle: Obx(
                        () => Text(
                          localeCtrl.isKurdish.value ? 'کوردی' : 'English',
                        ),
                      ),
                      trailing: Obx(
                        () => Switch(
                          value: localeCtrl.isKurdish.value,
                          onChanged: (v) => localeCtrl.setLanguage(
                            v ? LocaleController.ckb : LocaleController.en,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Theme toggle
                  Card(
                    child: ListTile(
                      title: Text('dark_mode'.tr),
                      trailing: Obx(
                        () => Switch(
                          value: themeCtrl.themeMode.value == ThemeMode.dark,
                          onChanged: (_) => themeCtrl.toggle(),
                        ),
                      ),
                    ),
                  ),

                  // Favorites – shows count badge
                  Obx(
                    () => Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Text('favorites'.tr),
                        leading: Icon(Icons.favorite, color: scheme.primary),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (appCtrl.favoriteSiteIds.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${appCtrl.favoriteSiteIds.length}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 4),
                            Icon(Icons.chevron_right, color: scheme.primary),
                          ],
                        ),
                        onTap: () => Get.to(() => const FavoritesScreen()),
                      ),
                    ),
                  ),

                  // Trip requests – shows count badge
                  Obx(
                    () => Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Text('trip_requests'.tr),
                        leading: Icon(Icons.pending, color: scheme.primary),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (appCtrl.bookings.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _teal.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${appCtrl.bookings.length}',
                                  style: const TextStyle(
                                    color: _teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 4),
                            Icon(Icons.chevron_right, color: scheme.primary),
                          ],
                        ),
                        onTap: () => Get.to(() => const TripRequests()),
                      ),
                    ),
                  ),

                  // Notifications – shows unread count
                  Obx(
                    () => Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Text('notifications'.tr),
                        leading: Icon(
                          Icons.notifications,
                          color: scheme.primary,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (appCtrl.notifications.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _terracotta.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${appCtrl.notifications.length}',
                                  style: const TextStyle(
                                    color: _terracotta,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 4),
                            Icon(Icons.chevron_right, color: scheme.primary),
                          ],
                        ),
                        onTap: () => Get.to(() => const Notifications()),
                      ),
                    ),
                  ),
                  //Contact us page goes here
                  Card(
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text('Contact us'.tr),
                      leading: Icon(
                        Icons.quick_contacts_dialer,
                        color: scheme.primary,
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: scheme.primary,
                      ),

                      onTap: () => Get.to(() => ContactUs()),
                    ),
                  ),
                  //About us page goes here
                  Card(
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text('About us'.tr),
                      leading: Icon(Icons.info, color: scheme.primary),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: scheme.primary,
                      ),

                      onTap: () => Get.to(() => AboutUs()),
                    ),
                  ),
                  //Sign out option goes here at the end of the profile list
                  Card(
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onTap: () => _confirmLogout(),
                      title: Text(
                        'sign_out'.tr,
                        style: const TextStyle(color: Colors.red),
                      ),
                      leading: const Icon(Icons.logout, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BNB(currentIndex: 3),
    );
  }
}
