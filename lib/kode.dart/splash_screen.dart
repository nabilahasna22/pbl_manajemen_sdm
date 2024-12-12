import 'package:flutter/material.dart';
import 'sign_in_page.dart'; // Import halaman login

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer untuk auto-next ke halaman login setelah 3 detik
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna background splash screen
      body: Center(
        child: Text(
          'SIMTI',
          style: TextStyle(
            fontFamily: 'Michroma',
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFFDA05),
          ),
        ),
      ),
    );
  }
}
