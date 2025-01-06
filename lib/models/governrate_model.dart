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
              'The Great Pyramids of Giza, located on the outskirts of Cairo, are the only remaining wonder of the ancient world. Built around 2560 BCE, these massive stone structures served as tombs for the ancient Egyptian pharaohs. The largest pyramid, known as the Great Pyramid of Khufu, stands at an incredible height of 481 feet. Visitors to the pyramids can explore these architectural marvels and also witness the nearby Sphinx, an enormous limestone statue with the body of a lion and the head of a pharaoh.',
        ),
        Landmark(
          name: 'Egyptian Museum',
          image: PngAssets.egyptianMuseum,
          description:
              'The Egyptian Museum, located in the heart of Cairo, houses the world\'s most extensive collection of ancient Egyptian antiquities. It is home to over 120,000 artifacts, including the treasures of the famous pharaoh Tutankhamun. The museum showcases a rich history of Egypt, offering visitors the opportunity to view mummies, statues, jewelry, and more. One of the most famous exhibits is the golden mask of Tutankhamun, which has become an iconic symbol of ancient Egyptian culture. The museum remains a must-visit destination for history enthusiasts.',
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
              'The Karnak Temple Complex, located in Luxor, is one of the largest and most important religious sites of ancient Egypt. Dedicated to the god Amun, it was the main place of worship in ancient Thebes. The temple complex is known for its massive pylons, obelisks, and the Great Hypostyle Hall, which contains 134 massive columns. Visitors can explore the grandeur of this historical site, which has been under construction for over 2,000 years. The Karnak Temple is a testament to the power and magnificence of ancient Egyptian civilization.',
        ),
        Landmark(
          name: 'Valley of the Kings',
          image: PngAssets.valleyOfTheKings,
          description:
              'The Valley of the Kings, located on the west bank of the Nile near Luxor, is one of Egypt\'s most famous archaeological sites. It served as the burial ground for pharaohs from the 18th to the 20th dynasties. The valley is home to 63 royal tombs, many of which are decorated with intricate paintings depicting the pharaohs\' journey to the afterlife. The tomb of Tutankhamun is the most famous, containing his well-preserved mummy and incredible treasures. The Valley of the Kings is a UNESCO World Heritage Site and attracts millions of tourists every year.',
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
              'The Bibliotheca Alexandrina is a modern cultural center and library in Alexandria, Egypt, commemorating the ancient Library of Alexandria, one of the largest and most significant libraries of the ancient world. The modern library, opened in 2002, features a stunning architectural design, with a large circular reading room that can hold up to 2,000 readers. It also houses museums, art galleries, and various cultural events. The library aims to revive Alexandria\'s ancient status as a hub of knowledge and learning. It is a symbol of Egypt\'s rich history and dedication to education.',
        ),
        Landmark(
          name: 'Qaitbay Citadel',
          image: PngAssets.qaitbayCitadel,
          description:
              'The Qaitbay Citadel, located on the Mediterranean coast in Alexandria, is a 15th-century defensive fortress that stands on the site of the ancient Lighthouse of Alexandria, one of the Seven Wonders of the Ancient World. The citadel was built by Sultan Qaitbay in 1477 to protect the city from naval invasions. It offers breathtaking views of the Mediterranean Sea and Alexandria\'s coastline. Today, the citadel serves as a historical site and museum, providing insight into the military architecture and history of ancient Alexandria.',
        ),
      ],
    ),
  ];
}
