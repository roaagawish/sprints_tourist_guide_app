part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class RegisterRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final PhoneAuthCredential? phoneAuthCredential;
  final String? phone;
  final File? photo;

  RegisterRequested(
      {required this.fullName,
      required this.email,
      required this.password,
      this.phoneAuthCredential,
      this.phone,
      this.photo});
}

class LogoutRequested extends AuthEvent {}

class PhoneOTPRequested extends AuthEvent {
  final String phone;

  PhoneOTPRequested({required this.phone});
}

class PhoneVerifyOTPRequested extends AuthEvent {
  final String otp;
  final String sms;

  PhoneVerifyOTPRequested({required this.otp, required this.sms});
}
