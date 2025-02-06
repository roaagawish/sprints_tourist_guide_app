import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../app/di.dart';
import '../../app/functions.dart';
import '../../app/image_service.dart';
import '../../app/validation_service.dart';
import '../02_home/widgets/edit_button.dart';
import '../resourses/colors_manager.dart';
import '../resourses/language_manager.dart';
import '../resourses/routes_manager.dart';
import '../resourses/styles_manager.dart';
import '../02_home/widgets/language_toggle_switch.dart';
import '../02_home/widgets/theme_toggle_switch.dart';
import 'bloc/auth_bloc.dart';
import 'widgets/clickable_text_row.dart';
import 'widgets/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _validationService = instance<IValidationService>();
  final _imageService = instance<ImageService>();
  File? _image;
  String? _imageBase64;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _emailAddressController.dispose();
    _fullNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Pick an image and update the state
  Future<void> _pickImage(ImageSource source) async {
    File? pickedImage = await _imageService.pickImage(source);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
      _imageBase64 = await _imageService.convertFileToBase64(_image);
    }
  }

  Future<void> _deleteImage() async {
    setState(() {
      _image = null;
    });
    _imageBase64 = null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
              // the user input form
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: LocalizationUtils.isCurrentLocalAr(context)
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Text(
                          tr("signup.signUp"),
                          style: Styles.style35Bold().copyWith(
                              color: isLightTheme(context)
                                  ? ColorsManager.darkGreen
                                  : ColorsManager.lightOrange),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Profile Image Picker
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // Show the bottom sheet and get the selected source
                              final ImageSource? selectedSource =
                                  await showImageSourceBottomSheet(context);
                              // If a source was selected, proceed to pick the image
                              if (selectedSource != null) {
                                await _pickImage(selectedSource);
                              }
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: ColorsManager.oliveGreen,
                              backgroundImage:
                                  _image == null ? null : FileImage(_image!),
                              child: _image == null
                                  ? const Icon(Icons.camera_alt,
                                      size: 40, color: ColorsManager.white)
                                  : null,
                            ),
                          ),
                          Positioned.fill(
                            child: EditButton(
                              icon: Icons.delete_forever,
                              onTap: () {
                                if (_image != null) {
                                  _deleteImage();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Full name field
                      CustomTextFormField(
                        controller: _fullNameController,
                        labelText: tr("signup.fullNameLabel"),
                        prefixIcon: const Icon(Icons.person),
                        inputType: TextInputType.name,
                      ),
                      const SizedBox(height: 15),
                      // Phone Number field
                      CustomTextFormField(
                        controller: _phoneController,
                        labelText: tr("signup.phoneLabel"),
                        prefixIcon: const Icon(Icons.phone),
                        inputType: TextInputType.phone,
                      ),
                      const SizedBox(height: 15),
                      // Email field
                      CustomTextFormField(
                        controller: _emailAddressController,
                        labelText: tr("signup.emailLabel"),
                        prefixIcon: const Icon(Icons.alternate_email),
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      // Password field
                      CustomTextFormField(
                        isPasswordField: true,
                        controller: _passwordController,
                        labelText: tr("signup.passwordLabel"),
                        prefixIcon: const Icon(Icons.lock_open),
                        inputType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 15),
                      // Confirm password field
                      CustomTextFormField(
                        isPasswordField: true,
                        controller: _confirmPasswordController,
                        labelText: tr("signup.confirmPasswordLabel"),
                        prefixIcon: const Icon(Icons.lock_open),
                        inputType: TextInputType.visiblePassword,
                        validator: (value) {
                          return _validationService.validateConfirmPassword(
                              value, _passwordController.text);
                        },
                      ),
                      SizedBox(height: 30),
                      // Sign Up button
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            Navigator.of(context).pushReplacementNamed(
                              Routes.homeRoute,
                            );
                          }
                          if (state is RegisterFailure) {
                            showToast(state.errMessage, ColorsManager.softRed);
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterLoading) {
                            return ElevatedButton(
                                onPressed: null,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 10,
                                  children: [
                                    Text(tr("signup.signUpButton")),
                                    CircularProgressIndicator(
                                      color: ColorsManager.white,
                                      strokeAlign: CircularProgressIndicator
                                          .strokeAlignInside,
                                    ),
                                  ],
                                ));
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(RegisterRequested(
                                      fullName: _fullNameController.text,
                                      email: _emailAddressController.text,
                                      password: _passwordController.text,
                                      phone: _phoneController.text,
                                      photo: _imageBase64,
                                    ));
                              }
                            },
                            child: Text(tr("signup.signUpButton")),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      ClickableTextRow(
                        firstLabel: tr("signup.alreadyHaveAnAccount"),
                        secondLabel: tr("signup.goToLoginPage"),
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(
                            Routes.loginRoute,
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      LanguageToggleSwitch(),
                      SizedBox(height: 10),
                      ThemeToggleSwitch(),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
