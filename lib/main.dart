import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'app/app_prefs.dart';
import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppPreferencesImpl.init();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
        path: 'assets/lang',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()),
  );
}
