import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/place_model.dart';
import '../../resourses/language_manager.dart';
import '../blocs/popular_places/popular_places_bloc.dart';
import 'place_card.dart';

class PopularPlacesHorizontalList extends StatefulWidget {
  final List<Place> items;
  const PopularPlacesHorizontalList({super.key, required this.items});

  @override
  State<PopularPlacesHorizontalList> createState() =>
      _PopularPlacesHorizontalListState();
}

class _PopularPlacesHorizontalListState
    extends State<PopularPlacesHorizontalList> {
  late final ScrollController _scrollController;
  var isLoading = false; // flag to prevent many calls at the same time.

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    var currentPositions = _scrollController.position.pixels;
    var maxScrollLength =
        _scrollController.position.maxScrollExtent; //length of the list
    if (currentPositions >= 0.7 * maxScrollLength) {
      if (!isLoading) {
        isLoading = true;
        context.read<PopularPlacesBloc>().add(LoadMorePopularPlaces());
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: LocalizationUtils.isCurrentLocalAr(context)
              ? const EdgeInsets.only(left: 16.0)
              : const EdgeInsets.only(right: 16.0),
          child: SizedBox(
            width: 200,
            child: PlaceCard(
              place: widget.items[index],
            ),
          ),
        );
      },
    );
  }
}
