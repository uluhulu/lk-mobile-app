import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../services/logger/logger_service.dart';
import '../../../services/notification/firebase_notification.dart';
import '../../../services/notification/notification_entity.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FirebaseNotification firebaseNotification;
  late StreamSubscription<NotificationEntity> _subscription;
  NotificationBloc({required this.firebaseNotification})
      : super(NotificationInitial()) {
    on<NotificationReceivedE>(_notificationReceived);
    on<NotificationMessageE>(_notificationMessage);
    on<NotificationErrorE>(_notificationError);
    _subscription = firebaseNotification.stream.listen(_onMessage);
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }

  void _onMessage(NotificationEntity event) {
    L.i('Got FirebaseMessage: $event');
    if (event.notification != null) {
      add(NotificationReceivedE(event));
    }
  }

  FutureOr<void> _notificationReceived(
      NotificationReceivedE event, Emitter<NotificationState> emit) {
    emit(NotificationReceivedS(event.event));
  }

  FutureOr<void> _notificationMessage(
      NotificationMessageE event, Emitter<NotificationState> emit) {
    emit(NotificationMessageS(event.message));
  }

  FutureOr<void> _notificationError(
      NotificationErrorE event, Emitter<NotificationState> emit) {
    emit(NotificationErrorS(event.message));
  }
}
