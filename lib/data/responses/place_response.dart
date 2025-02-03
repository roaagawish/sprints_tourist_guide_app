import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceResponse {
  final String? id;
  final String? name;
  final String? gov;
  final String? image;
  final List? likes;
  final bool? popular;

  PlaceResponse(
      {this.id, this.name, this.gov, this.image, this.likes, this.popular});

  factory PlaceResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return PlaceResponse(
      id: snapshot.id,
      name: data?['name'],
      gov: data?['gov'],
      image: data?['image'],
      likes: data?['likes'],
      popular: data?['popular'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (gov != null) "gov": gov,
      "likes": likes,
      "image": image,
      "popular": popular,
    };
  }
}
