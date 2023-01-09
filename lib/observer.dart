import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mkk/services/logger/logger_service.dart';

/// Слушатель событий блока
class AppBlocObserver extends BlocObserver {
  @override
  void onError(
    BlocBase<dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    Logger().e(
      error,
      error,
      stackTrace,
    );

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    L.d('BlocName: $bloc: onEvent: $event');

    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // Logger().v(change);    super.onChange(bloc, change);
  }
}
