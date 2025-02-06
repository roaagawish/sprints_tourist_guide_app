import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../app/extensions.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/otp_entity.dart';
import '../../domain/entities/place_entity.dart';
import '../network/requests.dart';
import '../responses/place_response.dart';
import '../responses/user_response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationEntity> login(LoginRequest loginRequest);
  Future<AuthenticationEntity> register(RegisterRequest registerRequest);
  Future<void> logout();
  Future<AuthenticationEntity> updateInfo(UpdateInfoRequest updateInfoRequest);
  Stream<List<PlaceResponse>> getSuggestedPlaces();
  Stream<List<PlaceResponse>> getPopularPlaces();
  Stream<List<PlaceResponse>> getFavouritePlaces();
  Future<void> toggleFavourite(PlaceEntity place);
  //these two functions are not used due to billing setup on firebase :(
  Future<OtpEntity> sendOtpToNewPhoneNumber(String newPhoneNumber);
  PhoneAuthCredential createPhoneAuthCredentialWithOtp(
      PhoneAuthCredentialRequest phoneAuthCredentialRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference suggestedPlaces =
      FirebaseFirestore.instance.collection('suggestedPlaces');
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
  Future<AuthenticationEntity> updateInfo(
      UpdateInfoRequest updateInfoRequest) async {
    //update doc
    await users.doc(updateInfoRequest.uid).update(UserResponse(
            name: updateInfoRequest.userName,
            email: updateInfoRequest.email,
            phoneNumber: updateInfoRequest.phoneNumber,
            photo: updateInfoRequest.profileImage)
        .toFirestore());
    return AuthenticationEntity(
      uid: updateInfoRequest.uid,
      name: updateInfoRequest.userName.orEmpty(),
      email: updateInfoRequest.email.orEmpty(),
      phone: updateInfoRequest.phoneNumber,
      photo: updateInfoRequest.profileImage,
    );
  }

  @override
  Stream<List<PlaceResponse>> getSuggestedPlaces() {
    return suggestedPlaces
        .snapshots() // Listen to the collection as a stream
        .map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((doc) => PlaceResponse.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
    });
  }

  @override
  Stream<List<PlaceResponse>> getPopularPlaces() {
    return suggestedPlaces
        .orderBy('name', descending: true)
        .snapshots() // Listen to the collection as a stream
        .map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((doc) => PlaceResponse.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .where((place) => place.popular == true) // Filter popular places only
          .toList();
    });
  }

  @override
  Stream<List<PlaceResponse>> getFavouritePlaces() {
    String currentUserId = _firebaseAuth.currentUser?.uid ?? "";
    return suggestedPlaces
        .snapshots() // Listen to the collection as a stream
        .map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((doc) => PlaceResponse.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          // Filter user likes
          .where((place) => place.likes!.contains(currentUserId))
          .toList();
    });
  }

  @override
  Future<void> toggleFavourite(PlaceEntity place) async {
    String currentUserId = _firebaseAuth.currentUser?.uid ?? "";

    place.likes.contains(currentUserId)
        ? place.likes.remove(currentUserId)
        : place.likes.add(currentUserId);
    //update doc
    await suggestedPlaces.doc(place.id).update(PlaceResponse(
            name: place.name,
            gov: place.governorate,
            description: place.description,
            image: place.image,
            likes: place.likes,
            lat: place.lat,
            lng: place.lng,
            popular: place.popular)
        .toFirestore());
  }

  //this function is not used due to billing setup on firebase :(
  @override
  Future<OtpEntity> sendOtpToNewPhoneNumber(String newPhoneNumber) async {
    // String vId = '';
    // int? fToken;
    Completer<OtpEntity> completer = Completer<OtpEntity>();
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+2$newPhoneNumber', //need refactor this though ui
        timeout: Duration(minutes: 2),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          //for automatic android verification , without typing Otp ;)
        },
        verificationFailed: (FirebaseAuthException error) {
          debugPrint('yara error here $error');
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

  //this function is not used due to billing setup on firebase :(
  @override
  PhoneAuthCredential createPhoneAuthCredentialWithOtp(
      PhoneAuthCredentialRequest phoneAuthCredentialRequest) {
    return PhoneAuthProvider.credential(
      verificationId: phoneAuthCredentialRequest.verificationId,
      smsCode: phoneAuthCredentialRequest.smsCode,
    );
  }
}
