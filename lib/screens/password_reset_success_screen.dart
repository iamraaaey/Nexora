import 'package:flutter/material.dart';

class PasswordResetSuccessScreen extends StatefulWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  _PasswordResetSuccessScreenState createState() => _PasswordResetSuccessScreenState();
}

class _PasswordResetSuccessScreenState extends State<PasswordResetSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fadeIn();
    });
  }

  void _fadeIn() {
    setState(() {
      _opacity = 1.0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Animated top image
            Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
                child: Image.asset(
                  'assets/password_reset_success_image.png',
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Animated Title with updated color
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              child: const Text(
                'Password Updated Successfully',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF51cacc),  // Updated primary color
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              child: const Text(
                'Your password has been updated successfully',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),

            // Back to Home Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  minimumSize: Size(screenWidth * 0.5, 50),
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xFF51cacc),  // Updated primary color
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
