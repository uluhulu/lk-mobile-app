import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'channel_notification_interface.dart';

/// Уведомления
class NotifyChannelNotification implements ChannelNotificationInterface {
  const NotifyChannelNotification();

  @override
  AndroidNotificationDetails get android {
    return const AndroidNotificationDetails(
      'notify',
      'Уведомления',
      channelDescription: 'Простые уведомления',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
    );
  }

  @override
  DarwinNotificationDetails get ios {
    return const DarwinNotificationDetails(
      threadIdentifier: 'notify',
      presentSound: true,
    );
  }
}
