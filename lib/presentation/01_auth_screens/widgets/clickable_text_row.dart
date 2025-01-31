import 'package:flutter/material.dart';
import '../../../app/functions.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/styles_manager.dart';

class ClickableTextRow extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  final VoidCallback onTap;
  const ClickableTextRow({
    super.key,
    required this.firstLabel,
    required this.secondLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Text.rich(
          TextSpan(children: [
            TextSpan(
              text: firstLabel,
              style: Styles.style12Medium(),
            ),
            TextSpan(
              text: secondLabel,
              style: Styles.style14Medium().copyWith(
                  color: isLightTheme(context)
                      ? ColorsManager.darkGreen
                      : ColorsManager.lightOrange),
            ),
          ]),
        ),
      ),
    );
  }
}
