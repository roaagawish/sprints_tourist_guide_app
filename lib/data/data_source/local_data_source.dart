import 'package:hive/hive.dart';
import '../../domain/entities/auth_entity.dart';
import '../../presentation/resourses/constant_manager.dart';
import '../network/requests.dart';

abstract class LocalDataSource {
  AuthenticationEntity fetchUserData();
  Future<void> saveUserDataToCache(AuthenticationEntity authEntity);
  Future<void> updateUserDataInCache(UpdateInfoRequest updateInfoRequest);
  Future<void> clearAllCachedBoxes();
}

class LocalDataSourceImpl implements LocalDataSource {
  var userBox = Hive.box<AuthenticationEntity>(AppConstants.kUserDataBox);

  @override
  AuthenticationEntity fetchUserData() {
    //because we only have one use for the entire app
    //so we want to return the first item in the iterable
    AuthenticationEntity userData;
    try {
      userData = userBox.values.first;
    } catch (e) {
      userData = const AuthenticationEntity(
          uid: '1111', name: 'dummy', email: 'dummy', phone: '0103366....');
    }
    return userData;
  }

  @override
  Future<void> updateUserDataInCache(
      UpdateInfoRequest updateInfoRequest) async {
    if (userBox.isNotEmpty) {
      var key = userBox.keys.first; // Get the key of the stored user
      AuthenticationEntity currentUser = userBox.get(key)!;
      // Create an updated user entity
      AuthenticationEntity updatedUser = AuthenticationEntity(
        uid: currentUser.uid, // Keep UID unchanged
        name: updateInfoRequest.userName ?? currentUser.name,
        email: updateInfoRequest.email ?? currentUser.email,
        phone: updateInfoRequest.phoneNumber,
        photo: updateInfoRequest.profileImage,
      );
      // Update the existing entry
      await userBox.put(key, updatedUser);
    }
  }

  @override
  Future<void> saveUserDataToCache(AuthenticationEntity authEntity) async {
    await userBox.add(authEntity);
  }

  @override
  Future<void> clearAllCachedBoxes() async {
    await userBox.clear();
  }
}
