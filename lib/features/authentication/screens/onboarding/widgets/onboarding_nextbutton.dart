import 'package:flutter/material.dart';
import 'package:genesiswallet/features/authentication/controller%20onboarding/onboarding_controller.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../cusombutton.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_funtions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);

    return Positioned(
        left: Msizes.defaultSpace,
        right: Msizes.defaultSpace,
        bottom: MDeviceUtils.getBottomNavigationBarHeight(),
        child: CustomElevatedButton(
          gradient: MColors.linerGradient,
          onPressed: () => OnBoardingController.instance.nextPage(),
          text: 'Get Started',
        ));
  }
}
