import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:genesiswallet/features/wallet/screens/login/login.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

import '../../../../navigationmenu.dart';
import '../../../../utils/constants/api_constants.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<String> items = [
    'At Genesiswallet, we prioritize the security and privacy of our users. We implement industry-leading measures to ensure that your assets and personal information are protected at all times. Our commitment to your security and privacy is reflected in the following key features and practices:',
    'Advanced Encryption:',
    'Your private keys and sensitive data are stored using advanced encryption standards, ensuring that they are safe from unauthorized access.',
    'Privacy by Design:',
    'Genesiswallet supports features that allow you to maintain anonymity in your transactions, ensuring your financial privacy is preserved.',
    'Real-Time Monitoring and Alerts:',
    'Our systems are continuously monitored for suspicious activity, allowing us to respond promptly to potential threats.',
  ];

  final List<String> items1 = [
    'timidly alice round king some herself executed second accident except thought nervous book dont found'
  ];
  String? selectedValue;
  bool _isDropdownOpened = false;

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpened = !_isDropdownOpened;
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null) {
      // Token not found, navigate to login screen
      Get.offAll(() => LoginScreen(pin: ''));
      return;
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var request =
        http.Request('GET', Uri.parse('${APIConstants.baseUrl}/auth/logout'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print('Logout successful: $responseBody');

      // Clear the token from SharedPreferences
      await prefs.remove('authToken');

      Get.snackbar(
        'Success',
        'Logout successful',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to the login screen
      Get.offAll(() => const LoginScreen(pin: ''));
    } else {
      String errorResponse = await response.stream.bytesToString();
      print('Logout failed: $errorResponse');

      Get.snackbar(
        'Error',
        'Logout failed: $errorResponse',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      if (response.statusCode == 401) {
        // Unauthenticated, clear token and navigate to login
        await prefs.remove('authToken');
        Get.offAll(() => const LoginScreen(pin: ''));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryColor,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: MColors.white,
                fontSize: 18,
              ),
        ),
        leading: IconButton(
          onPressed: () => Get.to(() => const NavigationMenu()),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MColors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Msizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(
                height: Msizes.SpaceBtwItems,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MColors.subprimaryColor,
                  borderRadius: BorderRadius.circular(Msizes.borderRadiusSm),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    iconStyleData:
                        const IconStyleData(iconEnabledColor: Colors.white),
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: MColors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Security and Privacy',
                          style: TextStyle(
                            fontSize: 16,
                            color: MColors.white,
                          ),
                        ),
                      ],
                    ),
                    items: items
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: [
                                    'Advanced Encryption:',
                                    'Privacy by Design:',
                                    'Real-Time Monitoring and Alerts:'
                                  ].contains(item)
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {});
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 150,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: MColors.subprimaryColor,
                    borderRadius: BorderRadius.circular(0)),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          height: 30,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: MColors.subprimaryColor,
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.settings,
                                color: MColors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'See Phase',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: MColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Text(
                          'timidly alice round king some herself executed second accident except thought nervous book dont found',
                        )
                      ],
                    ),
                    Positioned.fill(
                      top:
                          37, // Adjust the top position to place the blurred container over the text
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 5.0,
                              sigmaY:
                                  5.0), // Adjust sigmaX and sigmaY for blur effect
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20)),
                            // Make the container transparent to only apply blur
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  await logout();
                },
                child: const Settingsitems(
                  text: 'Log out',
                  icon: Icons.logout,
                  icon1: Icons.arrow_forward_ios,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Settingsitems extends StatelessWidget {
  final String text;
  final IconData icon;
  final IconData icon1;

  const Settingsitems({
    Key? key,
    required this.text,
    required this.icon,
    required this.icon1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: MColors.subprimaryColor,
        borderRadius: BorderRadius.circular(Msizes.borderRadiusSm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: MColors.white),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  color: MColors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Icon(icon1, color: MColors.white),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'dart:ui';

// class CustomDropdownButton extends StatefulWidget {
//   @override
//   _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
// }

// class _CustomDropdownButtonState extends State<CustomDropdownButton> {
//   final List<String> items1 = [
//     'timidly alice round king some herself executed second accident except thought nervous book dont found'
//   ];
//   String? selectedValue;
//   bool _isDropdownOpened = false;

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'dart:ui';

// class CustomDropdownButton extends StatefulWidget {
//   @override
//   _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
// }

// class _CustomDropdownButtonState extends State<CustomDropdownButton> {
//   final List<String> items1 = [
//     'timidly alice round king some herself executed second accident except thought nervous book dont found'
//   ];
//   String? selectedValue;
//   bool _isDropdownOpened = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child:
//       ),
//     );
//   }
// }

// void main() => runApp(MaterialApp(home: CustomDropdownButton()));













// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';

// class BlurDropdown extends StatefulWidget {
//   @override
//   _BlurDropdownState createState() => _BlurDropdownState();
// }

// class _BlurDropdownState extends State<BlurDropdown> {
//   bool _isDropdownOpened = false;
//   String? selectedValue;
//   List<String> items1 = ['Option 1', 'Option 2', 'Option 3'];

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }




// import 'dart:ui';

// import 'package:flutter/material.dart';

// class BlurredContainerExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: 
//       ),
//     );
//   }
// }

// void main() => runApp(MaterialApp(home: BlurredContainerExample()));
