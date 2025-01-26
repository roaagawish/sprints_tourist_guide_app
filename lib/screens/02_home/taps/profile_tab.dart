import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/user_model.dart';
import '../../../app/app_prefs.dart';
import '../../../resourses/routes_manager.dart';
import '../../04_profile_management/blocs/profile_bloc.dart';
import '../../04_profile_management/screens/edit_user_screen.dart';
import '../widgets/info_title.dart';
import '../widgets/setting_row.dart';

class ProfileTab extends StatelessWidget {
  late UserModel _userData;
  MemoryImage? _avatar;

  ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final screenWidth = MediaQuery.of(context).size.width;
        late final basicScreenTemplate = Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16.0,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundColor: Colors.lightGreen,
                      child: _avatar == null
                          ? Icon(
                              Icons.person,
                              size: screenWidth * 0.15,
                              color: Colors.white,
                            )
                          : ClipOval(
                              child: Image(
                                image: _avatar!,
                                width: screenWidth * 0.3,
                                height: screenWidth * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              ImagePicker()
                                  .pickImage(source: ImageSource.gallery)
                                  .then((image) {
                                context
                                    .read<ProfileBloc>()
                                    .add(UpdateAvatar(_userData.email, image));
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          InfoTitle(
                            title: context.tr("taps.profileFullName"),
                            value: _userData.fullName,
                          ),
                          InfoTitle(
                            title: context.tr("taps.profilePhoneNumber"),
                            value: _userData.phone ?? "NA",
                          ),
                          InfoTitle(
                            title: context.tr("taps.profileEmail"),
                            value: _userData.email,
                          ),
                          InfoTitle(
                            title: context.tr("taps.profilePassword"),
                            value: '*' * _userData.password.length,
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditUserScreen(
                                        userData: _userData,
                                        editUserData: (newUserData) async {
                                          context
                                              .read<ProfileBloc>()
                                              .add(UpdateProfile(newUserData));
                                          return true;
                                        },
                                        onDone: () {
                                          SchedulerBinding.instance.addPostFrameCallback((_){
                                            ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                              SnackBar(
                                                content: Text(context.tr('taps.dataUpdatedSuccessfully')),
                                                duration: Duration(seconds: 2),
                                              )
                                            );
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      )));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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
                ElevatedButton(
                  onPressed: () {
                    AppPreferencesImpl().removePrefs();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.signUpRoute,
                      (route) => false, // This clears the stack
                    );
                  },
                  child: Text(context.tr("taps.profileLogout")),
                ),
              ],
            ),
          ),
        );
        _userData = state.userData;
        _avatar = state.avatar;
        if (state is ProfileInitial) {
          return basicScreenTemplate;
        } else if (state is ProfileLoaded) {
          return basicScreenTemplate;
        } else if (state is ProfileUpdated) {
          return basicScreenTemplate;
        } else if (state is ProfileError) {
          SchedulerBinding.instance.addPostFrameCallback(
              (_) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      duration: Duration(seconds: 2),
                    ),
                  ));
          return basicScreenTemplate;
        } else if (state is ProfileLoading) {
          return Stack(
            children: [
              basicScreenTemplate,
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        } else {
          SchedulerBinding.instance.addPostFrameCallback(
              (_) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.tr('taps.unexpectedError')),
                      duration: Duration(seconds: 2),
                    ),
                  ));
          return basicScreenTemplate;
        }
      },
    );
  }
}
