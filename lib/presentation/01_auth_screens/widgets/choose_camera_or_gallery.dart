import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../resourses/styles_manager.dart';

class ChooseCameraOrGallery extends StatelessWidget {
  const ChooseCameraOrGallery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 15,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            tr("taps.pick_camera_gallery"),
            style: Styles.style20Bold(),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, ImageSource.camera);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                const Icon(Icons.camera_alt),
                Text(tr("taps.profileCamera")),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, ImageSource.gallery);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                const Icon(Icons.photo_library),
                Text(tr("taps.profileGallery")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
