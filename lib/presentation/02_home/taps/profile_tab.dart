import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/di.dart';
import '../../../app/extensions.dart';
import '../../../app/functions.dart';
import '../../../app/image_service.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/routes_manager.dart';
import '../../01_auth_screens/bloc/auth_bloc.dart';
import '../widgets/edit_button.dart';
import '../widgets/info_title.dart';
import '../widgets/setting_row.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _imageService = instance<ImageService>();
  File? _currentImage;
  File? _newImage;
  String? _imageBase64;

  @override
  void initState() {
    super.initState();
    final authEntity = context.read<AuthBloc>().authObj!;
    _convertToFile(authEntity.photo); // Convert Base64 to File
  }

  // Pick an image and update the state
  Future<void> _pickImage() async {
    File? pickedImage = await _imageService.pickImage(ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _newImage = pickedImage;
      });
      _imageBase64 = await _imageService.convertFileToBase64(_newImage);
    } else {
      _imageBase64 = null;
    }
  }

  // delete the image and update the state
  Future<void> _deleteImage() async {
    _newImage = _currentImage;
    setState(() {
      _currentImage = null;
    });
    _imageBase64 = null;
  }

  Future<void> _convertToFile(String? base64String) async {
    if (base64String == null || base64String.isEmpty) return;
    // Convert Base64 back to File
    File? newFile = await _imageService.convertBase64ToFile(base64String);
    if (newFile != null) {
      setState(() {
        _currentImage = newFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16.0,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    await _pickImage();
                    if (context.mounted && _imageBase64 != null) {
                      context
                          .read<AuthBloc>()
                          .add(UpdatePhotoRequested(photo: _imageBase64));
                    }
                  },
                  child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                    if (state is UpdatePhotoFailure) {
                      showToast(state.errMessage, ColorsManager.softRed);
                    }
                    if (state is UpdatePhotoSuccess) {
                      setState(() {
                        _currentImage = _newImage;
                      });
                    }
                    if (state is DeletePhotoFailure) {
                      showToast(state.errMessage, ColorsManager.softRed);
                      setState(() {
                        _currentImage = _newImage;
                      });
                    }
                  }, builder: (context, state) {
                    if (state is UpdatePhotoLoading ||
                        state is DeletePhotoLoading) {
                      return CircleAvatar(
                        radius: 70,
                        backgroundColor: ColorsManager.oliveGreen,
                        child: CircularProgressIndicator(
                          color: ColorsManager.white,
                          strokeAlign:
                              CircularProgressIndicator.strokeAlignInside,
                        ),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 70,
                        backgroundColor: ColorsManager.oliveGreen,
                        backgroundImage: _currentImage == null
                            ? null
                            : FileImage(_currentImage!),
                        child: _currentImage == null
                            ? const Icon(Icons.camera_alt,
                                size: 40, color: ColorsManager.white)
                            : null,
                      );
                    }
                  }),
                ),
                Positioned.fill(
                  child: EditButton(
                    icon: Icons.delete_forever,
                    onTap: () {
                      if (_currentImage != null) {
                        _deleteImage();
                        context.read<AuthBloc>().add(DeletePhotoRequested());
                      }
                    },
                  ),
                ),
              ],
            ),
            Column(
              spacing: 20,
              children: [
                InfoTitle(
                  title: context.tr("taps.profileFullName"),
                  value: context.watch<AuthBloc>().authObj!.name,
                ),
                InfoTitle(
                  title: context.tr("taps.profilePhoneNumber"),
                  value: context.watch<AuthBloc>().authObj!.phone.orEmpty(),
                ),
                InfoTitle(
                  title: context.tr("taps.profileEmail"),
                  value: context.watch<AuthBloc>().authObj!.email,
                ),
              ],
            ),
            EditButton(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.editUserRoute,
                );
              },
            ),
            Spacer(),
            SettingRow(
              label: context.tr('language'),
              isLanguage: true,
            ),
            SettingRow(
              label: context.tr('theme'),
              isLanguage: false,
            ),
            // logout button
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.signUpRoute,
                    (route) => false, // This clears the stack
                  );
                }
                if (state is LogoutFailure) {
                  showToast(state.errMessage, ColorsManager.softRed);
                }
              },
              builder: (context, state) {
                if (state is LogoutLoading) {
                  return ElevatedButton(
                      onPressed: null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          Text(tr("taps.profileLogout")),
                          CircularProgressIndicator(
                            color: ColorsManager.white,
                            strokeAlign:
                                CircularProgressIndicator.strokeAlignInside,
                          ),
                        ],
                      ));
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                  child: Text(tr("taps.profileLogout")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
