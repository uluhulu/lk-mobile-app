part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationReceivedS extends NotificationState {
  final NotificationEntity notification;
  const NotificationReceivedS(this.notification);

  @override
  List<Object> get props => [notification];
}

class NotificationErrorS extends NotificationState {
  final String message;
  const NotificationErrorS(this.message);

  @override
  List<Object> get props => [message];
}

class NotificationMessageS extends NotificationState {
  final String message;
  const NotificationMessageS(this.message);

  @override
  List<Object> get props => [message];
}