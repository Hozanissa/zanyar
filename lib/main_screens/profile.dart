import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanyar_app/bnb.dart';
import 'package:zanyar_app/controllers/app_controller.dart';
import 'package:zanyar_app/locale/locale_controller.dart';
import 'package:zanyar_app/models/site_model.dart';
import 'package:zanyar_app/models/trip_booking.dart';
import 'package:zanyar_app/profile_list/about_us.dart';
import 'package:zanyar_app/profile_list/contact_us.dart';
import 'package:zanyar_app/screens/site_detail_screen.dart';
import 'package:zanyar_app/theme/theme_controller.dart';
import 'package:zanyar_app/widgets/auth_toggles.dart';

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
                        () => Text(localeCtrl.isKurdish.value ? 'کوردی' : 'English'),
                      ),
                      trailing: Obx(
                        () => Switch(
                          value: localeCtrl.isKurdish.value,
                          onChanged: (v) => localeCtrl.setLanguage(
                              v ? LocaleController.ckb : LocaleController.en),
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
                  Obx(() => Card(
                    child: ListTile(
                      title: Text('favorites'.tr),
                      leading: Icon(Icons.favorite, color: scheme.primary),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (appCtrl.favoriteSiteIds.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
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
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () => Get.to(() => const _FavoritesScreen()),
                    ),
                  )),

                  // Trip requests – shows count badge
                  Obx(() => Card(
                    child: ListTile(
                      title: Text('trip_requests'.tr),
                      leading: Icon(Icons.pending, color: scheme.primary),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (appCtrl.bookings.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
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
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () => Get.to(() => const _TripRequestsScreen()),
                    ),
                  )),

                  // Notifications – shows unread count
                  Obx(() => Card(
                    child: ListTile(
                      title: Text('notifications'.tr),
                      leading: Icon(Icons.notifications, color: scheme.primary),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (appCtrl.notifications.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
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
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () => Get.to(() => const _NotificationsScreen()),
                    ),
                  )),

                  Card(
                    child: ListTile(
                      title: Text('Contact us'.tr),
                      leading: Icon(Icons.quick_contacts_dialer, color: scheme.primary),
                      onTap: () => Get.to(() => ContactUs()),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('About us'.tr),
                      leading: Icon(Icons.info, color: scheme.primary),
                      onTap: () => Get.to(() => AboutUs()),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('sign_out'.tr,
                          style: const TextStyle(color: Colors.red)),
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

// ─── Favorites screen ─────────────────────────────────────────────────────────

class _FavoritesScreen extends StatelessWidget {
  const _FavoritesScreen();

  @override
  Widget build(BuildContext context) {
    final appCtrl = Get.find<AppController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF141918) : const Color(0xFFF9F6F0),
      appBar: AppBar(
        title: Text('favorites'.tr, style: GoogleFonts.lora(fontWeight: FontWeight.bold)),
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
                Text('no_favorites'.tr,
                    style: const TextStyle(color: Colors.grey, fontSize: 15)),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: CircleAvatar(
                backgroundColor: _teal.withValues(alpha: 0.1),
                child: Icon(site.icon, color: _teal, size: 20),
              ),
              title: Text(site.localizedName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(site.city.tr, style: TextStyle(color: Colors.grey[500])),
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

// ─── Trip requests screen ─────────────────────────────────────────────────────

class _TripRequestsScreen extends StatelessWidget {
  const _TripRequestsScreen();

  @override
  Widget build(BuildContext context) {
    final appCtrl = Get.find<AppController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF141918) : const Color(0xFFF9F6F0),
      appBar: AppBar(
        title: Text('trip_requests'.tr, style: GoogleFonts.lora(fontWeight: FontWeight.bold)),
        backgroundColor: isDark ? const Color(0xFF1A2220) : Colors.white,
        foregroundColor: isDark ? Colors.white : _teal,
        elevation: 0,
      ),
      body: Obx(() {
        final bookings = appCtrl.bookings;
        if (bookings.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.pending_actions, size: 56, color: Colors.grey),
                const SizedBox(height: 12),
                Text('no_trips'.tr,
                    style: const TextStyle(color: Colors.grey, fontSize: 15)),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: bookings.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (_, i) {
            final b = bookings[i];
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1C2422) : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle, color: _teal, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          b.site.localizedName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                      Text(
                        '\$${b.company.price.toInt()}',
                        style: const TextStyle(
                          color: _terracotta,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    b.company.name.tr,
                    style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 12, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(b.company.tripDate,
                          style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      const SizedBox(width: 12),
                      Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(b.company.tripType.tr,
                          style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Divider(color: isDark ? Colors.grey[800] : Colors.grey[200], height: 1),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        ),
                        icon: const Icon(Icons.cancel_outlined, size: 16),
                        label: Text(
                          'cancel_trip'.tr,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        onPressed: () => _confirmCancel(context, appCtrl, b),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  void _confirmCancel(BuildContext context, AppController appCtrl, TripBooking booking) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E2724) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'cancel_trip_confirm_title'.tr,
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        content: Text(
          'cancel_trip_confirm_msg'.trParams({'site': booking.site.localizedName}),
          style: TextStyle(
            color: isDark ? Colors.grey[300] : Colors.grey[700],
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'cancel'.tr,
              style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              appCtrl.cancelBooking(booking);
              Get.snackbar(
                'cancel_trip'.tr,
                'cancel_trip_success'.tr,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: isDark ? const Color(0xFF2C3E40) : Colors.black87,
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 3),
              );
            },
            child: Text('confirm'.tr),
          ),
        ],
      ),
    );
  }
}

// ─── Notifications screen ─────────────────────────────────────────────────────

class _NotificationsScreen extends StatelessWidget {
  const _NotificationsScreen();

  @override
  Widget build(BuildContext context) {
    final appCtrl = Get.find<AppController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF141918) : const Color(0xFFF9F6F0),
      appBar: AppBar(
        title: Text('notifications'.tr, style: GoogleFonts.lora(fontWeight: FontWeight.bold)),
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
                const Icon(Icons.notifications_none, size: 56, color: Colors.grey),
                const SizedBox(height: 12),
                Text('no_notifications'.tr,
                    style: const TextStyle(color: Colors.grey, fontSize: 15)),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: CircleAvatar(
                backgroundColor: _terracotta.withValues(alpha: 0.12),
                child: const Icon(Icons.notifications, color: _terracotta, size: 20),
              ),
              title: Text(n.message,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white : Colors.black87,
                  )),
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
