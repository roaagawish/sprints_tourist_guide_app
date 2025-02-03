import '../../app/extensions.dart';
import '../../domain/entities/place_entity.dart';
import '../responses/place_response.dart';

extension PlaceResponseMapper on PlaceResponse? {
  PlaceEntity toDomain() {
    return PlaceEntity(
      id: this!.id.orEmpty(),
      name: this!.name.orEmpty(),
      governorate: this!.gov.orEmpty(),
      image: this!.image.orEmpty(),
      likes: this!.likes ?? [],
      popular: this!.popular ?? false,
    );
  }
}
