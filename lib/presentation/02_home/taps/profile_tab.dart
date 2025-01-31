import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/extensions.dart';
import '../../../app/functions.dart';
import '../../../domain/entities/auth_entity.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/routes_manager.dart';
import '../../01_auth_screens/bloc/auth_bloc.dart';
import '../widgets/edit_button.dart';
import '../widgets/info_title.dart';
import '../widgets/setting_row.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    AuthenticationEntity authEntity = context.read<AuthBloc>().authObj!;
    return Scaffold(
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
                  child: Icon(
                    Icons.person,
                    size: screenWidth * 0.15,
                    color: Colors.white,
                  ),
                ),
                Positioned.fill(
                  child: EditButton(
                    onTap: () {},
                  ),
                ),
              ],
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
