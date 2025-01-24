import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'app/app_prefs.dart';
import 'app/my_app.dart';
import 'resourses/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppPreferencesImpl.init();
  runApp(
    EasyLocalization(
        supportedLocales: [
          LocalizationUtils.englishLocal,
          LocalizationUtils.arabicLocal
        ],
        path: 'assets/lang',
        fallbackLocale: LocalizationUtils.englishLocal,
        child: MyApp()),
  );
}
