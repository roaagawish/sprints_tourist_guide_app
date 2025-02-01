import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

abstract class ImageService {
  Future<File?> pickImage(ImageSource imageSource);
  Future<String?> convertFileToBase64(File? file);
  Future<File?> convertBase64ToFile(String base64String);
}

class ImageServiceImpl implements ImageService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<File?> pickImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  @override
  Future<String?> convertFileToBase64(File? file) async {
    if (file == null) return null;
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  @override
  Future<File?> convertBase64ToFile(String base64String) async {
    try {
      List<int> bytes = base64Decode(base64String);
      // Get temporary directory path
      final directory = await getTemporaryDirectory();
      String filePath = '${directory.path}/profile_image.png';
      File file = File(filePath);
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      return null;
    }
  }
}
