import 'package:flutter/material.dart';
import 'package:mkk/presentation/pages/main/views/main_content.dart';
import '../core/help/navigation_route_params.dart';
import '../presentation/navigation/navigation_page_route.dart';
import '../presentation/pages/loca_auth/views/set_pin_code_page.dart';
import '../presentation/pages/main/main_screen.dart';
import '../presentation/pages/not_found/not_found_screen.dart';
import '../presentation/pages/profile/act/views/act_page.dart';
import '../presentation/pages/restore_password/views/restore_password_page.dart';

/// Роуты
class AppRoutes {
  static const String init = '/',
      home = '/home',
      authorized = '/authorized',
      restorePassword = '/restorePassword',
      setPin = '/setPin',
      act = '/act',
      test1 = '/test1',
      test2 = '/test2',
      test3 = '/test3',
      test4 = '/test4';

  static Widget? child;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    late final WidgetBuilder builder;
    late final NavigationRouteParams baseArguments;

    if (settings.arguments is NavigationRouteParams) {
      baseArguments = settings.arguments! as NavigationRouteParams;
    }

    switch (settings.name) {
      case init:
        builder = (BuildContext _) => child ?? const NotFoundScreen();
        break;
      case restorePassword:
        builder = (BuildContext _) => const RestorePasswordProvider();
        break;
      case home:
        builder = (BuildContext _) => const MainScreen();
        break;
      case test1:
        builder = (BuildContext _) => const TestPage(index: 1);
        break;
      case test2:
        builder = (BuildContext _) => const TestPage(index: 2);
        break;
      case test3:
        builder = (BuildContext _) => const TestPage(index: 3);
        break;
      case test4:
        builder = (BuildContext _) => const TestPage(index: 4);
        break;
      case setPin:
        builder = (BuildContext _) => const SetPinCodePage();
        break;
      case act:
        builder = (BuildContext _) => const ActProvider();
        break;

      // case authorized:
      //   builder = (BuildContext _) => const AuthorizationPage(
      //         child: DocumentListProvider(),
      //       );
      //   break;

      default:
        builder = (BuildContext _) => const NotFoundScreen();
    }

    return NavigationPageRoute<void>(builder: builder, settings: settings);
  }
}
