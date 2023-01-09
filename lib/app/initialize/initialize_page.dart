import '../../services/appmetrica/appmetrica_service.dart';
import '../../services/error/error_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../locator/locator.dart';
import '../../services/firebase/firebase_service.dart';
import '../../services/notification/firebase_notification.dart';
import '../../services/notification/local_notification.dart';

import 'app_splash_page.dart';
import 'initialize_bloc/initialize_bloc.dart';
import 'initialize_error_page.dart';

class InitializePage extends StatelessWidget {
  final Widget child;
  const InitializePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitializeBloc(
        localNotification: sl.get<LocalNotification>(),
        firebaseNotification: sl.get<FirebaseNotification>(),
        firebaseService: sl.get<FirebaseService>(),
        appMetricaService: sl.get<AppMetricaService>(),
      )..add(InitializeE()),
      child: InitializeContent(
        child: child,
      ),
    );
  }
}

class InitializeContent extends StatelessWidget {
  final Widget child;
  const InitializeContent({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitializeBloc, InitializeState>(
      builder: (context, state) {
        if (state is InitializeAppSplashS) {
          return const StaticSplashPage();
          //return const AppSplashPage();
        } else if (state is InitializeDoneS) {
          return ErrorWrapper(child: child);
        } else if (state is InitializeErrorS) {
          return InitializeErrorPage(error: state.error);
        } else {
          return const InitializeErrorPage();
        }
      },
    );
  }
}
