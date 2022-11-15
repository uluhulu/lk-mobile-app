import '../../config/theme/elements/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_bloc/notification_bloc.dart';

class NotificationWrapper extends StatelessWidget {
  final Widget child;
  const NotificationWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationWrapperContent(child: child);
  }
}

class NotificationWrapperContent extends StatelessWidget {
  final Widget child;
  const NotificationWrapperContent({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        // if (state is NotificationReceivedS) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       backgroundColor: Colors.black,
        //       content: ListTile(
        //         title: Text(state.notification.notification?.title ?? ''),
        //         subtitle: Text(state.notification.notification?.body ?? ''),
        //       ),
        //     ),
        //   );
        // }
        if (state is NotificationMessageS) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: MyTheme.of(context).greenColor,
              content: ListTile(
                title: Text(state.message),
              ),
            ),
          );
        }
        if (state is NotificationErrorS) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: MyTheme.of(context).redColor,
              content: ListTile(
                title: Text(state.message),
              ),
            ),
          );
        }
      },
      child: child,
    );
  }
}
