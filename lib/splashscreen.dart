import 'package:flutter/material.dart';
import 'package:genesiswallet/features/authentication/screens/onboarding/onboarding.dart';
import 'package:genesiswallet/features/wallet/screens/login/login.dart';
import 'package:genesiswallet/navigationmenu.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/constants/images_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      // Navigate to the respective screen after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (token != null) {
          // Navigate to NavigationMenu if the token exists
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const LoginScreen(
                      pin: '',
                    )),
          );
        } else {
          // Navigate to OnBoardingScreen if no token exists
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
          );
        }
      });
    } catch (e) {
      // Handle any errors during SharedPreferences access
      print('Error loading token: $e');

      // Optionally navigate to OnBoardingScreen in case of error
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            MImage.lightAppLogo, // Make sure the image asset path is correct
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
