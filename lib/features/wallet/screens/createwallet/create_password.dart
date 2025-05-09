import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesiswallet/cusombutton.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'nickname.dart';

class CreatePassword extends StatefulWidget {
  final String selectedPhrases;

  const CreatePassword({Key? key, required this.selectedPhrases})
      : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final TextEditingController passcodeController = TextEditingController();

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
                'Create Password',
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
                  controller: passcodeController,
                  cursorColor: MColors.white,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: MColors.subprimaryColor,
                    contentPadding: EdgeInsets.all(13.5),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),

              // Container(
              //         height: 45,
              //         width: double.infinity,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: MColors.subprimaryColor,
              //         ),
              //         child: TextFormField(
              //           // controller: nicknameController,
              //           cursorColor: MColors.white,
              //           decoration: const InputDecoration(
              //             contentPadding: EdgeInsets.all(16),
              //             floatingLabelBehavior: FloatingLabelBehavior.never,
              //             labelText: 'Enter nickname here',
              //             labelStyle: TextStyle(
              //               color: MColors.white,
              //             ),
              //             border: OutlineInputBorder(
              //               borderSide: BorderSide.none,
              //             ),
              //           ),
              //           style: const TextStyle(color: MColors.white),
              //         ),
              //       ),

              const SizedBox(height: Msizes.defaultSpace),
              if (widget.selectedPhrases.isNotEmpty)
                Text(
                  'Selected Phrases: ${widget.selectedPhrases}',
                  style: const TextStyle(color: Colors.white),
                ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: CustomElevatedButton(
          onPressed: () {
            final passcode = passcodeController.text;
            Get.to(() => NicknameScreen(
                pin: passcode, selectedPhrases: widget.selectedPhrases));
          },
          text: 'Next',
          gradient: MColors.linerGradient,
        ),
      ),
    );
  }
}
