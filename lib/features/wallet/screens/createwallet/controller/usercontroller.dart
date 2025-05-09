// // lib/controllers/user_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:trustforge/utils/http/models/registrationmodel.dart';
// import 'package:http/http.dart' as http;

// import '../../../../../navigationmenu.dart';

// class UserController extends GetxController {
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//   var user = Rxn<User>();

//   Future<void> registerUser({
//     required String deviceId,
//     required String pin,
//     required String nickname,
//   }) async {
//     isLoading.value = true;
//     errorMessage.value = '';

//     try {
//       var request = http.Request(
//           'POST', Uri.parse('https://app.trustforge.cc/api/auth/register'));

//       request.bodyFields = {
//         'phrase': 'every least seems glovesthat golden cheerfully latitude better havent think shall nothing longitude scale them',
//         'device_id': deviceId,
//         'pin': pin,
//         'nickname': nickname,
//         'phrase_type': 'App',
//       };

//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 200) {
//         String responseBody = await response.stream.bytesToString();
//         final registerData = registerDataModelFromJson(responseBody);

//         // Save the token and nickname
//         await _saveToken(registerData.data.token);
//         await _saveNickname(nickname);

//         user.value = registerData.data.user;
//         isLoading.value = false;

//         // Navigate to another screen
//         Get.to(() => NavigationMenu());
//       } else {
//         String errorResponse = await response.stream.bytesToString();
//         throw Exception('Failed to register: ${response.reasonPhrase}\n$errorResponse');
//       }
//     } catch (e) {
//       isLoading.value = false;
//       errorMessage.value = e.toString();
//       Get.snackbar(
//         'Error',
//         'Registration failed: ${errorMessage.value}',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }

//   Future<void> _saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('token', token);
//   }

//   Future<void> _saveNickname(String nickname) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('nickname', nickname);
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/http/models/registrationmodel.dart';

class UserController extends GetxController {
  var user = Rxn<User>();

  void setUser(User userData) {
    user.value = userData;
  }

  User? getUser() {
    return user.value;
  }
}

class AnotherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    User? userData = userController.getUser();

    return Scaffold(
      appBar: AppBar(title: Text('User Data')),
      body: userData != null
          ? ListView.builder(
              itemCount: userData.assets.length,
              itemBuilder: (context, index) {
                final asset = userData.assets[index];
                return ListTile(
                  title: Text(asset.name),
                  subtitle: Text('${asset.userCoinBalance} ${asset.symbol}'),
                  trailing: Text('\$${asset.balanceDollarRate}'),
                );
              },
            )
          : Center(child: Text('No user data available')),
    );
  }
}
