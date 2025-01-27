import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app_prefs.dart';
import 'app/my_app.dart';
import 'resourses/language_manager.dart';
import 'screens/01_auth_screens/bloc/auth_bloc.dart';
import 'screens/02_home/blocs/theme_bloc/theme_bloc.dart';
import 'simple_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppPreferencesImpl.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = SimpleObserver();
  final initialUserData = await AppPreferencesImpl.loadUserData();
  final initialAvatar = await AppPreferencesImpl.loadUserAvatar();
  runApp(
    EasyLocalization(
        supportedLocales: [
          LocalizationUtils.englishLocal,
          LocalizationUtils.arabicLocal
        ],
        path: 'assets/lang',
        fallbackLocale: LocalizationUtils.englishLocal,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => AuthBloc(appPreferences: AppPreferencesImpl())),
            BlocProvider(
              create: (_) => ThemeBloc(AppPreferencesImpl())..add(LoadTheme()),
            )
          ],
          child: MyApp(),
        )),
  );
}
