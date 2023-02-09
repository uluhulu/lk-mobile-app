// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;

import '../data/providers/dio/transformers/interceptors/dio_auth_synchronizer.dart'
    as _i4;
import '../data/providers/local_store_provider.dart' as _i9;
import '../data/providers/repositories/network_info_impl.dart' as _i11;
import '../data/providers/repositories/repository_impl.dart' as _i19;
import '../data/providers/repositories/settings_repository_impl.dart' as _i13;
import '../data/providers/repositories/user_repository_impl.dart' as _i15;
import '../domain/repositories/network_info_repository.dart' as _i10;
import '../domain/repositories/repository.dart' as _i18;
import '../domain/repositories/settings_repository.dart' as _i12;
import '../domain/repositories/user_repository.dart' as _i14;
import '../domain/use_cases/auth/sign_in_use_case.dart' as _i20;
import '../services/appmetrica/appmetrica_service.dart' as _i3;
import '../services/firebase/firebase_service.dart' as _i5;
import '../services/itunes/itunes_search_api.dart' as _i6;
import '../services/notification/firebase_notification.dart' as _i17;
import '../services/notification/local_notification.dart' as _i8;
import '../services/vibration/vibration_service.dart' as _i16;
import 'locator.dart' as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppMetricaService>(() => _i3.AppMetricaService());
  gh.singleton<_i4.AuthSynchronizer>(_i4.AuthSynchronizer());
  gh.lazySingleton<_i5.FirebaseService>(() => _i5.FirebaseService());
  gh.lazySingleton<_i6.ITunesSearchAPI>(() => _i6.ITunesSearchAPI());
  gh.lazySingleton<_i7.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i8.LocalNotification>(() => _i8.LocalNotification());
  gh.singleton<_i9.LocalStoreProvider>(_i9.LocalStoreProvider());
  gh.lazySingleton<_i10.NetworkInfo>(() => _i11.NetworkInfoImpl(
      connectionChecker: get<_i7.InternetConnectionChecker>()));
  gh.lazySingleton<_i12.SettingsRepository>(
      () => _i13.SettingsRepositoryImpl());
  gh.lazySingleton<_i14.UserRepository>(() => _i15.UserRepositoryImpl());
  gh.lazySingleton<_i16.VibrationService>(() => _i16.VibrationService());
  gh.lazySingleton<_i17.FirebaseNotification>(() => _i17.FirebaseNotification(
      localNotification: get<_i8.LocalNotification>()));
  gh.lazySingleton<_i18.Repository>(() => _i19.RepositoryImpl(
        networkInfo: get<_i10.NetworkInfo>(),
        userRepository: get<_i14.UserRepository>(),
      ));
  gh.lazySingleton<_i20.SignInUseCase>(
      () => _i20.SignInUseCase(get<_i14.UserRepository>()));
  return get;
}

class _$RegisterModule extends _i21.RegisterModule {
  @override
  _i7.InternetConnectionChecker get internetConnectionChecker =>
      _i7.InternetConnectionChecker();
}
