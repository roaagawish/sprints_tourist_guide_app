import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/app_prefs.dart';
import '../../../domain/entities/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserModel? initialUserData;
  final MemoryImage? initialAvatar;
  ProfileBloc({required this.initialUserData, this.initialAvatar})
      : super(initialUserData != null
            ? ProfileInitial(userData: initialUserData, avatar: initialAvatar)
            : ProfileError(
                userData: UserModel(fullName: "NA", email: "NA", password: ""),
                avatar: initialAvatar,
                message: 'User data unavailable')) {
    on<ProfileEvent>((event, emit) async {
      //     final oldUserData = state.userData;
      //     final oldAvatar = state.avatar;
      //     if (event is LoadProfile) {
      //       emit(ProfileLoading(userData: oldUserData, avatar: oldAvatar));
      //       final UserModel? userData = await AppPreferencesImpl.loadUserData().then((data){
      //         return data;
      //       }).catchError((err)=>null);
      //       if (userData == null) {
      //         emit(ProfileError(userData: oldUserData, avatar: oldAvatar, message: 'Failed to load User Data!'));
      //         return;
      //       }
      //       final MemoryImage? avatar = await AppPreferencesImpl.loadUserAvatar().then((data) => data).catchError((err)=>null);
      //       emit(ProfileLoaded(userData: userData, avatar: avatar));
      //       return;
      //     }
      //     if (event is UpdateProfile) {
      //       emit(ProfileLoading(userData: oldUserData, avatar: oldAvatar));
      //       final targetUserData = event.updatedEmployee;
      //       final result = AppPreferencesImpl.updateUserData(targetUserData).then((value) {
      //         return value;
      //       }).catchError((error) {
      //         return false;
      //       });
      //       if (await result) {
      //         emit(ProfileUpdated(userData: targetUserData, avatar: oldAvatar));
      //       } else {
      //         emit(ProfileError(userData: oldUserData, avatar: oldAvatar, message: 'Failed to update profile'));
      //       }
      //       return;
      //     }
      //     if (event is UpdateAvatar) {
      //       emit(ProfileLoading(userData: oldUserData, avatar: oldAvatar));
      //       if (event.updatedAvatar == null) {
      //         emit(ProfileError(userData: oldUserData, avatar: oldAvatar, message: 'Failed to update avatar'));
      //         return;
      //       }
      //       final imagePath = event.updatedAvatar!.path;
      //       final imageFile = File(imagePath);
      //       final imageBytes = imageFile.readAsBytesSync();
      //       final MemoryImage newAvatar = MemoryImage(imageBytes);

      //       final result = AppPreferencesImpl.updateAvatar(event.email, newAvatar).then((value) {
      //         return value;
      //       }).catchError((error) {
      //         return false;
      //       });
      //       if (await result) {
      //         emit(ProfileUpdated(userData: oldUserData, avatar: newAvatar));
      //       } else {
      //         emit(ProfileError(userData: oldUserData, avatar: oldAvatar, message: 'Failed to update avatar'));
      //       }
      //       return;
      //     }
    });
  }
}
