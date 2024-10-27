// Main Flutter material package import
import 'package:flutter/material.dart';

// Importing screen files used in the app
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/enter_new_password_screen.dart';
import 'screens/password_reset_success_screen.dart';
import 'screens/setup_profile_screen.dart';
import 'screens/education_details_screen.dart';
import 'screens/avatar_selection_screen.dart';
import 'screens/home_tab.dart'; // Home screen with tabs
import 'screens/notification_screen.dart';
import 'screens/skills_assessment_screen.dart';
import 'screens/create_post_screen.dart'; 
import 'screens/my_job_tab.dart'; // Import MyJobTab
import 'screens/settings_screen.dart'; // Import SettingsScreen
import 'screens/change_password_screen.dart'; // Import ChangePasswordScreen

// Main entry point of the Flutter application
void main() {
  runApp(const MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  // Define route names as constants for easy access
  static const String splashRoute = '/splash';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgot_password';
  static const String enterNewPasswordRoute = '/enter_new_password';
  static const String passwordResetSuccessRoute = '/password_reset_success';
  static const String setupProfileRoute = '/setup_profile';
  static const String homeRoute = '/home'; // HomeTab as main screen
  static const String notificationsRoute = '/notifications';
  static const String skillsAssessmentRoute = '/skills_assessment';
  static const String educationDetailsRoute = '/education_details';
  static const String avatarSelectionRoute = '/avatar_selection';
  static const String createPostRoute = '/create_post'; // New route for CreatePostScreen
  static const String myJobRoute = '/my_job'; // New route for MyJobTab
  static const String settingsRoute = '/settings'; // New route for SettingsScreen
  static const String changePasswordRoute = '/change_password'; // New route for ChangePasswordScreen

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner in release
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary theme color
        scaffoldBackgroundColor: Colors.white, // Default scaffold background
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: splashRoute, // Initial route on app launch
      routes: {
        // Named routes for navigation
        splashRoute: (context) => const SplashScreen(),
        onboardingRoute: (context) => const OnboardingScreen(),
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const RegisterScreen(),
        forgotPasswordRoute: (context) => const ForgotPasswordScreen(),
        enterNewPasswordRoute: (context) => const EnterNewPasswordScreen(),
        passwordResetSuccessRoute: (context) => const PasswordResetSuccessScreen(),
        setupProfileRoute: (context) => const SetupProfileScreen(),
        homeRoute: (context) => const HomeTab(), // HomeTab as main screen
        notificationsRoute: (context) => const NotificationScreen(),
        skillsAssessmentRoute: (context) => const SkillsAssessmentScreen(),
        createPostRoute: (context) => const CreatePostScreen(), // New route for CreatePostScreen
        myJobRoute: (context) => const MyJobTab(), // New route for MyJobTab
        settingsRoute: (context) => const SettingsScreen(), // New route for SettingsScreen
        changePasswordRoute: (context) => const ChangePasswordScreen(), // New route for ChangePasswordScreen
      },
      onGenerateRoute: (settings) {
        // Routes that require dynamic parameters
        if (settings.name == educationDetailsRoute) {
          return MaterialPageRoute(
            builder: (context) => const EducationDetailsScreen(currentStep: 2),
          );
        } else if (settings.name == avatarSelectionRoute) {
          return MaterialPageRoute(
            builder: (context) => const AvatarSelectionScreen(currentStep: 3),
          );
        }
        return null;
      },
      onUnknownRoute: (settings) {
        // Fallback for undefined routes
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('404: Page not found'), // Displayed if route is not found
            ),
          ),
        );
      },
    );
  }
}
