import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:mkk/locator/locator.dart';
import '../../../../../services/notification/local_notification.dart';

import '../../../../../services/platform.dart';
import '../../../../config/app_routes.dart';

/// Навигатор
class MainNavigator extends StatelessWidget {
  const MainNavigator({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    AppRoutes.child = child;
    FirebaseAnalytics? analytics;
    if (!isPc()) {
      analytics = FirebaseAnalytics.instance;
    }
    sl<LocalNotification>().globalInitialize = true;
    return WillPopScope(
      onWillPop: () async {
        _navigatorStates().forEach(_navigatorPop);
        return false;
      },
      child: Navigator(
        key: AppRoutes.navigatorKey,
        initialRoute: AppRoutes.init,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        observers: <NavigatorObserver>[
          if (analytics != null) ...[
            FirebaseAnalyticsObserver(analytics: analytics)
          ],
        ],
      ),
    );
  }

  List<NavigatorState?> _navigatorStates() {
    return <NavigatorState?>[
      AppRoutes.navigatorKey.currentState,
      // HomeRoutes.navigatorKey.currentState,
      // PersonRoutes.navigatorKey.currentState,
    ];
  }

  void _navigatorPop(NavigatorState? state) {
    if (state != null && state.canPop() == true) {
      state.pop();
    }
  }
}
