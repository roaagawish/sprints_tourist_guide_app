import 'package:flutter/material.dart';
import '../../../resourses/styles_manager.dart';

class InfoTitle extends StatelessWidget {
  final String title;
  final String value;
  const InfoTitle({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$title: ', style: Styles.style20Bold()),
        Expanded(
          child: Text(
            value,
            style: Styles.style18Medium(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
