import 'package:genesiswallet/utils/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../utils/http/models/registrationmodel.dart';

class CreatePasswordController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var pin = ''.obs;
  var nickname = ''.obs;

  Future<void> registerUser() async {
    isLoading.value = true;
    errorMessage.value = '';

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var request = http.Request(
        'POST', Uri.parse('${APIConstants.baseUrl}/auth/register'));
    request.bodyFields = {
      'phrase':
          'every least seems glovesthat golden cheerfully latitude better havent think shall nothing longitude scale them',
      'device_id':
          'Iphone 14', // Assuming static for now, you can update this dynamically
      'pin': pin.value,
      'nickname': nickname.value,
      'phrase_type': 'App',
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var data = registerDataModelFromJson(responseBody);
        // Handle the response, for example, navigate to the next screen or show a success message
        print('Registration successful');
      } else {
        errorMessage.value = response.reasonPhrase ?? 'Error occurred';
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      errorMessage.value = 'Failed to register: $e';
      print('Failed to register: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
