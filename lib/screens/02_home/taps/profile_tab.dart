import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../resourses/local_database.dart';
import '../../../resourses/routes_manager.dart';
import '../widgets/info_title.dart';

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
    UserModel? currentUser = await LocalDataBase.loadUserData();
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
            // Sign Up button
            ElevatedButton(
              onPressed: () {
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
  }
}
