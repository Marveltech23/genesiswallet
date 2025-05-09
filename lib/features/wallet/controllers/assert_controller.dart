import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:genesiswallet/utils/constants/api_constants.dart';
import 'package:genesiswallet/utils/http/models/assetnetwork.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../navigationmenu.dart';

class AssetController extends GetxController {
  var assets = <AssetData>[].obs;
  var selectedAssetId = ''.obs;
  var selectedAssetAddress = ''.obs;
  var selectedNetworkId = ''.obs;
  var selectedNetworkAddress = ''.obs;
  var isLoading = false.obs;

  late TextEditingController amountController;
  late TextEditingController toAddressController;

  @override
  void onInit() {
    super.onInit();
    fetchAssets();

    amountController = TextEditingController();
    toAddressController = TextEditingController();
  }

  @override
  void onClose() {
    amountController.dispose();
    toAddressController.dispose();
    super.onClose();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchAssets() async {
    isLoading.value = true;
    String? token = await _getToken();

    if (token == null || token.isEmpty) {
      print('Token not found');
      isLoading.value = false;
      return;
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.Request(
        'GET', Uri.parse('${APIConstants.baseUrl}/user-addresses'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final String responseBody = await response.stream.bytesToString();
        final assetResponse = AssetResponse.fromJson(json.decode(responseBody));
        assets.assignAll(assetResponse.data);
      } else {
        print('Failed to load assets: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching assets: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendAsset(String fromAssetId, String fromAddress,
      String toAssetId, String toAddress, String amount) async {
    isLoading.value = true;
    String? token = await _getToken();

    if (token == null || token.isEmpty) {
      print('Token not found');
      isLoading.value = false;
      return;
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };
    var request =
        http.Request('POST', Uri.parse('${APIConstants.baseUrl}/send-asset'));
    request.bodyFields = {
      'from': fromAssetId,
      'from_address': fromAddress,
      'to': toAssetId,
      'to_address': toAddress,
      'amount': amount,
      'network_address': selectedNetworkAddress.value, // Add network address
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      isLoading.value = false;
      if (response.statusCode == 200) {
        print('Asset sent successfully');
        showSuccessDialog();
        clearFormFields();
      } else {
        print('Failed to send asset');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
    }
  }

  void showSuccessDialog() {
    Get.defaultDialog(
      title: 'Success',
      middleText: 'Asset sent successfully',
      textConfirm: 'OK',
      onConfirm: () {
        // Get.back();
        Get.to(() => const NavigationMenu()); // Navigate to NavigationMenu
      },
    );
  }

  void clearFormFields() {
    amountController.clear();
    toAddressController.clear();
    selectedAssetId.value = '';
    selectedAssetAddress.value = '';
    selectedNetworkId.value = '';
    selectedNetworkAddress.value = '';
  }
}
