class PlaceEntity {
  final String id;
  final String name;
  final String governorate;
  final String image;
  final List likes;
  final bool popular;

  PlaceEntity(
      {required this.id,
      required this.name,
      required this.governorate,
      required this.image,
      required this.likes,
      required this.popular});
}
