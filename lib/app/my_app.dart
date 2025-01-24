import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../resourses/routes_manager.dart';
import '../resourses/theme_manager.dart';
import '../screens/02_home/blocs/theme_bloc/theme_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: tr("title"),
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeBloc>().state.themeMode,
      theme: getlightTheme(),
      darkTheme: getDarkTheme(),
      initialRoute: Routes.signUpRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      onGenerateInitialRoutes: RouteGenerator.generateInitialRoutes,
    );
  }
}
