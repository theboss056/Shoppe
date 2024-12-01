import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shoppe/homescreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // Changed from 300 seconds to 3 seconds for a typical splash screen duration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cartss.jpeg'),
                fit: BoxFit.cover, // Full screen background
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
          ),
          Center(
            child: const Text(
              'Shoppe',
              style: TextStyle(
                fontFamily: 'Quicksand', // Set the font family to Quicksand
                fontSize: 48,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
