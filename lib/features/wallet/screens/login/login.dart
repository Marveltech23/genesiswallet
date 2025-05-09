import 'dart:io';
import 'dart:convert'; // For jsonDecode
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:genesiswallet/utils/constants/api_constants.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/http/models/registrationmodel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../cusombutton.dart';
import '../../../../navigationmenu.dart';
import '../../../../utils/constants/sizes.dart';

class LoginScreen extends StatefulWidget {
  final String pin;

  const LoginScreen({Key? key, required this.pin}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';
  String? _deviceId;

  RegisterDataModel? registerDataModel;

  @override
  void initState() {
    super.initState();
    _getDeviceId();
  }

  Future<void> _getDeviceId() async {
    var baseUrl = 'https://app.genesiwallet.cc/api';

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

  // Future<void> submitData({
  //   required String deviceId,
  //   required String pin,
  // }) async {
  //   try {
  //     var headers = {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //     };

  //     var request = http.Request(
  //       'POST',
  //       Uri.parse('${APIConstants.baseUrl}/auth/login'),
  //     );

  //     request.bodyFields = {
  //       'device_id': deviceId,
  //       'pin': pin,
  //     };

  //     request.headers.addAll(headers);

  //     print('Sending request with body: ${request.bodyFields}');

  //     // Send the request and capture the response
  //     http.StreamedResponse response = await request.send();

  //     // Get the full response body for logging
  //     String responseBody = await response.stream.bytesToString();
  //     print('Response: $responseBody');

  //     // Check the response status code
  //     if (response.statusCode == 200) {
  //       // Successful response
  //       var parsedData = registerDataModelFromJson(responseBody);
  //       if (parsedData != null) {
  //         setState(() {
  //           registerDataModel = parsedData;
  //         });

  //         // Extract the token
  //         String? apiToken = parsedData.data?.token;
  //         print('API Token from response: $apiToken');

  //         if (apiToken != null && apiToken.isNotEmpty) {
  //           final prefs = await SharedPreferences.getInstance();
  //           await prefs.setString('authToken', apiToken);
  //           print('API Token saved to SharedPreferences: $apiToken');
  //         } else {
  //           print('No token returned in response');
  //         }
  //       } else {
  //         print('Error parsing registerDataModel');
  //       }
  //     } else {
  //       // Log the error response
  //       print('Error: ${response.reasonPhrase}');

  //       // Handle error response parsing
  //       Map<String, dynamic> errorData = json.decode(responseBody);
  //       print('Error Response: $errorData');

  //       // Check if the error message indicates incorrect PIN
  //       if (errorData['message'] == 'Invalid credentials') {
  //         throw Exception('The PIN you entered is incorrect.');
  //       } else {
  //         throw Exception('Failed to login: ${response.reasonPhrase}');
  //       }
  //     }
  //   } catch (e) {
  //     print('An error occurred: $e');
  //     throw Get.snackbar(
  //       'Error',
  //       e.toString(), // Show the specific error message
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  // Future<String?> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('authToken');
  // }

  String device = 'Device_1729161425464';
  String uniqueDeviceId =
      "Device_" + DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> submitData({
    required String deviceId,
    required String pin,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var request = http.Request(
      'POST',
      Uri.parse('https://app.genesiwallet.cc/api/auth/login'),
    );

    request.bodyFields = {
      'device_id': device,
      'pin': pin,
    };

    request.headers.addAll(headers);

    print('Sending request with body: ${request.bodyFields}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print('Response: $responseBody');
      print(response);
      // Parse and set registerDataModel
      setState(() {
        registerDataModel = registerDataModelFromJson(responseBody);
      });

      // Extract token from the response and save it to SharedPreferences
      String token = registerDataModel!.data.token;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);
    } else {
      String errorResponse = await response.stream.bytesToString();
      print('Error Response: $errorResponse');
      print('Error: ${response.reasonPhrase}');

      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
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
                'Enter Passcode',
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
                  controller: _pinController,
                  cursorColor: MColors.white,
                  obscureText: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Passcode',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: Msizes.defaultSpace),
              // if (errorMessage.isNotEmpty)
              //   Text(
              //     '$errorMessage',
              //     style: const TextStyle(color: Colors.red),
              //   ),
              const SizedBox(height: Msizes.defaultSpace),
              if (isLoading) const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomElevatedButton(
              onPressed: () async {
                final passcode = _pinController.text;
                print('Entered passcode: $passcode'); // Debugging step
                if (passcode.isNotEmpty) {
                  if (_deviceId == null) {
                    setState(() {
                      errorMessage = 'Device ID not available';
                    });
                    return;
                  }
                  setState(() {
                    isLoading = true;
                    errorMessage = '';
                  });
                  try {
                    await submitData(
                      pin: passcode,
                      deviceId: _deviceId!,
                    );

                    setState(() {
                      isLoading = false;
                    });

                    if (registerDataModel != null) {
                      Get.snackbar(
                        'Success',
                        'Login successful',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );

                      Get.to(() => NavigationMenu(
                            user: registerDataModel!.data.user,
                          ));
                    } else {
                      setState(() {
                        errorMessage = 'Registration data is null';
                      });
                    }
                  } catch (e) {
                    setState(() {
                      isLoading = false;
                      errorMessage = e.toString();
                    });
                    // Get.snackbar(
                    //   'Error',
                    //   'Login failed: $errorMessage',
                    //   backgroundColor: Colors.red,
                    //   colorText: Colors.white,
                    // );
                  }
                } else {
                  Get.snackbar(
                    'Error',
                    'Please enter a passcode',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              text: 'Login',
              gradient: MColors.linerGradient,
            ),
            const SizedBox(height: 20),

            // CustomElevatedButton(
            //   onPressed: () async {
            //     await logout();
            //   },
            //   text: 'Logout',
            //   gradient: MColors.linerGradient,
            // ),
          ],
        ),
      ),
    );
  }
}
