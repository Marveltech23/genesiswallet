import 'package:flutter/material.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/constants/sizes.dart';
import 'package:genesiswallet/utils/device/device_utility.dart';
import 'package:genesiswallet/utils/helpers/helper_funtions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controller onboarding/onboarding_controller.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = MHelperFunction.isDarkMode(context);
    return Positioned(
        bottom: MDeviceUtils.getBottomNavigationBarHeight() + 85,
        left: Msizes.defaultSpace,
        right: Msizes.defaultSpace,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(
              activeDotColor: dark ? MColors.light : MColors.dark,
              dotHeight: 6),
        ));
  }
}
