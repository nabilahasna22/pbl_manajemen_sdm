import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'SignUpPage.dart';
import 'home_screen.dart';
import 'package:dio/dio.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController nipController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Dio dio = Dio();

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
              "Sign in",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nipController,
              decoration: InputDecoration(
                hintText: "Enter your NIP",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                loginValidation(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFDA05),
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
                        color: Color(0xFFFFDA05),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
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

  void loginValidation(BuildContext context) {
    if (nipController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter NIP")),
      );
    } else if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter password")),
      );
    } else {
      fetchLogin(context);
    }
  }

  fetchLogin(BuildContext context) async {
    try {
      var response = await dio.post(
        'http://192.168.1.11:8000/api/login',
        data: {
          "NIP": nipController.text,
          "password": passwordController.text,
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Login Berhasil"), backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(response.data['message'] ?? "Login Failed"),
              backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("An error occurred: $e"),
            backgroundColor: Colors.red),
      );
    }
  }
}
