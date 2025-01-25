import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../blocs/favorite_places/favorite_places_bloc.dart';
import '../places_grid_view.dart';
import '../state_widgets/empty_state_widget.dart';
import '../state_widgets/error_state_widget.dart';

class FavoritePlacesBlocBuilder extends StatelessWidget {
  const FavoritePlacesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritePlacesBloc, FavoritePlacesState>(
      builder: (context, state) {
        if (state is FavoritePlacesError) {
          return ErrorStateWidget(
            width: MediaQuery.sizeOf(context).width * 0.3,
            errorText: state.message,
          );
        } else if (state is FavoritePlacesEmpty) {
          return EmptyStateWidget(
            label: tr("taps.emptyFav"),
          );
        } else {
          return Skeletonizer(
            enabled: state.loading,
            child: PlacesGridView(
              places: state.items,
            ),
          );
        }
      },
    );
  }
}
