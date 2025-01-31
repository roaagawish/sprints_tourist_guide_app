import 'package:flutter/material.dart';

class FontConstants {
  static const String fontMarhey = "Marhey";
}

abstract class Styles {
  static TextStyle style35Bold() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 35,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle style24Bold() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle style20Bold() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle style18Medium() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle style16Medium() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle style14Medium() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle style12Medium() {
    return const TextStyle(
      fontFamily: FontConstants.fontMarhey,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
  }
}
