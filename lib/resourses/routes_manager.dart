import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/governrate_model.dart';
import '../screens/01_sign_up/sign_up_screen.dart';
import '../screens/02_login/login_screen.dart';
import '../screens/03_home/home_screen.dart';
import '../screens/04_governorate _details/governorate _details_screen.dart';

class Routes {
  static const String signUpRoute = "/";
  static const String loginRoute = "/login_route";
  static const String homeRoute = "/home_route";
  static const String governmentDetailsRoute = "/government_details_route";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(
            builder: (context) => LoginScreen(
                  localeChangeCallback: (languageCode, countryCode) =>
                      context.setLocale(Locale(languageCode, countryCode)),
                  signInSuccessfulCallback: () =>
                      Navigator.of(context).pushNamed(Routes.homeRoute),
                ));
      case Routes.homeRoute:
        return MaterialPageRoute(
            builder: (context) => HomeScreen(
                  localeChangeCallback: (languageCode, countryCode) =>
                      context.setLocale(Locale(languageCode, countryCode)),
                ));
      case Routes.governmentDetailsRoute:
        Governorate governorate = settings.arguments as Governorate;
        return MaterialPageRoute(
            builder: (context) => GovernorateDetailsScreen(
                  localeChangeCallback: (languageCode, countryCode) =>
                      context.setLocale(Locale(languageCode, countryCode)),
                  governorate: governorate,
                ));
      default:
        return unDefinedRoute();
    }
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
