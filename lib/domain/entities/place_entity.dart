class PlaceEntity {
  final String id;
  final String name;
  final String? description;
  final String governorate;
  final String image;
  final String? lat;
  final String? lng;
  final List likes;
  final bool popular;

  PlaceEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.governorate,
      required this.image,
      required this.lat,
      required this.lng,
      required this.likes,
      required this.popular});
}
