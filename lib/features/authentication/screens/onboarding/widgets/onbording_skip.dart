import 'package:flutter/material.dart';
import 'package:genesiswallet/features/authentication/controller%20onboarding/onboarding_controller.dart';
import 'package:genesiswallet/utils/device/device_utility.dart';
import '../../../../../utils/constants/sizes.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MDeviceUtils.getAppBarHeight(),
        right: Msizes.defaultSpace,
        child: TextButton(
            onPressed: () => OnBoardingController.instance.SkiPage(),
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.white),
            )));
  }
}
