import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final String fullName;
  final String email;
  final String? phone;
  final String password;

  UserModel(
      {required this.fullName,
      required this.email,
      required this.password,
      this.phone});

// Convert a UserModel to a Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  // Create a UserModel from a Map (for JSON deserialization)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }
}

class LocalDataBase {
  static const String _usersKey = 'users';

// sign up and add new user to database
  static Future<String> SignUp(
      {String? phone,
      required String fullName,
      required String email,
      required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
 // Get the existing users from SharedPreferences
    String? usersData = prefs.getString(_usersKey);
    List<UserModel> users = [];
    if (usersData != null) {
      List<dynamic> jsonUsers = json.decode(usersData);
      users = jsonUsers.map((jsonUser) => UserModel.fromJson(jsonUser)).toList();
    }

    // Check if email already exists
    if (users.any((user) => user.email == email)) {
      return "This email is already registered!";
    }

    // Add new user
    UserModel newUser = UserModel(
      fullName: fullName,
      email: email,
      password: password,
      phone: phone,
    );
    users.add(newUser);

    // Save updated user list
    await prefs.setString(
        _usersKey, json.encode(users.map((u) => u.toJson()).toList()));
    return "User added successfully!";
  }

// login to already registerd user
  static Future<String> Login(
      {required String email, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // String? savedEmail = prefs.getString('email');
    // String? savedPassword = prefs.getString('password');

    // Get the existing users from SharedPreferences
    String? usersData = prefs.getString(_usersKey);
    if (usersData != null) {
      List<dynamic> jsonUsers = json.decode(usersData);
      List<UserModel> users =
          jsonUsers.map((jsonUser) => UserModel.fromJson(jsonUser)).toList();

      // Find user by email
      for (var user in users) {
        if (user.email == email) {
          // Check if the password is correct
          if (user.password == password) {
            await prefs.setString('currentUserEmail', email);
            return "Logged in Successfully!";
          } else {
            return "Wrong password! Please try again.";
          }
        }
      }
    }
    // If the email doesn't match any user in the database
    return "Account not found! Try registering first.";
  }
}
