import 'dart:io';

class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String userName;
  String email;
  String password;
  String? phoneNumber;
  File? profileImage;

  RegisterRequest(this.userName, this.email, this.password,
      {this.phoneNumber, this.profileImage});
}
