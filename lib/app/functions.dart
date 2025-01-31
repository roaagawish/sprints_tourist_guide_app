import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import '../domain/entities/auth_entity.dart';
import '../models/place_model.dart';
import '../presentation/02_home/blocs/theme_bloc/theme_bloc.dart';
import '../presentation/resourses/constant_manager.dart';

Future<void> hiveBoxes() async {
  await Hive.openBox<AuthenticationEntity>(AppConstants.kUserDataBox);
}

void hiveAdapters() {
  Hive.registerAdapter(AuthenticationEntityAdapter());
}

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
