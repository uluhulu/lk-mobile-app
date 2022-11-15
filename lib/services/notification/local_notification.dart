//class FirebaseNotification singleton
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../logger/logger_service.dart';
import '../platform.dart';
import 'channels/channel_notification_interface.dart';
import 'channels/dialog_channel_notification.dart';
import 'channels/file_download_channel_notification.dart';
import 'channels/notify_channel_notification.dart';
import 'notification_entity.dart';

@lazySingleton
class LocalNotification {
  LocalNotification();
  bool _initilized = false;
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  StreamController<bool> _globalInitializeController =
      StreamController<bool>.broadcast();
  bool? _globalInitialized = null;
  Future<bool> get globalInitialized => _globalInitialized == null
      ? _globalInitializeController.stream.first
      : Future.value(_globalInitialized);
  set globalInitialize(bool? value) {
    _globalInitialized = value;
    if (value != null) {
      _globalInitializeController.add(false);
    }
  }

  FutureOr<void> initialize() async {
    if (isWindows() || isWeb()) {
      return;
    }
    if (_initilized) {
      return;
    }
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings(
      'app_icon',
    );
    DarwinInitializationSettings darwinSettings = DarwinInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    LinuxInitializationSettings linuxSettings = LinuxInitializationSettings(
        defaultActionName: 'launch',
        defaultIcon: AssetsLinuxIcon('assets/icon/icon.png'));
    InitializationSettings settings = InitializationSettings(
        android: androidSettings,
        iOS: darwinSettings,
        macOS: darwinSettings,
        linux: linuxSettings);

    await _createAndroidChannel(
      const NotifyChannelNotification().android,
    );
    await _createAndroidChannel(
      const FileDownloadChannelNotification().android,
    );
    await _createAndroidChannel(
      const DialogChannelNotification().android,
    );

    final succed = await FlutterLocalNotificationsPlugin().initialize(
      settings,
    );
    L.i('LocalNotification initilized: $succed');
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initilized = true;
  }

  final StreamController<NotificationEntity> _streamController =
      StreamController<NotificationEntity>.broadcast();
  Stream<NotificationEntity> get stream => _streamController.stream;
  FutureOr<bool> requestPermisson() async {
    if (isIOS()) {
      final result = await _flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            sound: true,
            badge: true,
            alert: true,
          );
      return result ?? false;
    }
    if (isMacOS()) {
      final result = await _flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            sound: true,
            badge: true,
            alert: true,
          );
      return result ?? false;
    }
    if (isAndroid()) {
      final result = await _flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled();
      return result ?? false;
    }
    return true;
  }

  Future<void> showNotification(
    NotificationEntity notification, {
    ChannelNotificationInterface? details,
  }) async {
    details ??= notification.channel;
    details ??= NotifyChannelNotification();
    final notificationDetails = NotificationDetails(
        android: details.android,
        iOS: details.ios,
        macOS: details.ios,
        linux: LinuxNotificationDetails());
    await _flutterLocalNotificationsPlugin?.show(
      Random().nextInt(999999),
      notification.notification?.title ?? '',
      notification.notification?.body ?? '',
      notificationDetails,
      payload: notification.data.isEmpty ? null : jsonEncode(notification.data),
    );
  }

  static Future<void> _createAndroidChannel(
    AndroidNotificationDetails android,
  ) async {
    final AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      android.channelId,
      android.channelName,
      description: android.channelDescription,
    );

    FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  Future<void> checkActiveNotifications() async {
    if (isAndroid()) {
      L.i('checkActiveNotifications');
      final notifications = await FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.getActiveNotifications();
      for (var notification in notifications ?? <ActiveNotification>[]) {
        L.i('ActiveNotification: {id: ${notification.id}, title: ${notification.title}, body: ${notification.body}}');
      }
    }
  }

  static Future<void> _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    L.i('_onDidReceiveLocalNotification: ($id, $title, $body, $payload)');
  }
}
