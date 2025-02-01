import 'package:cloud_firestore/cloud_firestore.dart';

class UserResponse {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photo;

  UserResponse({this.name, this.email, this.phoneNumber, this.photo});

  factory UserResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return UserResponse(
      name: data?['name'],
      email: data?['email'],
      phoneNumber: data?['phone'],
      photo: data?['photo'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (phoneNumber != null) "phone": phoneNumber,
      if (photo != null) "photo": photo,
    };
  }
}
