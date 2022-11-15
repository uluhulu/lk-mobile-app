part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationReceivedE extends NotificationEvent {
  final NotificationEntity event;
  const NotificationReceivedE(this.event);

  @override
  List<Object> get props => [event];
}

class NotificationMessageE extends NotificationEvent {
  final String message;
  const NotificationMessageE(this.message);

  @override
  List<Object> get props => [message];
}

class NotificationErrorE extends NotificationEvent {
  final String message;
  const NotificationErrorE(this.message);

  @override
  List<Object> get props => [message];
}