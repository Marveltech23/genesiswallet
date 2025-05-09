import 'package:flutter/material.dart';
import 'package:genesiswallet/utils/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/http/models/registrationmodel.dart';

class NicknameController extends GetxController {
  final TextEditingController nicknameController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<RegisterDataModel> submitData({
    String phrase =
        'every least seems glovesthat golden cheerfully latitude better havent think shall nothing longitude scale them',
    String deviceId = 'Iphone 14',
    required String pin,
    required String nickname,
    String phraseType = 'App',
  }) async {
    try {
      isLoading.value = true;
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var request = http.Request(
          'POST', Uri.parse('https://app.genesiwallet.cc/api/auth/register'));

      request.bodyFields = {
        'phrase': phrase,
        'device_id': deviceId,
        'pin': pin,
        'nickname': nickname,
        'phrase_type': phraseType,
      };

      request.headers.addAll(headers);

      print('Sending request with body: ${request.bodyFields}');

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print('Response: $responseBody');
        return registerDataModelFromJson(responseBody);
      } else {
        String errorResponse = await response.stream.bytesToString();
        print('Error Response: $errorResponse');
        print('Error: ${response.reasonPhrase}');
        throw Exception('Failed to register: ${response.reasonPhrase}');
      }
    } catch (e) {
      errorMessage.value = e.toString();
      throw Exception('Failed to register: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
  }
}
