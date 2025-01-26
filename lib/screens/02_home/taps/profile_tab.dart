import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/user_model.dart';
import '../../../app/app_prefs.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/routes_manager.dart';
import '../../01_auth_screens/bloc/auth_bloc.dart';
import '../../01_auth_screens/widgets/flutter_toast.dart';
import '../widgets/info_title.dart';
import '../widgets/setting_row.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String fullName = '';
  String email = '';
  String password = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    UserModel? currentUser = await AppPreferencesImpl.loadUserData();
    setState(() {
      fullName = currentUser!.fullName;
      email = currentUser.email;
      password = currentUser.password;
      phone = currentUser.phone ?? tr("taps.profileNoPhoneFound");
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16.0,
          children: [
            CircleAvatar(
              radius: screenWidth * 0.15,
              backgroundColor: Colors.lightGreen,
              child: Icon(
                Icons.person,
                size: screenWidth * 0.15,
                color: Colors.white,
              ),
            ),
            InfoTitle(
              title: context.tr("taps.profileFullName"),
              value: fullName,
            ),
            InfoTitle(
              title: context.tr("taps.profilePhoneNumber"),
              value: phone,
            ),
            InfoTitle(
              title: context.tr("taps.profileEmail"),
              value: email,
            ),
            InfoTitle(
              title: context.tr("taps.profilePassword"),
              value: '*' * password.length,
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
                  showToast(state.message, ColorsManager.oliveGreen);
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
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                  child: state.loading == true
                      ? CircularProgressIndicator(
                        color: ColorsManager.white,
                        strokeAlign: CircularProgressIndicator.strokeAlignInside,
                      )
                      : Text(context.tr("taps.profileLogout")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
