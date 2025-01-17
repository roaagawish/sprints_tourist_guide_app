import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

const String _usersKey = 'users';
const String _currentUserEmailKey = 'currentUserEmail';
const String prefsKeyOnboarding = "PREFS_KEY_ONBOARDING";

class LocalDataBase {
  static late final SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveEligibility() async {
    bool result = await prefs.setBool(prefsKeyOnboarding, true);
    return result;
  }

  static bool getEligibility() {
    return prefs.getBool(prefsKeyOnboarding) ?? false;
  }

// sign up and add new user to database
  static Future<String> signUp(
      {String? phone,
      required String fullName,
      required String email,
      required String password}) async {
    // Get the existing users from SharedPreferences
    String? usersData = prefs.getString(_usersKey);
    List<UserModel> users = [];
    if (usersData != null) {
      List<dynamic> jsonUsers = json.decode(usersData);
      users =
          jsonUsers.map((jsonUser) => UserModel.fromJson(jsonUser)).toList();
    }

    // Check if email already exists
    if (users.any((user) => user.email == email)) {
      return tr("signup.accountAlreadyRegisterd");
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
    return tr("signup.userAddedSuccessfully");
  }

// login to already registerd user
  static Future<String> login(
      {required String email, required String password}) async {
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
            await prefs.setString(_currentUserEmailKey, email);
            return tr("login.loggedin");
          } else {
            return tr("login.wrongPassword");
          }
        }
      }
    }
    // If the email doesn't match any user in the database
    return tr("login.accountNotFound");
  }

// load user data
  static Future<UserModel?> loadUserData() async {
    UserModel? currentUser;
    // Get the current logged-in user's email
    String? currentUserEmail = prefs.getString(_currentUserEmailKey);
    if (currentUserEmail != null) {
      // Fetch the list of users and find the current user's data
      String? usersData = prefs.getString('users');
      if (usersData != null) {
        List<dynamic> jsonUsers = json.decode(usersData);
        List<UserModel> users =
            jsonUsers.map((jsonUser) => UserModel.fromJson(jsonUser)).toList();

        // Find the user with the current email
        currentUser = users.firstWhere(
          (user) => user.email == currentUserEmail,
          orElse: () => UserModel(
              fullName: tr("taps.profileNoNameFound"),
              email: tr("taps.profileNoEmailFound"),
              phone: tr("taps.profileNoPhoneFound"),
              password: tr("taps.profileNoPasswordFound")),
        );
      }
    }
    return currentUser;
  }
}
