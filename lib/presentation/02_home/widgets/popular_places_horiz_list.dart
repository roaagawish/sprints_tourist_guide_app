import 'package:flutter/material.dart';
import '../../../domain/entities/place_entity.dart';
import '../../resourses/language_manager.dart';
import 'place_card.dart';

class PopularPlacesHorizontalList extends StatelessWidget {
  final List<PlaceEntity> items;
  const PopularPlacesHorizontalList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: LocalizationUtils.isCurrentLocalAr(context)
              ? const EdgeInsets.only(left: 16.0)
              : const EdgeInsets.only(right: 16.0),
          child: SizedBox(
            width: 200,
            child: PlaceCard(
              place: items[index],
            ),
          ),
        );
      },
    );
  }
}
