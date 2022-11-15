import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'locator.config.dart';

///Service Locator
final sl = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(sl);

@module
abstract class RegisterModule {
  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker;
}
