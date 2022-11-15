import 'dart:convert';

import '../../logger/logger_service.dart';

enum ActionNotificationType {
  OPEN_FILE,
  push_route,
  NONE,
}

abstract class ActionNotificationAbstract {
  ActionNotificationAbstract(this.action);

  final ActionNotificationType action;

  bool isValid(Map<String, dynamic> data) {
    final contains = data.containsKey('action');
    final action = data['action'] as String;
    final isEquals = action == this.action.toString();
    L.i('ActionNotificationAbstract.isValid: {contains: $contains,action: $action,isEquals: $isEquals}');
    return contains && isEquals;
  }

  @override
  String toString() => jsonEncode(toMap());

  Map<String, dynamic> toMap() =>
      <String, dynamic>{'action': action.toString()};

  Future<dynamic> execute();
}
