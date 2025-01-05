import 'package:flutter/material.dart';
import '../screens/01_sign_up/sign_up_screen.dart';
import '../screens/02_login/login_screen.dart';
import '../screens/03_home/home_screen.dart';
import '../screens/04_government_details/government_details_screen.dart';

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
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.governmentDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => const GovernmentDetailsScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('noRouteFound'),
              ),
              body: const Center(child: Text('noRouteFound')),
            ));
  }
}
