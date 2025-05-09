import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesiswallet/common/widgets/appbar/customised_appbar.dart';
import 'package:genesiswallet/cusombutton.dart';
import 'package:genesiswallet/features/wallet/screens/createwallet/confirm_secret_phase.dart';
import 'package:genesiswallet/features/wallet/screens/createwallet/controller/wallet.dart';
import 'package:genesiswallet/features/wallet/screens/createwallet/widgets/item_container.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/constants/sizes.dart';
import 'package:genesiswallet/utils/constants/text_strings.dart';
import 'package:genesiswallet/utils/http/models/createpasscodemodel.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CreateSecretPhrase1 extends StatelessWidget {
  const CreateSecretPhrase1({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.put(WalletController());

    return Scaffold(
      backgroundColor: MColors.primaryColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage.value}'));
        }

        if (controller.welcomeResponse.value == null) {
          return const Center(child: Text('No data available'));
        }

        Welcome welcomeData = controller.welcomeResponse.value!;
        List<String> words = welcomeData.data.phrase.split(' ');

        return Column(
          children: [
            const SizedBox(
              height: Msizes.defaultSpace,
            ),
            const customiseAppBar(
              icon: Icons.arrow_back_ios,
              text: MText.createsecretphrase,
            ),
            Padding(
              padding: const EdgeInsets.all(Msizes.defaultSpace),
              child: Column(
                children: List.generate((words.length / 2).ceil(), (index) {
                  int firstIndex = index * 2;
                  int secondIndex = firstIndex + 1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        itemcontainer(
                            text: '${firstIndex + 1}. ${words[firstIndex]}'),
                        if (secondIndex < words.length)
                          itemcontainer(
                              text:
                                  '${secondIndex + 1}. ${words[secondIndex]}'),
                      ],
                    ),
                  );
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Copy to clipboard',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: MColors.accent),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: welcomeData.data.phrase));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Secret phrase copied to clipboard!')));
                  },
                  icon: const Icon(
                    Iconsax.copy,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: CustomElevatedButton(
          onPressed: () => Get.to(() => const ConfirmSecretPhrase()),
          text: 'Continue',
          gradient: MColors.linerGradient,
        ),
      ),
    );
  }
}
