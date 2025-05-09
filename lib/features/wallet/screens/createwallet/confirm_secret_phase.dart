import 'package:flutter/material.dart';
import 'package:genesiswallet/features/wallet/screens/createwallet/create_password.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/customised_appbar.dart';
import '../../../../cusombutton.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/models/createpasscodemodel.dart';
import 'controller/wallet.dart';
import 'dart:math';

class ConfirmSecretPhrase extends StatelessWidget {
  const ConfirmSecretPhrase({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.put(WalletController());
    // controller.loadWelcomeData();

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

        // Generate shuffled list of indices
        List<int> indices = List<int>.generate(words.length, (i) => i);
        indices.shuffle(Random());

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: Msizes.defaultSpace,
                ),
                const customiseAppBar(
                  icon: Icons.arrow_back_ios,
                  text: 'Confirm secret phrase',
                ),
                Padding(
                  padding: const EdgeInsets.all(Msizes.defaultSpace),
                  child: Column(
                    children: [
                      Text(
                        'Please tap on the correct answer of the below seed phrases',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 12,
                                  color: MColors.white,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: Msizes.SpaceBtwItems,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      for (int i = 0; i < words.length; i += 3)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Word#${indices[i] + 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 13,
                                    color: MColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => _togglePhrase(
                                      controller, words[indices[i]]),
                                  child: PhraseContainer(
                                      text:
                                          '${indices[i] + 1}. ${words[indices[i]]}'),
                                ),
                                if (i + 1 < words.length) Spacer(),
                                if (i + 1 < words.length)
                                  GestureDetector(
                                    onTap: () => _togglePhrase(
                                        controller, words[indices[i + 1]]),
                                    child: PhraseContainer(
                                        text:
                                            '${indices[i + 1] + 1}. ${words[indices[i + 1]]}'),
                                  ),
                                if (i + 2 < words.length) Spacer(),
                                if (i + 2 < words.length)
                                  GestureDetector(
                                    onTap: () => _togglePhrase(
                                        controller, words[indices[i + 2]]),
                                    child: PhraseContainer(
                                        text:
                                            '${indices[i + 2] + 1}. ${words[indices[i + 2]]}'),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      Obx(() {
                        return Text(
                          'Selected Phrases: ${controller.selectedPhrases.join(' ')}',
                          style: const TextStyle(color: Colors.white),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: CustomElevatedButton(
          onPressed: () {
            final selectedPhrases = controller.selectedPhrases.join(' ');
            if (selectedPhrases.isNotEmpty) {
              Get.to(() => CreatePassword(selectedPhrases: selectedPhrases));
            } else {
              Get.snackbar(
                'Error',
                'Please select the secret phrases',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
          text: 'Continue',
          gradient: MColors.linerGradient,
        ),
      ),
    );
  }

  void _togglePhrase(WalletController controller, String phrase) {
    if (controller.selectedPhrases.contains(phrase)) {
      controller.removePhrase(phrase);
    } else {
      controller.addPhrase(phrase);
    }
  }
}

class PhraseContainer extends StatelessWidget {
  const PhraseContainer({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 115,
      decoration: BoxDecoration(
        color: MColors.subprimaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: MColors.white,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
