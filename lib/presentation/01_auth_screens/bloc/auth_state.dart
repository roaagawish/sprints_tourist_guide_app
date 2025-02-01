part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class LoginLoading extends AuthState {
  const LoginLoading();
}

final class LoginSuccess extends AuthState {
  const LoginSuccess();
}

final class LoginFailure extends AuthState {
  final String errMessage;

  const LoginFailure(
    this.errMessage,
  );
}

final class RegisterLoading extends AuthState {
  const RegisterLoading();
}

final class RegisterSuccess extends AuthState {
  const RegisterSuccess();
}

final class RegisterFailure extends AuthState {
  final String errMessage;
  const RegisterFailure(
    this.errMessage,
  );
}

final class LogoutLoading extends AuthState {
  const LogoutLoading();
}

final class LogoutSuccess extends AuthState {
  const LogoutSuccess();
}

final class LogoutFailure extends AuthState {
  final String errMessage;
  const LogoutFailure(
    this.errMessage,
  );
}

final class PhoneOTPSendLoading extends AuthState {
  const PhoneOTPSendLoading();
}

final class PhoneOTPSendSuccess extends AuthState {
  final OtpEntity otpEntity;
  const PhoneOTPSendSuccess(this.otpEntity);
}

final class PhoneOTPSendFailure extends AuthState {
  final String errMessage;
  const PhoneOTPSendFailure(
    this.errMessage,
  );
}

final class PhoneOTPVerifyLoading extends AuthState {
  const PhoneOTPVerifyLoading();
}

final class PhoneOTPVerifySuccess extends AuthState {
  final PhoneAuthCredential phoneAuthCredential;
  const PhoneOTPVerifySuccess(this.phoneAuthCredential);
}

final class PhoneOTPVerifyFailure extends AuthState {
  final String errMessage;
  const PhoneOTPVerifyFailure(
    this.errMessage,
  );
}
