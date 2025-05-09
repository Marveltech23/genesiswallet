import 'package:genesiswallet/features/wallet/screens/createwallet/create_password.dart';
import 'package:genesiswallet/utils/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/http/models/createpasscodemodel.dart';

class WalletController extends GetxController {
  var isLoading = false.obs;
  var welcomeResponse = Rxn<Welcome>();
  var errorMessage = ''.obs;
  var selectedPhrases = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFromSharedPreferences();
  }

  Future<void> fetchWelcomeResponse() async {
    isLoading.value = true;
    errorMessage.value = '';

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var request = http.Request(
        'GET', Uri.parse('${APIConstants.baseUrl}/auth/get-phrase'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Welcome welcomeData = welcomeFromJson(responseBody);
        welcomeResponse.value = welcomeData;
        await _saveToSharedPreferences(welcomeData);
      } else {
        errorMessage.value = response.reasonPhrase ?? 'Unknown error occurred';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveToSharedPreferences(Welcome welcomeData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('welcomeData', welcomeToJson(welcomeData));
  }

  Future<void> loadFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? welcomeDataString = prefs.getString('welcomeData');
    if (welcomeDataString != null) {
      welcomeResponse.value = welcomeFromJson(welcomeDataString);
    } else {
      fetchWelcomeResponse();
    }
  }

  void addPhrase(String phrase) {
    if (!selectedPhrases.contains(phrase)) {
      selectedPhrases.add(phrase);
    }
  }

  void removePhrase(String phrase) {
    selectedPhrases.remove(phrase);
  }

  void navigateToCreatePassword() {
    Get.to(() => CreatePassword(selectedPhrases: selectedPhrases.join(' ')));
  }
}
