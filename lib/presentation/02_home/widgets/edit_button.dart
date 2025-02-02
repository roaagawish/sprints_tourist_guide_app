import 'package:flutter/material.dart';
import '../../resourses/colors_manager.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData? icon;
  const EditButton({
    super.key,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: CircleAvatar(
        backgroundColor: ColorsManager.paleYellow,
        child: IconButton(
          icon: Icon(
            icon ?? Icons.edit,
            color: ColorsManager.mediumGreen,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
