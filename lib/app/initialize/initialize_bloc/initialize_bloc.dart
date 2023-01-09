import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mkk/services/filter_saver_service.dart';
import '../../../core/components/analytics_client.dart';
import '../../../core/components/device_info.dart';
import '../../../core/components/local_store_client.dart';
import '../../../data/providers/dio/transformers/dio_client.dart';
import '../../../services/appmetrica/appmetrica_service.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../services/logger/logger_service.dart';
import '../../../services/notification/firebase_notification.dart';
import '../../../services/notification/local_notification.dart';
import '../../../services/package_info_services.dart';

part 'initialize_event.dart';
part 'initialize_state.dart';

class InitializeBloc extends Bloc<InitializeEvent, InitializeState> {
  final LocalNotification localNotification;
  final FirebaseNotification firebaseNotification;
  final FirebaseService firebaseService;
  final AppMetricaService appMetricaService;
  InitializeBloc({
    required this.localNotification,
    required this.firebaseNotification,
    required this.firebaseService,
    required this.appMetricaService,
  }) : super(InitializeAppSplashS()) {
    on<InitializeE>(_initialize);
    on<InitializeRevokeE>(_initializeRevoke);
  }

  FutureOr<void> _initialize(
      InitializeE event, Emitter<InitializeState> emit) async {
    emit(InitializeAppSplashS());

    try {
      await _initializeLocalStoreClient(emit);
      await firebaseService.initialize();
      await _initializeOther(emit);
    } catch (e) {
      emit(InitializeErrorS(e.toString()));
      L.e('InitializeError: $e');
    }
    await Future.delayed(const Duration(milliseconds: 1200), () {
      emit(InitializeDoneS());
    });

    await _initializeOnOpenApp(emit);
    try {
      await _initializeMessaging(emit);
      await _initializeAppMetrica();
    } catch (e) {
      L.e(e);
    }
  }

  FutureOr<void> _initializeAppMetrica() {
    try {
      appMetricaService.initialize();
    } catch (e) {
      L.e(e);
    }
  }

  FutureOr<void> _initializeMessaging(Emitter<InitializeState> emit) async {
    await localNotification.initialize();
    await firebaseNotification.initialize();
    L.i("Messaging initialized");
  }

  FutureOr<void> _initializeOnOpenApp(Emitter<InitializeState> emit) async {
    await firebaseNotification.onOpenApp();
  }

  FutureOr<void> _initializeRevoke(
      InitializeRevokeE event, Emitter<InitializeState> emit) {
    localNotification.globalInitialize = null;
    emit(InitializeAppSplashS());
  }

  FutureOr<void> _initializeLocalStoreClient(
      Emitter<InitializeState> emit) async {
    LocalStoreClient.initialize();
    PackageInfoService.instance.init();
    FilterSaverService.instance.init();
  }

  FutureOr<void> _initializeOther(Emitter<InitializeState> emit) async {
    await Future.wait(<Future<void>>[
      AnalyticsClient.initialize(),
      DeviceInfo.initialize(),
    ]);
    await AnalyticsClient().setAnalyticsState(
      enabled: true,
    );
    // DioClient.initialize(
    //   baseUrl: 'lk-stage.puls.ru',
    //   userAgent: DeviceInfo().userAgent,
    // );
    L.i("Other initialized");
  }
}
