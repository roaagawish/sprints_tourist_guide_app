import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/place_model.dart';
import '../screens/02_home/blocs/theme_bloc/theme_bloc.dart';

bool isLightTheme(BuildContext context) {
  return context.read<ThemeBloc>().state.themeMode == ThemeMode.light;
}

List<Place> generateDummyPlacesList() {
  return List.generate(20, (index) {
    return Place(
      name: 'dummy dummy',
      governorate: 'dummy',
      image: 'assets/png/pyramids.png',
    );
  });
}
