import 'package:flutter/cupertino.dart';

import '../../logger/logger_service.dart';
import 'action_notification_abstract.dart';

/// Перенаправление на страницу
class PushRouteActionNotification extends ActionNotificationAbstract {
  PushRouteActionNotification(this.routeName, [this.id])
      : super(ActionNotificationType.push_route);

  factory PushRouteActionNotification.toRoute(String routeName, int? id) {
    return PushRouteActionNotification(routeName, id);
  }

  factory PushRouteActionNotification.fromData(Map<String, dynamic> data) {
    final String routeName =
        data.containsKey('routeName') ? data['routeName'] as String : '';

    if (data.containsKey('id') == true) {
      final int id = data['id'] is String
          ? int.parse(data['id'] as String)
          : data['id'] as int;

      return PushRouteActionNotification(routeName, id);
    }

    return PushRouteActionNotification(routeName);
  }

  final String routeName;
  final int? id;

  @override
  bool isValid(Map<String, dynamic> data) {
    final superValid = super.isValid(data);
    final isContains = data.containsKey('routeName');
    L.i('PushRouteActionNotification.isValid: {superValid: $superValid,isContains: $isContains}');
    return superValid && isContains;
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll(<String, dynamic>{
        'routeName': routeName,
        'id': id,
      });
  }

  @override
  Future<dynamic> execute() async {
    WidgetsFlutterBinding.ensureInitialized();

    // final navigatorId = id != null ? NavigationRouteParams(id!) : null;
    // final initialized = await sl<LocalNotification>().globalInitialized;
    // if(!initialized){
    //   await Future.delayed(Duration(seconds: 1));
    // }
    // for (var i = 0; i < 10; i++) {
    //   if(AppRoutes.navigatorKey.currentState != null){
    //     break;
    //   }
    //   await Future.delayed(Duration(seconds: 1));
    // }

    // switch (routeName) {
    //   case '/notify':
    //     await AppRoutes.navigatorKey.currentState?.pushNamed(AppRoutes.notify);
    //     break;
    //   case '/offer/detail':
    //     await AppRoutes.navigatorKey.currentState
    //         ?.pushNamed(AppRoutes.offerDetail, arguments: navigatorId);
    //     break;
    //   case '/person/operation_history':
    //     await AppRoutes.navigatorKey.currentState
    //         ?.pushNamed(AppRoutes.operationHistory);
    //     break;
    //   case '/message/chat':
    //     await AppRoutes.navigatorKey.currentState
    //         ?.pushNamed(AppRoutes.messageChat, arguments: navigatorId);
    //     break;
    //   default:
    // }
  }
}
