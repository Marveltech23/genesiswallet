import 'package:flutter/material.dart';
import 'package:genesiswallet/features/authentication/screens/onboarding/onboarding.dart';
import 'package:genesiswallet/splashscreen.dart';
import 'package:genesiswallet/utils/theme/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'features/wallet/screens/login/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: MAppTheme.lightTheme,
      darkTheme: MAppTheme.darkTheme,
      home: const SplashScreen(), // Always show the SplashScreen first
      routes: {
        '/onboarding': (context) => const OnBoardingScreen(),
        '/login': (context) => const LoginScreen(
              pin: '',
            ),
      },
    );
  }
}
