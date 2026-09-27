import 'package:flutter/material.dart';

import 'bnb.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: const BNB());
  }
}
