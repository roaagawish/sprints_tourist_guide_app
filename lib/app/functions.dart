import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/02_home/blocs/theme_bloc/theme_bloc.dart';

bool isLightTheme(BuildContext context) {
  return context.read<ThemeBloc>().state.themeMode == ThemeMode.light;
}
