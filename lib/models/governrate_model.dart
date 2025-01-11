import 'package:easy_localization/easy_localization.dart';

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
      name:tr("governrate_model.Cairo"),
      governorateImage: PngAssets.cairo,
      landmarks: [
        Landmark(
          name: tr("governrate_model.TheGreatPyramids"),
          image: PngAssets.pyramids,
          description:  tr("governrate_model.TheGreatPyramidsDescription"),
          ),
        Landmark(
          name: tr("governrate_model.EgyptianMuseum"),
          image: PngAssets.egyptianMuseum,
          description: tr("governrate_model.EgyptianMuseumDescription"),
              ),
      ],
    ),
    Governorate(
      name: tr("governrate_model.Luxor"),
      governorateImage: PngAssets.luxor,
      landmarks: [
        Landmark(
          name: tr("governrate_model.KarnakTemple"),
          image: PngAssets.karnakTemple,
          description:tr("governrate_model.KarnakTempleDescription"),
          ),
        Landmark(
          name: tr("governrate_model.ValleyoftheKings"),
          image: PngAssets.valleyOfTheKings,
          description:tr("governrate_model.ValleyoftheKingsDescription"),
          ),
      ],
    ),
    Governorate(
      name: tr("governrate_model.Alexandria"),
      governorateImage: PngAssets.alexandria,
      landmarks: [
        Landmark(
          name: tr("governrate_model.BibliothecaAlexandria"),
          image: PngAssets.bibliothecaAlexandrina,
          description: tr("governrate_model.BibliothecaAlexandriaDescription"),
          ),
        Landmark(
          name: tr("governrate_model.QaitbayCitadel"),
          image: PngAssets.qaitbayCitadel,
          description: tr("governrate_model.QaitbayCitadelDescription"),
          ),
      ],
    ),
  ];
}
