import 'dart:async';
import 'package:flutter/material.dart';
import 'package:salon_appointment_app/screens/bottom_nav.dart';
import 'package:salon_appointment_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNav()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff156778),
      body: Center(child: Image.asset('assets/title.png', fit: BoxFit.contain)),
    );
  }
}
