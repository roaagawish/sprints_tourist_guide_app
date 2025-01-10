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
  static const String _userKey = 'user';

// sign up and add new user to database
  static Future<String> SignUp(
      {String? phone,
      required String fullName,
      required String email,
      required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //check if user (email) is already exists
    String? savedEmail = prefs.getString('email');
    if (savedEmail == email) {
      return "This email is alerady registerd!";
    }
    // add new user and save it to shared preferrnces
    UserModel newUser =
        UserModel(fullName: fullName, email: email, password: password);

    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString(_userKey, json.encode(newUser.toJson()));

    return "User added Successfully!";
  }

// login to already registerd user
  static Future<String> Login(
      {required String email, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //retrieve user data from database
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');
    

   //check if user already exists in database 

    if (savedEmail == email) {
  
      // check if the password is right
      if (savedPassword == password) {
        return "Logged in Successfully!";
      } else {
        return "Wrong password! Please Try Again.";
      }
    }
     return "Account not found! Try registering first";
      
  }
}
