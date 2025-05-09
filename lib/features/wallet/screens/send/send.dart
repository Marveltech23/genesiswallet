import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesiswallet/features/wallet/controllers/assert_controller.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/http/models/assetnetwork.dart';
import 'package:get/get.dart';

import '../../../../cusombutton.dart';
import '../../../../utils/constants/sizes.dart';

class SendScreen extends StatelessWidget {
  SendScreen({
    Key? key,
  }) : super(key: key);

  final AssetController assetController = Get.put(AssetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Send',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: MColors.white,
                fontSize: 15,
              ),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: MColors.white,
            )),
      ),
      backgroundColor: MColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              if (assetController.isLoading.value) {
                // Show loading indicator while waiting for data
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.orange), // Use your custom color from MColors
                  ),
                );
              }
              return Column(
                children: [
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Asset',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                      ),
                      // Check if assets are available before showing the dropdown
                      if (assetController.assets.isNotEmpty) ...[
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
                            items:
                                assetController.assets.map((AssetData asset) {
                              return DropdownMenuItem<AssetData>(
                                value: asset,
                                child: Text(asset.network.symbol),
                              );
                            }).toList(),
                            onChanged: (AssetData? newAsset) {
                              if (newAsset != null) {
                                assetController.selectedAssetId.value =
                                    newAsset.network.id.toString();
                                assetController.selectedAssetAddress.value =
                                    newAsset.address;
                              }
                            },
                          ),
                        ),
                      ] else ...[
                        const Text('No assets available'),
                      ],
                    ],
                  ),
                  const SizedBox(height: 25),
                  // Text input for wallet address
                  Container(
                    height: 60,
                    child: TextFormField(
                      controller: assetController.toAddressController,
                      cursorColor: Colors.grey,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                      decoration: InputDecoration(
                        fillColor: MColors.subprimaryColor,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        filled: true,
                        hintText: 'Input Wallet Address',
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 17,
                                  color: Colors.grey,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(height: Msizes.SpaceBtwItems),
                  Center(
                    child: Text(
                      'Enter amount',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: MColors.white,
                            fontSize: 16,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: assetController.amountController,
                      cursorColor: Colors.white,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                        DecimalTextInputFormatter(),
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: Msizes.SpaceBtwItems),
                  const SizedBox(width: 300, child: Divider(height: 3)),
                  const SizedBox(height: Msizes.SpaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Network',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                      ),
                      if (assetController.assets.isNotEmpty) ...[
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
                            items:
                                assetController.assets.map((AssetData asset) {
                              return DropdownMenuItem<AssetData>(
                                value: asset,
                                child: Text(asset.network.symbol),
                              );
                            }).toList(),
                            onChanged: (AssetData? newAsset) {
                              if (newAsset != null) {
                                assetController.selectedNetworkId.value =
                                    newAsset.network.id.toString();
                                assetController.selectedNetworkAddress.value =
                                    newAsset.address;
                              }
                            },
                          ),
                        ),
                      ] else ...[
                        const Text('No assets available'),
                      ],
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: CustomElevatedButton(
          gradient: MColors.linerGradient,
          onPressed: () {
            final amount = assetController.amountController.text;
            final toAddress = assetController.toAddressController.text;

            if (amount.isNotEmpty && toAddress.isNotEmpty) {
              assetController.sendAsset(
                assetController.selectedAssetId.value,
                assetController.selectedAssetAddress.value,
                assetController.selectedNetworkId.value,
                toAddress,
                amount,
              );
            } else {
              Get.snackbar(
                'Error',
                'Please fill all the fields',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
          text: 'Continue',
        ),
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  static const _separator = '.';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.startsWith('00')) {
      newText = newText.substring(1);
    }

    if (newText.isEmpty) {
      return TextEditingValue();
    }

    if (newText.startsWith(_separator)) {
      newText = '0' + newText;
    }

    if (newText.startsWith('0') &&
        newText.length > 1 &&
        !newText.startsWith('0$_separator')) {
      newText = newText.substring(1);
    }

    final split = newText.split(_separator);
    if (split.length > 1) {
      newText = '${split[0]}$_separator${split[1].padRight(2, '0')}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
