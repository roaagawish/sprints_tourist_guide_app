import 'package:flutter/material.dart';
import 'colors_manager.dart';

class FontConstants {
  static const String fontMarhey = "Marhey";
}

abstract class Styles {
  static TextStyle style24Bold() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: ColorsManager.black,
    );
  }

  static TextStyle style20Bold() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: ColorsManager.black,
    );
  }

  static TextStyle style18Medium() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: ColorsManager.black,
    );
  }

  static TextStyle style14Medium() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: ColorsManager.black,
    );
  }

  static TextStyle style12Medium() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: ColorsManager.black,
    );
  }
}
