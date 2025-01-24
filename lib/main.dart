import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'resourses/local_database.dart';
import 'resourses/routes_manager.dart';
import 'resourses/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocalDataBase.init();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
        path: 'assets/lang',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()),
  );
}

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
      themeMode: ThemeMode.light,
      theme: getlightTheme(),
      initialRoute: Routes.signUpRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      onGenerateInitialRoutes: RouteGenerator.generateInitialRoutes,
    );
  }
}
