import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullName') ?? 'No Name Found';
      email = prefs.getString('email') ?? 'No Email Found';
      password = prefs.getString('password') ?? 'No Password Found';
    });
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
              'Full Name',
              fullName,
              fontSize: screenWidth * 0.045,
            ),
            buildInfoTile(
              'Email',
              email,
              fontSize: screenWidth * 0.045,
            ),
            buildInfoTile(
              'Password',
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
