import 'package:flutter/material.dart';
import 'package:genesiswallet/features/wallet/screens/createwallet/createwallet.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  /// Varibale
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  ///Update Current index when Page Scroll
  void UpdatePageIndicator(index) => currentPageIndex.value = index;

  /// jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  /// Update Current index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      Get.offAll(const CreateWallet());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  /// Update Current index & jump to the last Page
  void SkiPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }

  //
}
