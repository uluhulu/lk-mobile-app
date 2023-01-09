import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/domain/repositories/user_repository.dart';
import 'package:mkk/domain/use_cases/user/local_auth_use_case.dart';
import 'package:mkk/presentation/pages/authorization/authorization_bloc/authorization_bloc.dart';
import 'package:mkk/presentation/pages/authorization/login_bloc/login_bloc.dart';

import '../../domain/repositories/repository.dart';
import '../../locator/locator.dart';
import '../../services/error/bloc/error_bloc.dart';
import '../pages/banner/banner_bloc/banner_bloc.dart';

/// Глобальный провайдер
class AppProvider extends StatelessWidget {
  const AppProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AuthBlocProvider(child: child);
  }
}

// //TODO: место для multiblocprovider
// class AppInitializeBuilder extends StatelessWidget {
//   const AppInitializeBuilder({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return AuthBlocProvider(child: child);
//   }
// }

class AuthBlocProvider extends StatelessWidget {
  final Widget child;
  const AuthBlocProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthorizationBloc>(
      lazy: false,
      create: _createAuthorizationBloc,
      child: OtherProvidersWithAuthBloc(child: child),
    );
  }

  AuthorizationBloc _createAuthorizationBloc(BuildContext context) {
    return AuthorizationBloc(
      bannerBloc: context.read<BannerBloc>(),
      errorBloc: context.read<ErrorBloc>(),
      repository: sl.get<Repository>(),
      getLocalAuthUseCase: GetLocalAuthUseCase(
        sl.get<UserRepository>(),
      ),
      setLocalAuthUseCase: SetLocalAuthUseCase(
        sl.get<UserRepository>(),
      ),
      userRepository: sl.get<UserRepository>(),
    )..add(AuthorizationInitializeE());
  }
}

class OtherProvidersWithAuthBloc extends StatelessWidget {
  const OtherProvidersWithAuthBloc({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: _createLoginBloc,
          lazy: false,
        ),
      ],
      child: child,
    );
  }

  LoginBloc _createLoginBloc(BuildContext context) {
    return LoginBloc(
      authorizationBloc: context.read<AuthorizationBloc>(),
      repository: sl.get<Repository>(),
      errorBloc: context.read<ErrorBloc>(),
    );
  }
}
