import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../app/di.dart';
import '../../domain/entities/governrate_model.dart';
import '../01_auth_screens/sign_up_screen.dart';
import '../01_auth_screens/login_screen.dart';
import '../02_home/home_screen.dart';
import '../03_governorate _details/governorate _details_screen.dart';
import '../../app/app_prefs.dart';

class Routes {
  static const String signUpRoute = "/";
  static const String loginRoute = "/login_route";
  static const String homeRoute = "/home_route";
  static const String governmentDetailsRoute = "/government_details_route";
}

class RouteGenerator {
  static AppPreferences appPreferences = instance();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.governmentDetailsRoute:
        Governorate governorate = settings.arguments as Governorate;
        return MaterialPageRoute(
            builder: (_) => GovernorateDetailsScreen(
                  governorate: governorate,
                ));
      default:
        return unDefinedRoute();
    }
  }

  static List<Route<dynamic>> generateInitialRoutes(String initialRouteName) {
    if (appPreferences.isUserLoggedIn()) {
      return [MaterialPageRoute(builder: (_) => const HomeScreen())];
    }
    return [MaterialPageRoute(builder: (_) => const SignUpScreen())];
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(tr("noRouteFound")),
              ),
              body: Center(child: Text(tr("noRouteFound"))),
            ));
  }
}
