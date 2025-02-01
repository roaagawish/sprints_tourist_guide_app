import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../app/extensions.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/otp_entity.dart';
import '../network/requests.dart';
import '../responses/user_response.dart';

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
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  RemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<AuthenticationEntity> login(LoginRequest loginRequest) async {
    final UserCredential credential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: loginRequest.email,
      password: loginRequest.password,
    );
    //read doc
    DocumentSnapshot<Map<String, dynamic>> userDoc = await users
        .doc(credential.user?.uid)
        .get() as DocumentSnapshot<Map<String, dynamic>>;
    UserResponse userData = UserResponse.fromFirestore(userDoc);
    return AuthenticationEntity(
      uid: credential.user!.uid,
      name: userData.name.orEmpty(),
      email: userData.email.orEmpty(),
      phone: userData.phoneNumber.orEmpty(),
      photo: userData.photo.orEmpty(),
    );
  }

  @override
  Future<AuthenticationEntity> register(RegisterRequest registerRequest) async {
    final UserCredential credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: registerRequest.email,
      password: registerRequest.password,
    );
    //write doc
    await users.doc(credential.user?.uid).set(UserResponse(
            name: registerRequest.userName,
            email: registerRequest.email,
            phoneNumber: registerRequest.phoneNumber,
            photo: registerRequest.profileImage)
        .toFirestore());
    return AuthenticationEntity(
      uid: credential.user!.uid,
      name: registerRequest.userName,
      email: registerRequest.email.orEmpty(),
      phone: registerRequest.phoneNumber.orEmpty(),
      photo: registerRequest.profileImage.orEmpty(),
    );
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

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
}
