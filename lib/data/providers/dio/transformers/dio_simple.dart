import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import '../../../../locator/locator.dart';
import '../../../../services/env/env.dart';
import 'interceptors/dio_error_interceptor.dart';

/// Простой клиент
class DioSimple extends DioForNative {
  factory DioSimple() => _instance ?? DioSimple._internal();

  DioSimple._internal() {
    final Uri uri = Uri.https(sl<Env>().apiHost, '/');

    options = BaseOptions(
      baseUrl: uri.origin,
    );

    interceptors.add(DioErrorInterceptor());
    _instance = this;
  }

  static DioSimple? _instance;
  Map<String, Interceptor> interceptorWithNames = {};
  void addInterceptor(
      {required String name, required Interceptor interceptor}) {
    if (interceptorWithNames.containsKey(name)) {
      return;
    }
    interceptorWithNames[name] = interceptor;
    interceptors.add(interceptor);
  }

  void deleteInterceptor({required String name}) {
    interceptors.removeWhere((Interceptor element) {
      return element == interceptorWithNames[name];
    });
    interceptorWithNames.remove(name);
  }
}
