import 'package:flutter/material.dart';

class MBottomSheetTheme {
  MBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.transparent,
    modalBackgroundColor: Colors.transparent,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
  static BottomSheetThemeData darkBottomsheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.transparent,
    modalBackgroundColor: Colors.transparent,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
