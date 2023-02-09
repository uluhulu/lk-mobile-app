import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/domain/repositories/user_repository.dart';
import 'package:mkk/domain/use_cases/user/local_auth_use_case.dart';
import 'package:mkk/presentation/blocs/settings_cubit/settings_cubit.dart';
import 'package:mkk/presentation/pages/app_loader/app_loader_bloc/app_loader_bloc.dart';
import 'package:mkk/presentation/pages/authorization/authorization_bloc/authorization_bloc.dart';
import 'package:mkk/presentation/pages/authorization/login_bloc/login_bloc.dart';

import '../../data/providers/dio/transformers/interceptors/dio_auth_synchronizer.dart';
import '../../domain/repositories/repository.dart';
import '../../locator/locator.dart';
import '../../services/error/bloc/error_bloc.dart';
import '../pages/banner/banner_bloc/banner_bloc.dart';
import '../pages/claim_drafts_observer/claim_drafts_observer_bloc/claim_drafts_observer.dart';
import '../pages/upgrade_app/upgrade_app_bloc/upgrader_bloc.dart';

/// Глобальный провайдер
class AppProvider extends StatelessWidget {
  const AppProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppInitializeBuilder(
      child: child,
    );
  }
}

// //TODO: место для multiblocprovider
class AppInitializeBuilder extends StatelessWidget {
  const AppInitializeBuilder({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpgraderBloc>(
        create: _createUpgraderBloc,
        lazy: false,
        child: AuthBlocProvider(child: child));
  }

  UpgraderBloc _createUpgraderBloc(BuildContext context) {
    return UpgraderBloc();
  }
}

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
      authSynchronizer: sl.get<AuthSynchronizer>(),
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
        BlocProvider<ClaimDraftsObserverBloc>(
          create: (context) => ClaimDraftsObserverBloc(),
          lazy: false,
        ),
        BlocProvider<AppLoaderBloc>(
          create: (context) => AppLoaderBloc(),
          lazy: false,
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
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
      authSynchronizer: sl.get<AuthSynchronizer>(),
      errorBloc: context.read<ErrorBloc>(),
    );
  }
}
