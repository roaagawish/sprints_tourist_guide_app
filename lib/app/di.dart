import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/data_source/local_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/login_usecase.dart';
import '../domain/usecase/logout_usecase.dart';
import '../domain/usecase/register_usecase.dart';
import 'app_prefs.dart';
import 'validation_service.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferencesImpl(instance()));
  // validation service instance for all text form fields in the app
  instance
      .registerLazySingleton<IValidationService>(() => ValidationServiceImpl());
  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker.instance));
  // remote data source
  final firebaseInstance = FirebaseAuth.instance;
  instance.registerLazySingleton<FirebaseAuth>(() => firebaseInstance);
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<FirebaseAuth>()));
  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance(), instance()));
  // login usecase
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
  }
  // register usecase
  if (!GetIt.I.isRegistered<RegisterUsecase>()) {
    instance
        .registerFactory<RegisterUsecase>(() => RegisterUsecase(instance()));
  }
  // logout usecase
  if (!GetIt.I.isRegistered<LogoutUsecase>()) {
    instance.registerFactory<LogoutUsecase>(() => LogoutUsecase(instance()));
  }
}
