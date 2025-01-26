import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'extensions.dart';
import '../models/user_model.dart';

const String _usersKey = 'users';
const String _avatarsKey = 'avatars';
const String _currentUserEmailKey = 'currentUserEmail';
const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
const String prefsKeyTheme = "PREFS_KEY_THEME";

abstract class AppPreferences {
  Future<String> getAppThemeName();
  Future<void> setTheme(ThemeMode theme);
  Future<ThemeMode> getTheme();
  Future<void> setUserLoggedIn();
  bool isUserLoggedIn();
  Future<void> removePrefs();
}

class AppPreferencesImpl implements AppPreferences {
  static late final SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // ############################################################# theme
  @override
  Future<String> getAppThemeName() async {
    String? themeName = prefs.getString(prefsKeyTheme);
    if (themeName != null && themeName.isNotEmpty) {
      return themeName;
    } else {
      // return default theme
      return ThemeMode.light.getName();
    }
  }

  @override
  Future<void> setTheme(ThemeMode theme) async {
    if (theme == ThemeMode.light) {
      prefs.setString(prefsKeyTheme, ThemeMode.light.getName());
    } else if (theme == ThemeMode.dark) {
      prefs.setString(prefsKeyTheme, ThemeMode.dark.getName());
    } else {
      prefs.setString(prefsKeyTheme, ThemeMode.system.getName());
    }
  }

  @override
  Future<ThemeMode> getTheme() async {
    String currentThemeName = await getAppThemeName();

    if (currentThemeName == ThemeMode.light.getName()) {
      return ThemeMode.light;
    } else if (currentThemeName == ThemeMode.dark.getName()) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  // ############################################################# user logged in
  @override
  Future<void> setUserLoggedIn() async {
    prefs.setBool(prefsKeyIsUserLoggedIn, true);
  }

  @override
  bool isUserLoggedIn() {
    return prefs.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  // ############################################################# remove all prefs
  @override
  Future<void> removePrefs() async {
    prefs.remove(prefsKeyTheme);
    prefs.remove(prefsKeyIsUserLoggedIn);
  }

  // #############################################################
/* 
signUp & login & loadUserData will be removed from here as soon as we use firebase 👀
so there is no need to be in the abstract class above...
*/
  // #############################################################

// sign up and add new user to database
  static Future<String> signUp(
      {String? phone,
      MemoryImage? avatar,
      required String fullName,
      required String email,
      required String password}) async {
    // Get the existing users from SharedPreferences
    String? usersData = prefs.getString(_usersKey);
    String? avatarsData = prefs.getString(_avatarsKey);

    List<UserModel> users = [];
    List<Map<String, MemoryImage?>> avatars = [];

    if (usersData != null) {
      List<dynamic> jsonUsers = json.decode(usersData);
      users =
          jsonUsers.map((jsonUser) => UserModel.fromJson(jsonUser)).toList();
    }

    if (avatarsData != null) {
      List<Map<String, dynamic>> jsonAvatars = json.decode(avatarsData);
      avatars = jsonAvatars.map((jsonAvatar) {
        String key = jsonAvatar.keys.first;
        final avatarString = jsonAvatar.values.first;
        if (avatarString == null) {
          return {key: null};
        }
        final avatarListInt = avatarString.codeUnits;
        final avatarMemoryImage = MemoryImage(Uint8List.fromList(avatarListInt));

        return {key: avatarMemoryImage};
      }).toList();
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

    // Save the avatar
    avatars += [{email: avatar}];

    // Save updated user list
    await prefs.setString(
        _usersKey, json.encode(users.map((u) => u.toJson()).toList()));

    await prefs.setString(_avatarsKey, json.encode(avatars.map((m) => {email: m[email] != null ? String.fromCharCodes(m[email]!.bytes) : null})));
    
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

  static Future<MemoryImage?> loadUserAvatar() async {
    String? currentUserEmail = prefs.getString(_currentUserEmailKey);
    if (currentUserEmail == null) {
      return null;
    }


    // Fetch the list of users and find the current user's data
    String? avatarsSerialized = prefs.getString('avatars');
    if (avatarsSerialized == null) {
      return null;
    }

    List<Map<String, dynamic>?> avatars = json.decode(avatarsSerialized);
    final currentAvatarMap = avatars.firstWhere((m) => m!.keys.first == currentUserEmail, orElse: ()=>null);
    if (currentAvatarMap == null) {
      return null;
    }

    final String? currentAvatarString = currentAvatarMap.values.first;
    if (currentAvatarString == null) {
      return null;
    }

    return MemoryImage(Uint8List.fromList(currentAvatarString.codeUnits));
  }

  static Future<bool> updateUserData(UserModel updatedUserData) async {
    // Get the existing users from SharedPreferences
    String? usersData = prefs.getString(_usersKey);

    List<UserModel> users = [];

    if (usersData != null) {
      List<dynamic> jsonUsers = json.decode(usersData);
      users =
          jsonUsers.map((jsonUser) => UserModel.fromJson(jsonUser)).toList();
    }

    // Check if email already exists
    if (!users.any((user) => user.email == updatedUserData.email)) {
      return false;
    }

    // Add new user
    final idx = users.indexWhere((user) => user.email == updatedUserData.email);
    users[idx] = updatedUserData;

    // Save updated user list
    return prefs.setString(
        _usersKey, json.encode(users.map((u) => u.toJson()).toList()));
  }

  static Future<bool> updateAvatar(String email, MemoryImage? avatar) async{
    // Get the existing users from SharedPreferences
    String? avatarsData = prefs.getString(_avatarsKey);

    List<Map<String, MemoryImage?>> avatars = [];

    if (avatarsData != null) {
      List<Map<String, dynamic>> jsonAvatars = json.decode(avatarsData);
      avatars = jsonAvatars.map((jsonAvatar) {
        String key = jsonAvatar.keys.first;
        final avatarString = jsonAvatar.values.first;
        if (avatarString == null) {
          return {key: null};
        }
        final avatarListInt = avatarString.codeUnits;
        final avatarMemoryImage = MemoryImage(Uint8List.fromList(avatarListInt));

        return {key: avatarMemoryImage};
      }).toList();
    }

    // Check if email already exists
    if (!avatars.any((avatarJson) => avatarJson.keys.first == email)) {
      false;
    }

    // Save the avatar
    final idx = avatars.indexWhere((avatarJson)=>avatarJson.keys.first == email);
    avatars[idx] = {email: avatar};

    return prefs.setString(_avatarsKey, json.encode(avatars.map((m) => {email: m[email] != null ? String.fromCharCodes(m[email]!.bytes) : null})));    
  }
}
