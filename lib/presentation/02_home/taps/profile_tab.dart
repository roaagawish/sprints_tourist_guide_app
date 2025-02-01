import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/di.dart';
import '../../../app/extensions.dart';
import '../../../app/functions.dart';
import '../../../app/image_service.dart';
import '../../../domain/entities/auth_entity.dart';
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
  File? _image;
  @override
  void initState() {
    super.initState();
    final authEntity = context.read<AuthBloc>().authObj!;
    _convertToFile(authEntity.photo); // Convert Base64 to File
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
  Widget build(BuildContext context) {
    AuthenticationEntity authEntity = context.read<AuthBloc>().authObj!;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16.0,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: ColorsManager.oliveGreen,
              backgroundImage: _image == null ? null : FileImage(_image!),
              child: _image == null
                  ? Icon(
                      Icons.person,
                      size: 40,
                      color: ColorsManager.white,
                    )
                  : null,
            ),
            Column(
              spacing: 20,
              children: [
                InfoTitle(
                  title: context.tr("taps.profileFullName"),
                  value: authEntity.name,
                ),
                InfoTitle(
                  title: context.tr("taps.profilePhoneNumber"),
                  value: authEntity.phone.orEmpty(),
                ),
                InfoTitle(
                  title: context.tr("taps.profileEmail"),
                  value: authEntity.email,
                ),
              ],
            ),
            EditButton(
              onTap: () {},
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
