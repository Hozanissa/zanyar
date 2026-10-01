import 'package:flutter/material.dart';
import 'package:zanyar_app/admin/admin_panel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1F4E4C)),
        useMaterial3: true,
      ),
      home: AdminPanel(),
    );
  }
}
