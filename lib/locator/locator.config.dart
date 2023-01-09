// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;

import '../data/providers/local_store_provider.dart' as _i7;
import '../data/providers/repositories/network_info_impl.dart' as _i9;
import '../data/providers/repositories/repository_impl.dart' as _i15;
import '../data/providers/repositories/user_repository_impl.dart' as _i11;
import '../domain/repositories/network_info_repository.dart' as _i8;
import '../domain/repositories/repository.dart' as _i14;
import '../domain/repositories/user_repository.dart' as _i10;
import '../domain/use_cases/auth/sign_in_use_case.dart' as _i16;
import '../services/appmetrica/appmetrica_service.dart' as _i3;
import '../services/firebase/firebase_service.dart' as _i4;
import '../services/notification/firebase_notification.dart' as _i13;
import '../services/notification/local_notification.dart' as _i6;
import '../services/vibration/vibration_service.dart' as _i12;
import 'locator.dart' as _i17; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i4.FirebaseService>(() => _i4.FirebaseService());
  gh.lazySingleton<_i5.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i6.LocalNotification>(() => _i6.LocalNotification());
  gh.singleton<_i7.LocalStoreProvider>(_i7.LocalStoreProvider());
  gh.lazySingleton<_i8.NetworkInfo>(() => _i9.NetworkInfoImpl(
      connectionChecker: get<_i5.InternetConnectionChecker>()));
  gh.lazySingleton<_i10.UserRepository>(() => _i11.UserRepositoryImpl());
  gh.lazySingleton<_i12.VibrationService>(() => _i12.VibrationService());
  gh.lazySingleton<_i13.FirebaseNotification>(() => _i13.FirebaseNotification(
      localNotification: get<_i6.LocalNotification>()));
  gh.lazySingleton<_i14.Repository>(() => _i15.RepositoryImpl(
        networkInfo: get<_i8.NetworkInfo>(),
        userRepository: get<_i10.UserRepository>(),
      ));
  gh.lazySingleton<_i16.SignInUseCase>(
      () => _i16.SignInUseCase(get<_i10.UserRepository>()));
  return get;
}

class _$RegisterModule extends _i17.RegisterModule {
  @override
  _i5.InternetConnectionChecker get internetConnectionChecker =>
      _i5.InternetConnectionChecker();
}
