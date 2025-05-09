import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants/api_constants.dart';
import '../../../utils/http/models/send.dart';

class SendController extends GetxController {
  final fromController = TextEditingController();
  final fromAddressController = TextEditingController();
  final toController = TextEditingController();
  final toAddressController = TextEditingController();
  final amountController = TextEditingController();

  Rx<Send?> sendResponse = Rx<Send?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<Send?> sendAsset(String from, String fromAddress, String to,
      String toAddress, String amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print('No token found');
      return null;
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };

    var request =
        http.Request('POST', Uri.parse('${APIConstants.baseUrl}/send-asset'));

    request.bodyFields = {
      'from': from,
      'from_address': fromAddress,
      'to': to,
      'to_address': toAddress,
      'amount': amount,
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      return Send.fromJson(jsonDecode(responseBody));
    } else {
      print('Failed to send asset: ${response.reasonPhrase}');
      return null;
    }
  }

  Future<void> transferAsset() async {
    isLoading.value = true;
    errorMessage.value = '';

    final from = fromController.text;
    final fromAddress = fromAddressController.text;
    final to = toController.text;
    final toAddress = toAddressController.text;
    final amount = amountController.text;

    if (from.isEmpty ||
        fromAddress.isEmpty ||
        to.isEmpty ||
        toAddress.isEmpty ||
        amount.isEmpty) {
      isLoading.value = false;
      errorMessage.value = 'Please fill all fields';
      return;
    }

    try {
      final result = await sendAsset(from, fromAddress, to, toAddress, amount);
      sendResponse.value = result;
      isLoading.value = false;
    } catch (e) {
      errorMessage.value = 'Failed to transfer asset: ${e.toString()}';
      isLoading.value = false;
    }
  }
}
