import 'package:flutter/material.dart';
import '../../../app/functions.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/routes_manager.dart';
import '../../../resourses/styles_manager.dart';

class ClickableTextRow extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  const ClickableTextRow({
    super.key,
    required this.firstLabel,
    required this.secondLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(
          Routes.signUpRoute,
        );
      },
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
