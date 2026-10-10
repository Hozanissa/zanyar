import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zanyar_app/locale/locale_controller.dart';
import 'package:zanyar_app/theme/app_theme.dart';
import 'package:zanyar_app/theme/theme_controller.dart';

/// Small language + dark/light switch row for screens that have no
/// bottom navigation bar (login, register, reset password).
class AuthToggles extends StatelessWidget {
  const AuthToggles({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    final localeCtrl = Get.find<LocaleController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppTheme.teal : AppTheme.teal;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => TextButton.icon(
            onPressed: localeCtrl.toggle,
            icon: Icon(Icons.language, color: accent, size: 20),
            // Shows the language you will switch TO.
            label: Text(
              localeCtrl.isKurdish.value ? 'English' : 'کوردی',
              style: TextStyle(color: accent, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Obx(
          () => IconButton(
            tooltip: 'dark_mode'.tr,
            onPressed: themeCtrl.toggle,
            icon: Icon(
              themeCtrl.themeMode.value == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: accent,
            ),
          ),
        ),
      ],
    );
  }
}
