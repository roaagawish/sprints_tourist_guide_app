import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app_prefs.dart';
import 'app/my_app.dart';
import 'resourses/language_manager.dart';
import 'screens/02_home/blocs/theme_bloc/theme_bloc.dart';

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
        child: BlocProvider(
          create: (_) => ThemeBloc(AppPreferencesImpl())..add(LoadTheme()),
          child: MyApp(),
        )),
  );
}
