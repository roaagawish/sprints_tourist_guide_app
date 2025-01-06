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
      governorateImage: 'assets/png/cairo.png',
      landmarks: [
        Landmark(
          name: 'The Great Pyramids',
          image: 'assets/png/pyramids.png',
          description:
              'The Great Pyramids of Giza are the only remaining wonder of the ancient world.',
        ),
        Landmark(
          name: 'Egyptian Museum',
          image: 'https://example.com/museum.jpg',
          description:
              'Home to the world\'s largest collection of ancient Egyptian antiquities.',
        ),
      ],
    ),
    Governorate(
      name: 'Luxor',
      governorateImage: 'assets/png/luxor.png',
      landmarks: [
        Landmark(
          name: 'Karnak Temple',
          image: 'https://example.com/karnak.jpg',
          description:
              'The Karnak Temple Complex was the main place of worship in ancient Thebes.',
        ),
        Landmark(
          name: 'Valley of the Kings',
          image: 'https://example.com/valley.jpg',
          description:
              'A burial ground for pharaohs who ruled Egypt during the 18th to 20th dynasties.',
        ),
      ],
    ),
    Governorate(
      name: 'Alexandria',
      governorateImage: 'assets/png/alexandria.png',
      landmarks: [
        Landmark(
          name: 'Bibliotheca Alexandrina',
          image: 'https://example.com/library.jpg',
          description:
              'A modern library and cultural center, commemorating the ancient Library of Alexandria.',
        ),
        Landmark(
          name: 'Qaitbay Citadel',
          image: 'https://example.com/citadel.jpg',
          description:
              'A 15th-century defensive fortress built on the site of the ancient Lighthouse of Alexandria.',
        ),
      ],
    ),
  ];
}
