import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:genesiswallet/features/wallet/screens/swap/controller/swap.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/constants/sizes.dart';
import 'package:get/get.dart';
import '../../../../cusombutton.dart';
import '../../../../utils/http/models/assetnetwork.dart';

class SwapScreen extends StatelessWidget {
  const SwapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SwapController assetController = Get.put(SwapController());

    return Scaffold(
      backgroundColor: MColors.primaryColor,
      body: Obx(() {
        // Check if the controller is still loading
        if (assetController.isLoading.value) {
          return Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.orange), // Custom color
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Msizes.defaultSpace),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MColors.subprimaryColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    children: [
                      const Row(children: [
                        SizedBox(width: 7),
                        Text('From Wallet'),
                      ]),
                      const SizedBox(height: 10),
                      Obx(() {
                        if (assetController.assets.isEmpty) {
                          return const Center(
                              child: Text('No assets available'));
                        }
                        return Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 140,
                                  child: DropdownButtonFormField<AssetData>(
                                    value: assetController.assets.first,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: Colors.white),
                                    dropdownColor: Colors.black,
                                    items: assetController.assets
                                        .map((AssetData asset) {
                                      return DropdownMenuItem<AssetData>(
                                        value: asset,
                                        child: Text(asset.network.symbol),
                                      );
                                    }).toList(),
                                    onChanged: (AssetData? newAsset) {
                                      if (newAsset != null) {
                                        assetController.selectedAssetId.value =
                                            newAsset.network.id.toString();
                                        assetController.selectedAssetAddress
                                            .value = newAsset.address;
                                        print(
                                            'Selected From Asset ID: ${newAsset.network.id}, Address: ${newAsset.address}');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          cursorColor: MColors.white,
                          controller: assetController.amountController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            labelText: 'Amount',
                            fillColor: MColors.black,
                            filled: true,
                          ),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // The 'To Wallet' section, similar to 'From Wallet' above...
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MColors.subprimaryColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    children: [
                      const Row(children: [
                        SizedBox(width: 7),
                        Text('To Wallet'),
                      ]),
                      const SizedBox(height: 13),
                      Obx(() {
                        if (assetController.assets.isEmpty) {
                          return const Center(
                              child: Text('No assets available'));
                        }
                        return Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 140,
                                  child: DropdownButtonFormField<AssetData>(
                                    value: assetController.assets.first,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: Colors.white),
                                    dropdownColor: Colors.black,
                                    items: assetController.assets
                                        .map((AssetData asset) {
                                      return DropdownMenuItem<AssetData>(
                                        value: asset,
                                        child: Text(asset.network.symbol),
                                      );
                                    }).toList(),
                                    onChanged: (AssetData? newAsset) {
                                      if (newAsset != null) {
                                        assetController
                                                .selectedNetworkId.value =
                                            newAsset.network.id.toString();
                                        assetController.selectedNetworkAddress
                                            .value = newAsset.address;
                                        print(
                                            'Selected To Asset ID: ${newAsset.network.id}, Address: ${newAsset.address}');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: CustomElevatedButton(
          gradient: MColors.linerGradient,
          onPressed: () {
            assetController.sendAsset();
          },
          text: 'Continue',
        ),
      ),
    );
  }
}
