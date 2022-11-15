// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationEntity _$NotificationEntityFromJson(Map<String, dynamic> json) =>
    NotificationEntity(
      senderId: json['senderId'] as String?,
      category: json['category'] as String?,
      collapseKey: json['collapseKey'] as String?,
      contentAvailable: json['contentAvailable'] as bool,
      data: json['data'] as Map<String, dynamic>,
      from: json['from'] as String?,
      messageId: json['messageId'] as String?,
      messageType: json['messageType'] as String?,
      mutableContent: json['mutableContent'] as bool,
      notification: json['notification'] == null
          ? null
          : RemoteNotificationEntity.fromJson(
              json['notification'] as Map<String, dynamic>),
      sentTime: json['sentTime'] == null
          ? null
          : DateTime.parse(json['sentTime'] as String),
      threadId: json['threadId'] as String?,
      ttl: json['ttl'] as int?,
      notificationChannel: $enumDecodeNullable(
              _$NotificationChannelEnumMap, json['notificationChannel']) ??
          NotificationChannel.backGround,
    );

Map<String, dynamic> _$NotificationEntityToJson(NotificationEntity instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'category': instance.category,
      'collapseKey': instance.collapseKey,
      'contentAvailable': instance.contentAvailable,
      'data': instance.data,
      'from': instance.from,
      'messageId': instance.messageId,
      'messageType': instance.messageType,
      'mutableContent': instance.mutableContent,
      'notification': instance.notification,
      'sentTime': instance.sentTime?.toIso8601String(),
      'threadId': instance.threadId,
      'notificationChannel':
          _$NotificationChannelEnumMap[instance.notificationChannel]!,
      'ttl': instance.ttl,
    };

const _$NotificationChannelEnumMap = {
  NotificationChannel.inApp: 'inApp',
  NotificationChannel.openApp: 'openApp',
  NotificationChannel.backGround: 'backGround',
};

RemoteNotificationEntity _$RemoteNotificationEntityFromJson(
        Map<String, dynamic> json) =>
    RemoteNotificationEntity(
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$RemoteNotificationEntityToJson(
        RemoteNotificationEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };
