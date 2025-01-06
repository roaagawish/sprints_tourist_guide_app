import '../resourses/assets_manager.dart';

class Landmark {
  final String name;
  final String image;
  final String description;

  Landmark(
      {required this.name, required this.image, required this.description});
}

class Governorate {
  final String name;
  final String governorateImage;
  final List<Landmark> landmarks;

  Governorate({
    required this.name,
    required this.governorateImage,
    required this.landmarks,
  });
}

List<Governorate> getGovernorates() {
  return [
    Governorate(
      name: 'Cairo',
      governorateImage: PngAssets.cairo,
      landmarks: [
        Landmark(
          name: 'The Great Pyramids',
          image: PngAssets.pyramids,
          description:
              'The Great Pyramids of Giza are the only remaining wonder of the ancient world.',
        ),
        Landmark(
          name: 'Egyptian Museum',
          image: PngAssets.egyptianMuseum,
          description:
              'Home to the world\'s largest collection of ancient Egyptian antiquities.',
        ),
      ],
    ),
    Governorate(
      name: 'Luxor',
      governorateImage: PngAssets.luxor,
      landmarks: [
        Landmark(
          name: 'Karnak Temple',
          image: PngAssets.karnakTemple,
          description:
              'The Karnak Temple Complex was the main place of worship in ancient Thebes.',
        ),
        Landmark(
          name: 'Valley of the Kings',
          image: PngAssets.valleyOfTheKings,
          description:
              'A burial ground for pharaohs who ruled Egypt during the 18th to 20th dynasties.',
        ),
      ],
    ),
    Governorate(
      name: 'Alexandria',
      governorateImage: PngAssets.alexandria,
      landmarks: [
        Landmark(
          name: 'Bibliotheca Alexandrina',
          image: PngAssets.bibliothecaAlexandrina,
          description:
              'A modern library and cultural center, commemorating the ancient Library of Alexandria.',
        ),
        Landmark(
          name: 'Qaitbay Citadel',
          image: PngAssets.qaitbayCitadel,
          description:
              'A 15th-century defensive fortress built on the site of the ancient Lighthouse of Alexandria.',
        ),
      ],
    ),
  ];
}
