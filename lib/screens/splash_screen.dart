// Main Flutter material package import
import 'package:flutter/material.dart';
import 'dart:async';

// Stateless widget for Splash Screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Timer to navigate to the onboarding screen after a 2-second delay
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/onboarding'); // Navigates to Onboarding screen
    });

    return Scaffold(
      backgroundColor: Colors.white, // White background for Splash screen
      body: Center(
        child: Image.asset(
          'assets/logo.png',  // Path to the logo asset
          height: 150,        // Sets logo height
        ),
      ),
    );
  }
}
