import 'package:flutter/material.dart';
import 'package:genesiswallet/cusombutton.dart';
import 'package:genesiswallet/features/wallet/screens/createwallet/confirm_secret_phase.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class EnterPassword extends StatelessWidget {
  const EnterPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(CreatePasswordController());

    return Scaffold(
      backgroundColor: MColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Msizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Row(
                children: [
                  Text(
                    'Enter Passcode',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MColors.subprimaryColor,
                ),
                child: TextFormField(
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Passcode',
                  ),
                ),
              ),
              const SizedBox(
                height: Msizes.SpaceBtwItems,
              ),
              // Createpassword(controller: controller),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: CustomElevatedButton(
          onPressed: () => Get.to(() => const ConfirmSecretPhrase()),
          text: 'Next',
          gradient: MColors.linerGradient,
        ),
      ),
    );
  }
}
