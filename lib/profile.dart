import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zanyar_app/locale/locale_controller.dart';
import 'package:zanyar_app/theme/theme_controller.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final themeCtrl = Get.find<ThemeController>();
  final localeCtrl = Get.find<LocaleController>();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('account'.tr, style: TextStyle(color: Colors.grey[400])),
                  Text(
                    'profile'.tr,
                    style: const TextStyle(
                      color: Color(0xFFC4704B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF1F4E4C)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
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
                          onChanged: (isKurdish) {
                            localeCtrl.setLanguage(
                              isKurdish
                                  ? LocaleController.ckb
                                  : LocaleController.en,
                            );
                          },
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

                  Card(
                    child: ListTile(
                      title: Text('favorites'.tr),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('trip_requests'.tr),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('notifications'.tr),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'sign_out'.tr,
                        style: const TextStyle(color: Colors.red),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
