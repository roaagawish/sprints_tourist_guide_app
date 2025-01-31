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

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      governorate: json['governorate'],
      image: json['image'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'governorate': governorate,
      'image': image,
      'isFavorite': isFavorite,
    };
  }
}
