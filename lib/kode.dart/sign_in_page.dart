import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'sign_up_page.dart'; // Pastikan ini mengarah ke file SignUpPage Anda
import 'main.dart'; // Pastikan ini mengarah ke file HomeScreen Anda

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang untuk konsistensi
      appBar: AppBar(
        toolbarHeight: 120, // Meningkatkan tinggi AppBar
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Menyusun secara vertikal
            children: [
              SizedBox(height: 50), // Jarak dari bagian atas
              Text(
                "SIMTI",
                style: TextStyle(
                  fontFamily: 'Michroma',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFDA05),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Sign in",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hintText: "abc@email.com",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: true, // Default set ke true untuk Remember Me
                  onChanged: (value) {},
                ),
                Text("Remember Me"),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke HomeScreen saat tombol SIGN IN ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFFFFDA05), // Warna kuning sesuai #FFDA05
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("SIGN IN"),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              "OR",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.g_mobiledata),
              label: Text("Login with Google"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "Sign up",
                      style: TextStyle(
                        color: Color(
                            0xFFFFDA05), // Warna kuning untuk teks "Sign up"
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Navigate to Sign Up Page");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
