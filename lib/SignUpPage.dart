import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'home_screen.dart'; // Pastikan ini mengarah ke file HomeScreen Anda

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? selectedRole; // Menyimpan peran yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Input untuk Full Name
            TextFormField(
              decoration: InputDecoration(
                hintText: "Full Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            // Input untuk Email
            TextFormField(
              decoration: InputDecoration(
                hintText: "abc@email.com",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16),
            // Input untuk Password
            TextFormField(
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            // Input untuk Confirm Password
            TextFormField(
              decoration: InputDecoration(
                hintText: "Confirm password",
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            // Input untuk NIP
            TextFormField(
              decoration: InputDecoration(
                hintText: "NIP",
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            SizedBox(height: 16),
            // Dropdown untuk memilih peran
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Register Sebagai",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              value: selectedRole,
              items: ["Dosen", "Pimpinan"].map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedRole != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select a role")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFDA05),
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("SIGN UP"),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "Sign in",
                      style: TextStyle(
                        color: Color(0xFFFFDA05),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
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
