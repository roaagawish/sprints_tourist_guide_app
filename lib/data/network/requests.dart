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
  String? profileImage;

  RegisterRequest(this.userName, this.email, this.password,
      {this.phoneAuthCredential, this.phoneNumber, this.profileImage});
}

class UpdateInfoRequest {
  String uid;
  String? userName;
  String? email;
  String? phoneNumber;
  String? profileImage;

  UpdateInfoRequest(this.uid,
      {this.userName, this.email, this.phoneNumber, this.profileImage});
}

class PhoneAuthCredentialRequest {
  String verificationId;
  String smsCode;

  PhoneAuthCredentialRequest(this.verificationId, this.smsCode);
}
