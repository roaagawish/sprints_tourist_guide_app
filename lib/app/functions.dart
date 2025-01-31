import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../models/place_model.dart';
import '../presentation/02_home/blocs/theme_bloc/theme_bloc.dart';

bool isLightTheme(BuildContext context) {
  return context.read<ThemeBloc>().state.themeMode == ThemeMode.light;
}

List<Place> generateDummyPlacesList() {
  return List.generate(20, (index) {
    return Place(
      name: 'dummy dummy',
      governorate: 'dummy',
      image: '',
      // 'https://th.bing.com/th/id/R.19d85673609bd44f947692ea02c94775?rik=Pkz20f6behuSdA&pid=ImgRaw&r=0',
    );
  });
}

void showToast(String message, Color color) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 20,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
