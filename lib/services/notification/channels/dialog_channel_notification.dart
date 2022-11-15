import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'channel_notification_interface.dart';

/// Чаты и сообщения
class DialogChannelNotification implements ChannelNotificationInterface {
  const DialogChannelNotification();

  @override
  AndroidNotificationDetails get android {
    return const AndroidNotificationDetails(
      'dialog',
      'Сообщения',
      channelDescription: 'Чаты и сообщения',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
    );
  }

  @override
  DarwinNotificationDetails get ios {
    return const DarwinNotificationDetails(
      threadIdentifier: 'dialog',
      presentSound: true,
    );
  }
}
