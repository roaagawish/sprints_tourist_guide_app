import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/di.dart';
import '../../../app/image_service.dart';
import '../../01_auth_screens/bloc/auth_bloc.dart';
import '../../01_auth_screens/widgets/text_form_field.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/styles_manager.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullnameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  final _imageService = instance<ImageService>();
  File? _image;
  String? _imageBase64;

  // Pick an image and update the state
  Future<void> _pickImage() async {
    File? pickedImage = await _imageService.pickImage(ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
      _imageBase64 = await _imageService.convertFileToBase64(_image);
    }
  }

  Future<void> _convertToFile(String? base64String) async {
    if (base64String == null) return;
    // Convert Base64 back to File
    File? newFile = await _imageService.convertBase64ToFile(base64String);
    if (newFile != null) {
      setState(() {
        _image = newFile;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final authEntity = context.read<AuthBloc>().authObj!;
    _fullnameController = TextEditingController(text: authEntity.name);
    _emailController = TextEditingController(text: authEntity.email);
    _phoneController = TextEditingController(text: authEntity.phone);
    _convertToFile(authEntity.photo);
  }

  @override
  void dispose() {
    super.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('editUser.title'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                spacing: 16.0,
                children: [
                  Text(
                    context.tr("editUser.personalDetails"),
                    style: Styles.style24Bold(),
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: ColorsManager.oliveGreen,
                      backgroundImage:
                          _image == null ? null : FileImage(_image!),
                      child: _image == null
                          ? const Icon(Icons.camera_alt,
                              size: 40, color: ColorsManager.white)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Full name field
                  CustomTextFormField(
                    controller: _fullnameController,
                    labelText: tr("signup.fullNameLabel"),
                    prefixIcon: const Icon(Icons.person),
                    inputType: TextInputType.name,
                  ),
                  CustomTextFormField(
                    controller: _emailController,
                    labelText: tr("signup.emailLabel"),
                    prefixIcon: const Icon(Icons.alternate_email),
                    inputType: TextInputType.emailAddress,
                    enabled: false,
                  ),
                  CustomTextFormField(
                    controller: _phoneController,
                    labelText: tr("signup.phoneLabel"),
                    prefixIcon: const Icon(Icons.phone),
                    inputType: TextInputType.phone,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                    },
                    child: Text(
                      context.tr('editUser.submit'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
