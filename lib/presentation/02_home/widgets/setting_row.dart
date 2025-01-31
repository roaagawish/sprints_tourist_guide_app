import 'package:flutter/material.dart';
import '../../resourses/styles_manager.dart';
import 'language_toggle_switch.dart';
import 'theme_toggle_switch.dart';

class SettingRow extends StatelessWidget {
  final String label;
  final bool isLanguage;
  const SettingRow({super.key, required this.label, required this.isLanguage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Styles.style20Bold(),
        ),
        isLanguage ? LanguageToggleSwitch() : ThemeToggleSwitch(),
      ],
    );
  }
}
