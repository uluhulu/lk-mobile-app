import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'channel_notification_interface.dart';

/// Скачивание файла
class FileDownloadChannelNotification implements ChannelNotificationInterface {
  const FileDownloadChannelNotification();

  @override
  AndroidNotificationDetails get android {
    return const AndroidNotificationDetails(
      'file_download',
      'Скачивание файлов',
      channelDescription: 'Уведомления при скачивании файлов',
      importance: Importance.max,
      // priority: Priority.high,
      enableLights: true,
      playSound: false,
    );
  }

  @override
  DarwinNotificationDetails get ios {
    return const DarwinNotificationDetails(
      threadIdentifier: 'file_download',
      presentSound: false,
    );
  }
}
