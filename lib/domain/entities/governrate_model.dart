import 'package:easy_localization/easy_localization.dart';

import '../../presentation/resourses/assets_manager.dart';

class Landmark {
  final String name;
  final String image;
  final String description;
  final String lat;
  final String lng;

  Landmark(
      {required this.name,
      required this.image,
      required this.description,
      required this.lat,
      required this.lng});
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
      name: tr("governrate_model.Cairo"),
      governorateImage: PngAssets.cairo,
      landmarks: [
        Landmark(
          name: tr("governrate_model.TheGreatPyramids"),
          image: PngAssets.pyramids,
          description: tr("governrate_model.TheGreatPyramidsDescription"),
          lat: '29.9792',
          lng: '31.1342',
        ),
        Landmark(
          name: tr("governrate_model.EgyptianMuseum"),
          image: PngAssets.egyptianMuseum,
          description: tr("governrate_model.EgyptianMuseumDescription"),
          lat: '30.0478',
          lng: '31.2336',
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
          description: tr("governrate_model.KarnakTempleDescription"),
          lat: '25.7188',
          lng: '32.6573',
        ),
        Landmark(
          name: tr("governrate_model.ValleyoftheKings"),
          image: PngAssets.valleyOfTheKings,
          description: tr("governrate_model.ValleyoftheKingsDescription"),
          lat: '25.7402',
          lng: '32.6014',
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
          lat: '31.2089',
          lng: '29.9092',
        ),
        Landmark(
          name: tr("governrate_model.QaitbayCitadel"),
          image: PngAssets.qaitbayCitadel,
          description: tr("governrate_model.QaitbayCitadelDescription"),
          lat: '31.2140',
          lng: '29.8856',
        ),
      ],
    ),
  ];
}
