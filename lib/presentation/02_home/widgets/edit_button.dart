import 'package:flutter/material.dart';
import '../../resourses/colors_manager.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onTap;
  const EditButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: CircleAvatar(
        backgroundColor: ColorsManager.paleYellow,
        child: IconButton(
          icon: Icon(
            Icons.edit,
            color: ColorsManager.mediumGreen,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
