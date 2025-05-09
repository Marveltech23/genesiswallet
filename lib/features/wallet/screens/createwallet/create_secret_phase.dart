import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:genesiswallet/cusombutton.dart';
import 'package:genesiswallet/features/wallet/screens/createwallet/create_password1.dart';
import 'package:genesiswallet/features/wallet/screens/createwallet/widgets/forgo_container.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/constants/images_string.dart';
import 'package:genesiswallet/utils/constants/sizes.dart';
import 'package:genesiswallet/utils/constants/text_strings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';

import 'package:http/http.dart' as http;
import '../../../../common/widgets/appbar/customised_appbar.dart';

class CreateSecretPhrase extends StatelessWidget {
  const CreateSecretPhrase({super.key});

  // Future getPhrase() async {
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json'
  //   };
  //   var request = http.Request(
  //       'GET', Uri.parse('https://app.trustforge.cc/api/auth/get-phrase'));

  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: Msizes.defaultSpace,
            ),
            const customiseAppBar(
              icon: Icons.arrow_back_ios,
              text: MText.createsecretphrase,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Image(image: AssetImage(MImage.createSecretPhrase)),
                const SizedBox(
                  height: Msizes.spaceBtwSections,
                ),
                Text(
                  textAlign: TextAlign.center,
                  MText.createsecretphrasetitle1,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: MColors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  textAlign: TextAlign.center,
                  MText.createsecretphrasesubtitle1,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MColors.white,
                      ),
                ),
                const SizedBox(
                  height: Msizes.SpaceBtwItems,
                ),
                const SizedBox(
                  height: 10,
                ),
                const forgecontainer(
                  text: MText.Trustforgo,
                ),
                const SizedBox(
                  height: Msizes.SpaceBtwItems,
                ),
                const forgecontainer(
                  text: MText.Trustforgo,
                ),
                const SizedBox(
                  height: Msizes.SpaceBtwItems,
                ),
                const forgecontainer(
                  text: MText.Trustforgo,
                ),
                const SizedBox(height: Msizes.spaceBtwSections),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomElevatedButton(
                      gradient: MColors.linerGradient,
                      onPressed: () =>
                          Get.to(() => const CreateSecretPhrase1()),
                      text: 'Continue'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
