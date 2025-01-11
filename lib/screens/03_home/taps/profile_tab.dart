import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_model.dart';
import '../../../resourses/styles_manager.dart';

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
    final prefs = await SharedPreferences.getInstance();
    // Get the current logged-in user's email
    String? currentUserEmail = prefs.getString('currentUserEmail');
 
    if (currentUserEmail != null) {
      // Fetch the list of users and find the current user's data
      String? usersData = prefs.getString('users');
      if (usersData != null) {
        List<dynamic> jsonUsers = json.decode(usersData);
        List<UserModel> users =
            jsonUsers.map((jsonUser) => UserModel.fromJson(jsonUser)).toList();

        // Find the user with the current email
        UserModel? currentUser = users.firstWhere(
          (user) => user.email == currentUserEmail,
          orElse: () => UserModel(
              fullName: tr("taps.profileNoNameFound"),
              email: tr("taps.profileNoEmailFound"),
              password: tr("taps.profileNoPasswordFound")
              ),
        );

        setState(() {
          fullName = currentUser.fullName;
          email = currentUser.email;
          password = currentUser.password;
          phone = currentUser.phone ?? tr("taps.profileNoPhoneFound");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: screenWidth * 0.15,
                backgroundColor: Colors.lightGreen,
                child: Icon(
                  Icons.person,
                  size: screenWidth * 0.15,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            buildInfoTile(
              tr("taps.profileFullName"),
              fullName,
              fontSize: screenWidth * 0.045,
            ),
              buildInfoTile(
              tr("taps.profilePhoneNumber"),
              phone,
              fontSize: screenWidth * 0.045,
            ),
            buildInfoTile(
              tr("taps.profileEmail"),
              email,
              fontSize: screenWidth * 0.045,
            ),
            buildInfoTile(
               tr("taps.profilePassword"),
              '*' * password.length,
              fontSize: screenWidth * 0.045,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoTile(String title, String value, {required double fontSize}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                fontFamily: FontConstants.fontMarhey

            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  fontSize: fontSize,
                fontFamily: FontConstants.fontMarhey

              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
