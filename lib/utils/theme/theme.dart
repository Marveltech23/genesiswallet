import 'package:flutter/material.dart';
import 'package:genesiswallet/utils/theme/custom_themes/appbar_theme.dart';
import 'package:genesiswallet/utils/theme/custom_themes/chip_theme.dart';
import 'package:genesiswallet/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:genesiswallet/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:genesiswallet/utils/theme/custom_themes/text_field_theme.dart';
import 'package:genesiswallet/utils/theme/custom_themes/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_themes/botton_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';

class MAppTheme {
  MAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    brightness: Brightness.light,
    primaryColor: const Color(0xFF263048),
    scaffoldBackgroundColor: Colors.white,
    textTheme: MTextTheme.lightTextTheme,
    elevatedButtonTheme: MElevatedButtonTheme.lightElevatedButton,
    chipTheme: MChipTheme.lightChipTheme,
    appBarTheme: MAppBarTheme.lightAppBarTheme,
    checkboxTheme: MCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: MBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: MOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MTextformFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF263048),
    scaffoldBackgroundColor: Colors.black,
    textTheme: MTextTheme.darkTextTheme,
    elevatedButtonTheme: MElevatedButtonTheme.darkElevatedButton,
    chipTheme: MChipTheme.darkChipTheme,
    appBarTheme: MAppBarTheme.darkAppBarTheme,
    checkboxTheme: MCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: MBottomSheetTheme.darkBottomsheetTheme,
    outlinedButtonTheme: MOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MTextformFieldTheme.darkInputDecorationTheme,
  );
}
