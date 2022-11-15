//class FirebaseNotification singleton
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../locator/locator.dart';
import '../env/env.dart';
import '../logger/logger_service.dart';
import '../platform.dart';
import 'local_notification.dart';
import 'notification_entity.dart';

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  // final LocalNotification localNotification = LocalNotification();
  // final FirebaseNotification firebaseNotification = FirebaseNotification(localNotification: localNotification);
  // firebaseNotification.backgroundMessage(message);

  final NotificationEntity notification =
      NotificationEntity.fromRemoteMessage(message);
  L.d('_onBackgroundMessage: $notification');
}

@lazySingleton
class FirebaseNotification {
  FirebaseNotification({required this.localNotification});
  late String vapidKey = sl<Env>().vapidKey;
  String _token = '';
  String get token => _token;
  FutureOr<void> initialize() async {
    if (isPc()) {
      return;
    }
    await localNotification.initialize();
    // await FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    FirebaseMessaging.instance.onTokenRefresh.listen(_onTokenRefresh);
    NotificationSettings? notificationSettings;
    if (isWeb()) {
      notificationSettings =
          await FirebaseMessaging.instance.requestPermission();
    }
    if (notificationSettings != null) {
      if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.denied) {
        return;
      }
    }
    final gettedToken =
        await FirebaseMessaging.instance.getToken(vapidKey: vapidKey);
    if (gettedToken != null) {
      _token = gettedToken;
    }
    L.i('FirebaseNotification initialized');
    L.i('FirebaseNotification token:\n$_token\n');

    stream.listen(_onNotification);
  }

  final LocalNotification localNotification;
  final StreamController<NotificationEntity> _streamController =
      StreamController<NotificationEntity>.broadcast();
  Stream<NotificationEntity> get stream => _streamController.stream;

  void _onTokenRefresh(String event) {
    _token = event;
    L.i('FirebaseNotification token: \n$_token\n');
  }

  void firebaseToLocalNotification(NotificationEntity notificationEntity) {
    localNotification.showNotification(notificationEntity);
  }

  Future<void> onOpenApp() async {
    if (isPc()) return;
    final remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      _onMessageOpenedApp(remoteMessage);
    }
  }

  void _onMessage(RemoteMessage message) {
    L.i('onMessage: RemoteMessage{data: ${message.data}, notification: ${message.notification}}');

    _streamController.add(NotificationEntity.fromRemoteMessage(message,
        channel: NotificationChannel.inApp));
  }

  void _onMessageOpenedApp(RemoteMessage message) async {
    _streamController.add(NotificationEntity.fromRemoteMessage(message,
        channel: NotificationChannel.openApp));
    final data = message.data;
    L.i(data);
  }

  void _onNotification(NotificationEntity event) {
    if (event.notification == null) {
      return;
    }
    firebaseToLocalNotification(event);
  }

  Future<void> deleteToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  Future<void> loadNewToken() async {
    final gettedToken =
        await FirebaseMessaging.instance.getToken(vapidKey: vapidKey);
    if (gettedToken != null) {
      _token = gettedToken;
    }
    L.i('NewFirebaseToken:');
    L.i('$gettedToken\n');
  }

  Future<void> subscribeToTopics(List<String> topics) async {
    if (isPc()) return;
    L.i('Subscribe to topics: $topics');
    for (final topic in topics) {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    }
  }

  Future<void> logOut() async {
    if (isPc()) return;
    return FirebaseMessaging.instance.deleteToken();
  }
}
