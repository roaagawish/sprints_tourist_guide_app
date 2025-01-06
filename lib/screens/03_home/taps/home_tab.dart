import 'package:flutter/material.dart';
import '../../../resourses/styles_manager.dart';
import '../widgets/popular_places_horiz_list.dart';
import '../widgets/suggested_places_grid_view.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0,
        children: [
          Text(
            'Popular Places',
            style: Styles.style20Bold(),
          ),
          Expanded(
            flex: 2,
            child: PopularPlacesHorizontalList(),
          ),
          Text(
            'Suggested Places to Visit',
            style: Styles.style20Bold(),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SuggestedPlacesGridView(),
            ),
          ),
        ],
      ),
    );
  }
}
