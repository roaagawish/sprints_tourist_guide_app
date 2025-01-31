import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../app/app_prefs.dart';



part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppPreferencesImpl appPreferences;

  AuthBloc({required this.appPreferences}) : super(AuthInitial(loading: false)) {
   
   on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }
   
   void _onLoginRequested(LoginRequested event , Emitter<AuthState> emit) async {
    emit(LoginLoading(loading: true));
    try{

      await Future.delayed(Duration(seconds: 3));

      String message = await AppPreferencesImpl.login(
        email: event.email,
        password: event.password,
      );
      
    switch (message) {
        case "Wrong password! Please try again":
        case "كلمة المرور خاطئة! يرجى المحاولة مرة أخرى":
          emit(LoginFailure(
            errMessage: message, 
            isWrongPassword: true, 
            loading: false
          ));
          break;
        
        case "Account not found! Try registering first":
        case "الحساب غير موجود! يرجى التسجيل أولاً":
          emit(LoginFailure
          (errMessage: message, 
          isAccountNotFound: true,
          loading: false)
           );
          break;
        
        case "Logged in Successfully!":
        case "تم تسجيل الدخول بنجاح!":
          appPreferences.setUserLoggedIn();
          emit(LoginSuccess(loading: false, message: message));
          emit(AuthAuthenticated(email: event.email, loading: false));
          break;
        
        default:
          emit(LoginFailure(
            errMessage: message.contains('ar') 
              ? "خطأ غير متوقع" 
              : "An unexpected error occurred", loading: false
          ));
      }
    } catch (error) {
      emit(LogoutFailure(errMessage: error.toString(), loading: false));
    }
  }

   
   void _onRegisterRequested(RegisterRequested event , Emitter<AuthState> emit) async { 
    emit(RegisterLoading(loading: true));
    try {
       await Future.delayed(Duration(seconds: 3));

       String message = await AppPreferencesImpl.signUp(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
        phone: event.phone);


    switch (message) {
        case "This email is already registered!":
        case  "هذا البريد الإلكتروني مسجل بالفعل!":
          emit(RegisterFailure(
            errMessage: message,  
            loading: false
          ));
          break;
        
        case "User added successfully!":
        case "تم إضافة المستخدم بنجاح!":
          emit(RegisterSuccess
          (message: message, 
          loading: false
          ));
          break;
        
        default:
          emit(RegisterFailure(
            errMessage: message.contains('ar') 
              ? "خطأ غير متوقع" 
              : "An unexpected error occurred", loading: false
          ));
      }
    } catch (error) {
      emit(RegisterFailure(errMessage: error.toString(), loading: false));
    }
   }
   void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(LogoutLoading(loading: true));
    try {
      
       await Future.delayed(Duration(seconds: 3));
        AppPreferencesImpl().removePrefs();

      // Emit unauthenticated state
      emit(AuthUnauthenticated(loading: false));
      emit(LogoutSuccess(loading: false, 
      message: tr("taps.profileLogoutMsg")));
    } catch (error) {
      // Handle any potential errors during logout
      emit(LogoutFailure(
        errMessage: tr("taps.profileLogouterrMsg"),  
              loading: false));
    }
  }

 
  }

