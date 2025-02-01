import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../../app/extensions.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/otp_entity.dart';
import '../network/requests.dart';

abstract class RemoteDataSource {
  Future<AuthenticationEntity> login(LoginRequest loginRequest);
  Future<AuthenticationEntity> register(RegisterRequest registerRequest);
  Future<void> logout();
  Future<OtpEntity> sendOtpToNewPhoneNumber(String newPhoneNumber);
  PhoneAuthCredential createPhoneAuthCredentialWithOtp(
      PhoneAuthCredentialRequest phoneAuthCredentialRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  RemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<OtpEntity> sendOtpToNewPhoneNumber(String newPhoneNumber) async {
    // String vId = '';
    // int? fToken;
    Completer<OtpEntity> completer = Completer<OtpEntity>();
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+2$newPhoneNumber', //TODO refactor this though ui
        timeout: Duration(minutes: 2),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          //for automatic android verification , without typing Otp ;)
        },
        verificationFailed: (FirebaseAuthException error) {
          print('yara error here $error');
          throw error;
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          // vId = verificationId;
          // fToken = forceResendingToken;
          completer.complete(OtpEntity(
              verificationId: verificationId,
              resendToken: forceResendingToken));
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
    //return OtpEntity(verificationId: vId, resendToken: fToken);
    return await completer.future; // Wait until `codeSent` completes
  }

  @override
  PhoneAuthCredential createPhoneAuthCredentialWithOtp(
      PhoneAuthCredentialRequest phoneAuthCredentialRequest) {
    return PhoneAuthProvider.credential(
      verificationId: phoneAuthCredentialRequest.verificationId,
      smsCode: phoneAuthCredentialRequest.smsCode,
    );
  }

  @override
  Future<AuthenticationEntity> login(LoginRequest loginRequest) async {
    final UserCredential credential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: loginRequest.email,
      password: loginRequest.password,
    );
    return AuthenticationEntity(
      uid: credential.user!.uid,
      name: credential.user!.displayName.orEmpty(),
      email: credential.user!.email.orEmpty(),
      phone: credential.user!.phoneNumber.orEmpty(),
    );
  }

  @override
  Future<AuthenticationEntity> register(RegisterRequest registerRequest) async {
    final UserCredential credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: registerRequest.email,
      password: registerRequest.password,
    );
    // Update user's profile with displayName
    await credential.user?.updateDisplayName(registerRequest.userName);

    if (registerRequest.phoneNumber != null &&
        registerRequest.phoneNumber!.isNotEmpty) {
      //link with credential or update phone number
      await credential.user
          ?.linkWithCredential(registerRequest.phoneAuthCredential!);
      await credential.user
          ?.updatePhoneNumber(registerRequest.phoneAuthCredential!);
    }
    // Optionally, reload the user to get updated info
    await credential.user?.reload();
    //return the AuthenticationEntity with updated data.
    return AuthenticationEntity(
      uid: credential.user!.uid,
      name: registerRequest.userName,
      email: credential.user!.email.orEmpty(),
      phone: registerRequest.phoneNumber,
    );
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
