import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class ChannelNotificationInterface {
  AndroidNotificationDetails get android;
  DarwinNotificationDetails get ios;
}
