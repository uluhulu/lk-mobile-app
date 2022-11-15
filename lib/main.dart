import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mkk/presentation/app_screen.dart';
import 'package:mkk/presentation/pages/banner/banner_widget.dart';
import 'package:mkk/services/env/env.dart';
import 'package:mkk/services/platform.dart';
import 'app/initialize/initialize_page.dart';
import 'config/app_routes.dart';
import 'config/theme/theme_bloc/theme_bloc.dart';
import 'presentation/pages/loca_auth/local_auth_provider.dart';
import 'services/appmetrica/appmetrica_service.dart';
import 'services/error/bloc/error_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'config/theme/elements/theme_data.dart';
import 'config/theme/theme_manager.dart';
import 'config/theme/theme_mode.dart';
import 'config/theme/themes/dark/my_theme_data_dark.dart';
import 'config/theme/themes/light/app_theme_light.dart';
import 'config/theme/themes/light/my_theme_data_light.dart';
import 'generated/l10n.dart';
import 'locator/locator.dart' as di;
import 'locator/locator.dart';
import 'observer.dart';
import 'route_observer.dart';

var errorBloc = ErrorBloc();
String joinPath(String p1, String p2) {
  if (Platform.isWindows) {
    return '$p1\\$p2';
  } else {
    return '$p1/$p2';
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Storage? storage;
bool initialized = false;
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  di.configureDependencies();
  sl.registerSingleton<Env>(EnvProduction());
  HttpOverrides.global = MyHttpOverrides();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      HydratedBloc.storage = await _createStorage();
      Bloc.observer = AppBlocObserver();
      runApp(const MainAppProvider());
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
  FlutterNativeSplash.remove();
}

FutureOr<Storage> _createStorage() async {
  if (storage != null) return storage!;
  if (isWeb()) {
    storage = await HydratedStorage.build(
        storageDirectory: HydratedStorage.webStorageDirectory);
    return storage!;
  }
  WidgetsFlutterBinding.ensureInitialized();
  Directory? storageDirectory;
  try {
    storageDirectory = await getApplicationDocumentsDirectory();
  } catch (e) {
    log('Error getting application documents directory: $e');
  }
  var path = joinPath(
      storageDirectory == null
          ? Directory.systemTemp.path
          : storageDirectory.path,
      'money_friends');
  path = joinPath(path, 'hydrated_bloc');
  storageDirectory ??= Directory(path);
  storage = await HydratedStorage.build(storageDirectory: storageDirectory);
  return storage!;
}

class MainAppProvider extends StatelessWidget {
  const MainAppProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ErrorBloc>.value(
      value: errorBloc,
      child: BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        MyThemeData? themeData;
        var brightness = SchedulerBinding.instance.window.platformBrightness;
        var theme = MyThemeMode.system;
        if (state is ThemeS) {
          theme = state.theme;
          if (theme == MyThemeMode.dark) {
            brightness = Brightness.dark;
            themeData = MyThemeDataDark();
          }
          if (theme == MyThemeMode.light) {
            brightness = Brightness.light;
            themeData = MyThemeDataLight();
          }
        }
        themeData ??= brightness == Brightness.dark
            ? MyThemeDataDark()
            : MyThemeDataLight();
        return MyTheme(
          data: themeData,
          child: LocalAuthProvider(
            child: BannerProvider(
              child: MaterialApp(
                navigatorObservers: [
                  routeObserver,
                ],

                localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: const Locale('ru', 'RU'),
                debugShowCheckedModeBanner: false,
                title: 'mkk',
                themeMode: theme.themeMode,
                onGenerateRoute: AppRoutes.onGenerateRoute,
                // darkTheme:
                //     ThemeManager.createTheme(const AppThemeDark(), ThemeMode.dark),
                theme: ThemeManager.createTheme(
                    const AppThemeLight(), ThemeMode.light),
                home: InitializePage(
                  child: BlocProvider<ErrorBloc>.value(
                    value: errorBloc,
                    child: const AppScreen(),
                  ),
                ),
                //
                // home: const AppScreen(),
              ),
            ),
          ),
        );
      },
    );
  }
}
