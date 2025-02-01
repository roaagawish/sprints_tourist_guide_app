import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String userName;
  String email;
  String password;
  PhoneAuthCredential? phoneAuthCredential;
  String? phoneNumber;
  File? profileImage;

  RegisterRequest(this.userName, this.email, this.password,
      {this.phoneAuthCredential, this.phoneNumber, this.profileImage});
}

class PhoneAuthCredentialRequest {
  String verificationId;
  String smsCode;

  PhoneAuthCredentialRequest(this.verificationId, this.smsCode);
}
