import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:genesiswallet/utils/constants/api_constants.dart';
import 'package:genesiswallet/utils/http/models/assetnetwork.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReceiveScreenController extends GetxController {
  var assets = <AssetData>[].obs;
  var selectedAssetId = ''.obs;
  var selectedAssetAddress = ''.obs;
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
    String? token = await _getToken();
    if (token == null || token.isEmpty) {
      print('Token not found');
      return;
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse('${APIConstants.baseUrl}/user-addresses');
    var response = await http.get(url, headers: headers);

    try {
      if (response.statusCode == 200) {
        final String responseBody = response.body;
        final assetResponse = AssetResponse.fromJson(json.decode(responseBody));
        assets.assignAll(assetResponse.data);
      } else {
        print('Failed to load assets: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching assets: $e');
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
    var url = Uri.parse('${APIConstants.baseUrl}/send-asset');
    var body = {
      'from': fromAssetId,
      'from_address': selectedAssetAddress.value,
      'to': toAssetId,
      'to_address': toAddress,
      'amount': amount,
    };

    try {
      var response = await http.post(url, headers: headers, body: body);
      isLoading.value = false;
      if (response.statusCode == 200) {
        print('Asset sent successfully');
      } else {
        print('Failed to send asset');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
    }
  }
}
