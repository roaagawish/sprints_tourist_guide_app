import '../../app/extensions.dart';
import '../../domain/entities/place_entity.dart';
import '../responses/place_response.dart';

extension PlaceResponseMapper on PlaceResponse? {
  PlaceEntity toDomain() {
    return PlaceEntity(
      id: this!.id.orEmpty(),
      name: this!.name.orEmpty(),
      governorate: this!.gov.orEmpty(),
      description: this!.description.orEmpty(),
      image: this!.image.orEmpty(),
      likes: this!.likes ?? [],
      lat: this!.lat.orEmpty(),
      lng: this!.lng.orEmpty(),
      popular: this!.popular ?? false,
    );
  }
}
