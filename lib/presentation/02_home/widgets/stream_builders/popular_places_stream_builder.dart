import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../app/di.dart';
import '../../../../domain/entities/place_entity.dart';
import '../../../../domain/usecase/popular_places_usecase.dart';
import '../popular_places_horiz_list.dart';
import '../state_widgets/empty_state_widget.dart';
import '../state_widgets/error_state_widget.dart';

class PopularPlacesStreamBuilder extends StatelessWidget {
  const PopularPlacesStreamBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PopularPlacesUsecase popularPlacesUsecase = instance();
    return StreamBuilder<List<PlaceEntity>>(
      stream: popularPlacesUsecase.execute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return ErrorStateWidget(
            width: MediaQuery.sizeOf(context).width * 0.3,
            errorText: context
                .tr('failedToLoadPlaces', args: [snapshot.error.toString()]),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return EmptyStateWidget(label: context.tr('noPopularPlaces'));
        } else {
          return PopularPlacesHorizontalList(
            items: snapshot.data!,
          );
        }
      },
    );
  }
}
