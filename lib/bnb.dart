import 'package:flutter/material.dart';

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
        BottomNavigationBarItem(label: 'home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'map', icon: Icon(Icons.map)),
        BottomNavigationBarItem(label: 'archive', icon: Icon(Icons.shelves)),
        BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)),
      ],
      type: BottomNavigationBarType.fixed,
      onTap: (c) {
        setState(() {
          index = c;
        });
      },
      backgroundColor: Colors.grey,
    );
  }
}
