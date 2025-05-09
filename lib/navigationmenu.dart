import 'package:flutter/material.dart';
import 'package:genesiswallet/features/wallet/screens/history/history.dart';
import 'package:genesiswallet/features/wallet/screens/home/home.dart';
import 'package:genesiswallet/features/wallet/screens/settings/settings.dart';
import 'package:genesiswallet/features/wallet/screens/swap/swap.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/helpers/helper_funtions.dart';
import 'package:genesiswallet/utils/http/models/registrationmodel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  final User? user;

  const NavigationMenu({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController(user: user));
    final darkMode = MHelperFunction.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: MColors.primaryColor,
          indicatorColor: MColors.subprimaryColor,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Iconsax.home,
                color: MColors.white,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.arrow_swap_horizontal,
                color: MColors.white,
              ),
              label: 'Swap',
            ),
            NavigationDestination(
                icon: Icon(
                  Icons.restore,
                  color: MColors.white,
                ),
                label: 'History'),
            NavigationDestination(
                icon: Icon(
                  Icons.settings,
                  color: MColors.white,
                ),
                label: 'Settings'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final User? user;
  final Rx<int> selectedIndex = 0.obs;

  NavigationController({
    this.user,
  });

  late final screens = [
    HomeScreen(user: user),
    const SwapScreen(),
    const History(),
    Settings()
  ];
}
