import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors_manager.dart';
import 'styles_manager.dart';

ThemeData getlightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorsManager.white,
    primaryColor: ColorsManager.mediumBrown,

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.oliveGreen,
      titleSpacing: 0,
      elevation: 0,
      shadowColor: ColorsManager.black,
      titleTextStyle: Styles.style20Bold(),
      toolbarTextStyle: Styles.style20Bold(),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorsManager.oliveGreen, // Status bar color
        statusBarIconBrightness: Brightness.dark, // black icons
        statusBarBrightness: Brightness.light, // For iOS dark background
      ),
    ),

    // text selection theme
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorsManager.mediumBrown,
      selectionColor: ColorsManager.grey,
      // Change the handle to blue for the text form field ;)
      selectionHandleColor: ColorsManager.mediumBrown,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        //side: const BorderSide(color: ColorsManager.blue, width: 2),
        elevation: 0,
        foregroundColor: ColorsManager.white,
        backgroundColor: ColorsManager.mediumBrown,
        textStyle: Styles.style20Bold(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    ),
  );
}
