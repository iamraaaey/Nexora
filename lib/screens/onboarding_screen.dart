import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int currentPage = 0; // Track the current page index

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _checkOnboardingStatus(); // Check if onboarding has been completed
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

    if (onboardingComplete) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFE8F1F6),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  children: [
                    _buildOnboardingPage(
                      image: 'assets/onboarding1.png',
                      title: 'Search jobs easily & effectively',
                      description: 'Find jobs that match your skills and preferences.',
                    ),
                    _buildOnboardingPage(
                      image: 'assets/onboarding2.png',
                      title: 'Apply for jobs anytime, anywhere',
                      description: 'Access your profile and resume from any device.',
                    ),
                    _buildOnboardingPage(
                      image: 'assets/onboarding3.png',
                      title: 'Your dream job is waiting for you!',
                      description: 'Get the best offers personalized just for you.',
                      isLast: true,
                    ),
                  ],
                ),
              ),
              _buildPageIndicator(),
              const SizedBox(height: 20),
              _buildBottomNavigation(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String image,
    required String title,
    required String description,
    bool isLast = false,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInImage(
              placeholder: const AssetImage('assets/placeholder.png'),
              image: AssetImage(image),
              height: 300,
              fit: BoxFit.contain,
              fadeInDuration: const Duration(seconds: 1),
            ),
            const SizedBox(height: 40),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3C3C3C),
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF3C3C3C).withOpacity(0.8),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return SmoothPageIndicator(
      controller: _pageController,
      count: 3,
      effect: ExpandingDotsEffect(
        dotColor: Colors.grey.withOpacity(0.4),
        activeDotColor: const Color(0xFF51cacc),
        dotHeight: 8,
        dotWidth: 8,
        expansionFactor: 4,
      ),
      onDotClicked: (index) {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    final bool isLastPage = currentPage == 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isLastPage)
            TextButton(
              onPressed: _completeOnboarding,
              child: Text(
                'Skip',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF3C3C3C),
                  fontSize: 16,
                ),
              ),
            ),
          if (isLastPage)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF51cacc),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 8,
              ),
              onPressed: _completeOnboarding,
              child: Text(
                'Get Started',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
