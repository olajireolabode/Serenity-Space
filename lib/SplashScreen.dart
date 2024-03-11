import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to LoginPage after 3 seconds
    Timer(Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFB1DCEC), // Light blue background color
      body: Center(
        child: Image.asset(
          'assets/logo.png', // Replace with your actual path
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}