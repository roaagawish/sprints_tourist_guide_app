import 'package:flutter/material.dart';
import 'resourses/routes_manager.dart';
import 'resourses/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sprint tourist guide Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: getlightTheme(),
      initialRoute: Routes.homeRoute, //TODO: change to any route
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
