import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../blocs/popular_places_bloc/popular_places_bloc.dart';
import '../popular_places_horiz_list.dart';
import '../state_widgets/error_state_widget.dart';

class PopularPlacesBlocBuilder extends StatelessWidget {
  const PopularPlacesBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularPlacesBloc, PopularPlacesState>(
      builder: (context, state) {
        if (state is PopularPlacesError) {
          return ErrorStateWidget(
            width: MediaQuery.sizeOf(context).width * 0.3,
            errorText: state.message,
          );
        } else {
          return Skeletonizer(
            enabled: state.loading,
            child: PopularPlacesHorizontalList(
              items: state.items,
            ),
          );
        }
      },
    );
  }
}
