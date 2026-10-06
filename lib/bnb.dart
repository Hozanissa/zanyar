import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'archive.dart';
import 'home_screen.dart';
import 'map_screen.dart';
import 'profile.dart';

class BNB extends StatefulWidget {
  const BNB({super.key});

  @override
  State<BNB> createState() => _BNBState();
}

class _BNBState extends State<BNB> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      items: [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Map', icon: Icon(Icons.map)),
        BottomNavigationBarItem(label: 'Archive', icon: Icon(Icons.shelves)),
        BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)),
      ],
      type: BottomNavigationBarType.fixed,
      onTap: (c) {
        setState(() {
          index = c;

          if (index == 0) {
            Get.to(
              HomeScreen(getData: "hozanissa98@gmail.com", getPass: "123456"),
            );
          } else if (index == 1) {
            Get.to(MapScreen());
          } else if (index == 2) {
            Get.to(Archive());
          } else {
            Get.to(Profile());
          }
        });
      },
      backgroundColor: Colors.grey[300],
    );
  }
}
