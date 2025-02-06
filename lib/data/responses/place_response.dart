import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceResponse {
  final String? id;
  final String? name;
  final String? description;
  final String? gov;
  final String? image;
  final String? lat;
  final String? lng;
  final List? likes;
  final bool? popular;

  PlaceResponse({
    this.id,
    this.name,
    this.description,
    this.gov,
    this.image,
    this.lat,
    this.lng,
    this.likes,
    this.popular,
  });

  factory PlaceResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return PlaceResponse(
      id: snapshot.id,
      name: data?['name'],
      description: data?['description'],
      gov: data?['gov'],
      image: data?['image'],
      lat: data?['lat'],
      lng: data?['lng'],
      likes: data?['likes'],
      popular: data?['popular'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (gov != null) "gov": gov,
      "description": description,
      "likes": likes,
      "image": image,
      "popular": popular,
      "lat": lat,
      "lng": lng,
    };
  }
}
