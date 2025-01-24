import 'package:flutter/material.dart';

const String light = "light_theme";
const String dark = "dark_theme";
const String system = "system_theme";

extension LanguageTypeExtension on ThemeMode {
  String getName() {
    switch (this) {
      case ThemeMode.light:
        return light;
      case ThemeMode.dark:
        return dark;
      case ThemeMode.system:
        return system;
    }
  }
}
