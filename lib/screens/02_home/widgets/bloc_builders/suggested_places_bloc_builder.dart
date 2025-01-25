import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../blocs/suggested_places/suggested_places_bloc.dart';
import '../places_grid_view.dart';
import '../state_widgets/error_state_widget.dart';

class SuggestedPlacesBlocBuilder extends StatelessWidget {
  const SuggestedPlacesBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestedPlacesBloc, SuggestedPlacesState>(
      builder: (context, state) {
        if (state is SuggestedPlacesError) {
          return ErrorStateWidget(
            width: MediaQuery.sizeOf(context).width * 0.3,
            errorText: state.message,
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
