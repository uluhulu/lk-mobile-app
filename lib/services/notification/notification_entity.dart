import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:json_annotation/json_annotation.dart';

import 'channels/channel_notification_interface.dart';
import 'channels/dialog_channel_notification.dart';
import 'channels/file_download_channel_notification.dart';

part 'notification_entity.g.dart';

enum NotificationChannel{
  inApp,
  openApp,
  backGround
}

@JsonSerializable()
class NotificationEntity extends Equatable {
/// The ID of the upstream sender location.
  final String? senderId;

  /// The iOS category this notification is assigned to.
  final String? category;

  /// The collapse key a message was sent with. Used to override existing messages with the same key.
  final String? collapseKey;

  /// Whether the iOS APNs message was configured as a background update notification.
  final bool contentAvailable;

  /// Any additional data sent with the message.
  final Map<String, dynamic> data;

  /// The topic name or message identifier.
  final String? from;

  /// A unique ID assigned to every message.
  final String? messageId;

  /// The message type of the message.
  final String? messageType;

  /// Whether the iOS APNs `mutable-content` property on the message was set
  /// allowing the app to modify the notification via app extensions.
  final bool mutableContent;

  /// Additional Notification data sent with the message.
  final RemoteNotificationEntity? notification;

  /// The time the message was sent, represented as a [DateTime].
  final DateTime? sentTime;

  /// An iOS app specific identifier used for notification grouping.
  final String? threadId;
  
  final NotificationChannel notificationChannel;

  /// Channel
  @JsonKey(ignore: true)
  ChannelNotificationInterface? channel;
  final int? ttl;
  NotificationEntity({
    this.senderId,
    this.category,
    this.collapseKey,
    required this.contentAvailable,
    required this.data,
    this.from,
    this.messageId,
    this.messageType,
    required this.mutableContent,
    this.notification,
    this.sentTime,
    this.threadId,
    this.ttl,
    this.channel,
    this.notificationChannel = NotificationChannel.backGround,
  });

  factory NotificationEntity.fromRemoteMessage(RemoteMessage i, {NotificationChannel? channel}) {
    return NotificationEntity(
      senderId: i.senderId,
      category: i.category,
      collapseKey: i.collapseKey,
      contentAvailable: i.contentAvailable,
      data: i.data,
      from: i.from,
      messageId: i.messageId,
      messageType: i.messageType,
      mutableContent: i.mutableContent,
      notification: i.notification != null ? RemoteNotificationEntity.fromRemoteMessage(i.notification!) : null,
      sentTime: i.sentTime,
      threadId: i.threadId,
      ttl: i.ttl,
      notificationChannel: channel ?? NotificationChannel.backGround,
    );
  }

  factory NotificationEntity.fileDownload({
    required int id,
    String? title,
    String? body,
    Map<String,dynamic>? data,
  }) {
    return NotificationEntity(
      notification: RemoteNotificationEntity(
        title: 'Файл $title загружен',
        body: body,
      
      ),
      contentAvailable: true,
      mutableContent: true,
      data: data ?? {},
      channel: const FileDownloadChannelNotification(),
    );
  }
  factory NotificationEntity.dialog({
    required int id,
    String? title,
    String? body,
    Map<String,dynamic>? data,
  }) {
    return NotificationEntity(
      contentAvailable: true,
      mutableContent: true,
      data: data ?? {},
      channel: const DialogChannelNotification(),
      notification: RemoteNotificationEntity(
        title: title,
        body: body,
      ),
    );
  }

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);
  
  Map<String, dynamic> toJson() => _$NotificationEntityToJson(this);
  
  @override
  List<Object?> get props => [
        senderId,
        category,
        collapseKey,
        contentAvailable,
        data,
        from,
        messageId,
        messageType,
        mutableContent,
        notification,
        sentTime,
        threadId,
        ttl,
      ];

}

@JsonSerializable()
class RemoteNotificationEntity extends Equatable {

  /// The notification title.
  final String? title;

  /// The notification body content.
  final String? body;
  const RemoteNotificationEntity({
    this.title,
    this.body,
  });
  
  @override
  List<Object?> get props => [title, body];

  factory RemoteNotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$RemoteNotificationEntityFromJson(json);
  
  Map<String, dynamic> toJson() => _$RemoteNotificationEntityToJson(this);
  
  factory RemoteNotificationEntity.fromRemoteMessage(RemoteNotification notification) {
    return RemoteNotificationEntity(
      title: notification.title,
      body: notification.body,
    );
  }


}
