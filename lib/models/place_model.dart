class Place {
  final String name;
  final String governorate;
  final String image;
  bool isFavorite;

  Place({
    required this.name,
    required this.governorate,
    required this.image,
    this.isFavorite = false,
  });
}
