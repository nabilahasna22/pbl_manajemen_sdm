import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import file SplashScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMTI',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Panggil SplashScreen sebagai halaman pertama
    );
  }
}
