
import 'action_notification_abstract.dart';

/// Простое нажатие
class NoneActionNotification extends ActionNotificationAbstract {
  NoneActionNotification() : super(ActionNotificationType.NONE);

  @override
  Future<dynamic> execute() async {}
}
