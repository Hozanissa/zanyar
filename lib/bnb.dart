import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zanyar_app/archive.dart';
import 'package:zanyar_app/home_screen.dart';
import 'package:zanyar_app/map_screen.dart';
import 'package:zanyar_app/profile.dart';

class BNB extends StatelessWidget {
  final int currentIndex;

  const BNB({super.key, this.currentIndex = 0});

  void _onItemTapped(int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Get.off(() => HomeScreen(), transition: Transition.noTransition);
        break;
      case 1:
        Get.off(() => const MapScreen(), transition: Transition.noTransition);
        break;
      case 2:
        Get.off(() => const Archive(), transition: Transition.noTransition);
        break;
      case 3:
        Get.off(() => const Profile(), transition: Transition.noTransition);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const terracotta = Color(0xFFC4704B);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2220) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? const Color(0xFF2B3633) : const Color(0xFFE8E2DC),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDark ? const Color(0xFF1A2220) : Colors.white,
        selectedItemColor: terracotta,
        unselectedItemColor: isDark
            ? Colors.grey[500]
            : const Color(0xFF8C8680),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map_outlined),
            activeIcon: const Icon(Icons.map),
            label: 'map'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.auto_stories_outlined),
            activeIcon: const Icon(Icons.auto_stories),
            label: 'archive'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: 'profile'.tr,
          ),
        ],
      ),
    );
  }
}
