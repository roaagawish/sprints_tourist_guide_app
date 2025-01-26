part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email ;
  final String password ; 

  LoginRequested({required this.email , required this.password});
}

class LogoutRequested extends AuthEvent {}

class RegisterRequested extends AuthEvent {
  final String email ;
  final String password ; 
  final String fullName ; 
  final String? phone ;  

  RegisterRequested({required this.email , required this.password , required this.fullName , this.phone });
}