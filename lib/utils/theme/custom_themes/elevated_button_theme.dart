import 'package:flutter/material.dart';
import 'package:genesiswallet/utils/constants/colors.dart';

class MElevatedButtonTheme {
  MElevatedButtonTheme._();

  static final lightElevatedButton = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: MColors.primaryColor,
    disabledForegroundColor: Colors.white,
    disabledBackgroundColor: Colors.white,
    side: const BorderSide(color: Colors.transparent),
    padding: const EdgeInsets.symmetric(vertical: 18),
    textStyle: const TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(76)),
  ));

//dark theme
  static final darkElevatedButton = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: MColors.primaryColor,
    disabledForegroundColor: Colors.grey,
    disabledBackgroundColor: Colors.grey,
    side: const BorderSide(color: MColors.primaryColor),
    padding: const EdgeInsets.symmetric(vertical: 18),
    textStyle: const TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(76)),
  ));
}
