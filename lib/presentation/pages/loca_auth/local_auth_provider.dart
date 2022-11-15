import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/user_repository.dart';
import '../../../locator/locator.dart';
import 'local_auth_bloc/local_auth_bloc.dart';

class LocalAuthProvider extends StatelessWidget {
  final Widget child;
  const LocalAuthProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: _createLocalAuthBloc,
      child: child,
    );
  }

  LocalAuthBloc _createLocalAuthBloc(BuildContext context) {
    return LocalAuthBloc(
      userRepository: sl.get<UserRepository>(),
    );
  }
}
