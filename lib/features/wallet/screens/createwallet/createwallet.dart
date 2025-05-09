import 'package:flutter/material.dart';
import 'package:genesiswallet/features/wallet/screens/createwallet/controller/wallet.dart';
import 'package:genesiswallet/features/wallet/screens/createwallet/create_secret_phase.dart';
import 'package:genesiswallet/features/wallet/screens/createwallet/enterpassword.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/constants/sizes.dart';
import 'package:genesiswallet/utils/http/models/createpasscodemodel.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/wallet_selection.dart';

class CreateWallet extends StatelessWidget {
  const CreateWallet({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.put(WalletController());
    // Load data from SharedPreferences when the screen is opened
    controller.loadFromSharedPreferences;

    return Scaffold(
      backgroundColor: MColors.primaryColor,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(
                child: Text('Error: ${controller.errorMessage.value}'));
          }

          if (controller.welcomeResponse.value == null) {
            return Center(child: Text('No data available'));
          }

          Welcome welcomeData = controller.welcomeResponse.value!;

          return Padding(
            padding: const EdgeInsets.all(Msizes.defaultSpace),
            child: Column(
              children: [
                const SizedBox(
                  height: Msizes.spaceBtwSections,
                ),

                // Text('Status: ${welcomeData.status}',
                //     style: TextStyle(color: Colors.white)),
                // Text('Message: ${welcomeData.message}',
                //     style: TextStyle(color: Colors.white)),
                // Text('Phrase: ${welcomeData.data.phrase}',
                //     style: TextStyle(color: Colors.white)),

                const SizedBox(
                  height: Msizes.spaceBtwSections,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const CreateSecretPhrase()),
                  child: const walletselection(
                    icon: Iconsax.add,
                    text: 'Create a new wallet',
                  ),
                ),
                const SizedBox(
                  height: Msizes.SpaceBtwItems,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const EnterPassword()),
                  child: const walletselection(
                    icon: Iconsax.receive_square,
                    text: 'Add existing wallet',
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
