import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesiswallet/features/wallet/controllers/receivescreen_controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../cusombutton.dart';
import '../../../../navigationmenu.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/http/models/assetnetwork.dart';
import '../../../../utils/http/models/depositRequest.dart';
import '../../../../utils/http/models/registrationmodel.dart';

class ReceiveBarCode extends StatefulWidget {
  ReceiveBarCode({super.key});

  @override
  State<ReceiveBarCode> createState() => _ReceiveBarCodeState();
}

class _ReceiveBarCodeState extends State<ReceiveBarCode> {
  final ReceiveScreenController receiveScreenController =
      Get.put(ReceiveScreenController());
  final TextEditingController amountController =
      TextEditingController(); // Ensure this is defined
  final TextEditingController nicknameController =
      TextEditingController(); // Added controller for nickname

  bool isLoading = false;
  String errorMessage = '';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<DepositRequest> submitDepositRequest({
    required String assetId,
    required String address,
    required String amount,
  }) async {
    String? token = await _getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token not found');
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };

    var request = http.Request(
        'POST', Uri.parse('${APIConstants.baseUrl}/deposit-request'));
    request.bodyFields = {
      'asset': assetId,
      'address': address,
      'amount': amount,
    };

    request.headers.addAll(headers);

    print('Token: $token'); // Debug statement to check the token
    print('Sending deposit request with body: ${request.bodyFields}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print('Response: $responseBody');
      return depositRequestFromJson(responseBody);
    } else {
      String errorResponse = await response.stream.bytesToString();
      print('Error Response: $errorResponse');
      print('Error: ${response.reasonPhrase}');
      throw Exception(
          'Failed to submit deposit request: ${response.reasonPhrase}');
    }
  }

  // Example function to save token in SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  @override
  void dispose() {
    amountController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  RegisterDataModel? registerDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: MColors.white),
        ),
        title: Text(
          'Receive',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 15,
                color: MColors.white,
              ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const SizedBox(height: 30),
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
                    Obx(() {
                      if (receiveScreenController.assets.isEmpty) {
                        return const Center(child: Text('No assets available'));
                      }
                      return Column(
                        children: [
                          SizedBox(
                            width: 140,
                            child: DropdownButtonFormField<AssetData>(
                              value: receiveScreenController.assets.first,
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
                              items: receiveScreenController.assets
                                  .map((AssetData asset) {
                                return DropdownMenuItem<AssetData>(
                                  value: asset,
                                  child: Text(asset.network.symbol),
                                );
                              }).toList(),
                              onChanged: (AssetData? newAsset) {
                                if (newAsset != null) {
                                  receiveScreenController.selectedAssetId
                                      .value = newAsset.network.id.toString();
                                  receiveScreenController.selectedAssetAddress
                                      .value = newAsset.address;
                                  receiveScreenController.sendAsset(
                                    newAsset.network.id
                                        .toString(), // fromAssetId
                                    newAsset.address, // fromAddress
                                    newAsset.network.id.toString(), // toAssetId
                                    newAsset.address, // toAddress
                                    '1', // amount
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                              height:
                                  20), // Add some spacing between the dropdown and the asset address
                        ],
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 30),
                Obx(() {
                  final selectedAssetAddress =
                      receiveScreenController.selectedAssetAddress.value;
                  if (selectedAssetAddress.isNotEmpty) {
                    return Column(
                      children: [
                        const Text('Address:',
                            style: TextStyle(color: Colors.white)),
                        Text(selectedAssetAddress,
                            style: const TextStyle(color: Colors.white)),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: selectedAssetAddress));
                            Get.snackbar(
                              'Copied',
                              'Address copied to clipboard',
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          },
                          icon: const Icon(Iconsax.copy, color: MColors.white),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox(); // Return an empty SizedBox if no address is selected
                  }
                }),
                const SizedBox(height: 20),
                const SizedBox(height: 250),
                CustomElevatedButton(
                  gradient: MColors.linerGradient,
                  onPressed: () {
                    final selectedAssetAddress =
                        receiveScreenController.selectedAssetAddress.value;

                    final selectedAssetId =
                        receiveScreenController.selectedAssetId.value;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.black,
                          content: Container(
                            height: 200, // Adjust the height of the dialog
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: 'Amount',
                                  ),
                                ),
                                const Divider(height: 5, color: MColors.white),
                                const SizedBox(height: 45),
                                SizedBox(
                                  width: 250,
                                  child: CustomElevatedButton(
                                    gradient: MColors.linerGradient,
                                    onPressed: () async {
                                      final amount = amountController.text;
                                      if (amount.isNotEmpty) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        try {
                                          final depositRequest =
                                              await submitDepositRequest(
                                            assetId: selectedAssetId,
                                            address: selectedAssetId,
                                            amount: amount,
                                          );

                                          setState(() {
                                            isLoading = false;
                                          });

                                          amountController
                                              .clear(); // Clear the text field
                                          Get.snackbar(
                                            'Success',
                                            'Deposit  successful',
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white,
                                          );

                                          Get.to(() => NavigationMenu());
                                        } catch (e) {
                                          setState(() {
                                            isLoading = false;
                                            errorMessage = e.toString();
                                          });

                                          // Get.to(() => NavigationMenu(
                                          //       user:
                                          //           registerDataModel.data.user,
                                          //     ));

                                          amountController
                                              .clear(); // Clear the text field even if there's an error
                                          Get.snackbar(
                                            'Error',
                                            'Deposit request failed: $errorMessage',
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                          );
                                        }
                                      } else {
                                        Get.snackbar(
                                          'Error',
                                          'Please enter the amount',
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      }
                                    },
                                    text: 'Continue',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  text: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Example function to save token in SharedPreferences
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}
