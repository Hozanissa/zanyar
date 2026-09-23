import 'package:flutter/material.dart';

class BMB extends StatefulWidget {
  const new({super.key});

  @override
  State<BMB> createState() => _BMBState();
}

class _BMBState extends State<BMB> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(label: 'home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'map', icon: Icon(Icons.map)),
          BottomNavigationBarItem(label: 'archive', icon: Icon(Icons.shelves)),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (c) {
          setState(() {
            index = c;
          });
        },
        backgroundColor: Colors.green,
      ),
    );
  }
}
