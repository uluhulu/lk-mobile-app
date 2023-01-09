import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:mkk/data/providers/dio/transformers/dio_client.dart';
import 'package:mkk/domain/repositories/user_repository.dart';
import 'package:mkk/presentation/pages/banner/banner_bloc/banner_bloc.dart';
import 'package:mkk/services/error/bloc/error_bloc.dart';
import 'package:mkk/services/logger/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../../data/api/auth/login/entity/auth_login_entity.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../domain/use_cases/user/local_auth_use_case.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc
    extends HydratedBloc<AuthorizationEvent, AuthorizationState> {
  final Repository repository;
  final ErrorBloc errorBloc;
  // final LogInUseCase logInUseCase;
  // final LogOutUseCase logOutUseCase;
  final GetLocalAuthUseCase getLocalAuthUseCase;
  final SetLocalAuthUseCase setLocalAuthUseCase;
  final UserRepository userRepository;
  final BannerBloc bannerBloc;
  // final SignInUseCase signInUseCase;

  AuthorizationBloc({
    required this.repository,
    required this.errorBloc,
    required this.bannerBloc,
    // required this.logInUseCase,
    // required this.logOutUseCase,
    required this.getLocalAuthUseCase,
    required this.setLocalAuthUseCase,
    required this.userRepository,
    // required this.signInUseCase,
  }) : super(AuthorizationNeedLoginS()) {
    on<AuthorizationLoginE>(_login);
    on<AuthorizationLogOutE>(_logOut, transformer: droppable());
    on<AuthorizationInitializeE>(_initialize);
    on<AuthorizationLogOutCallBack>(_logOutCallBack);
    on<AuthorizationRightPinE>(_rightPin);
    on<AuthorizationDeleteLocalAuthE>(_deleteLocalAuth);
  }

  FutureOr<void> _login(
      AuthorizationLoginE event, Emitter<AuthorizationState> emit) async {
    try {
      emit(AuthorizationLoadingS());

      final result = event.loginEntity;
      await _saveUserData(event.login, event.filial);

      final localPinCode = getLocalAuthUseCase.call();
      final successState = AuthorizationSuccesS(
        token: result.data.sessionId,
        isLogin: result.data.isLogin,
      );
      if (localPinCode != null) {
        emit(
          AuthorizationLocalNeedS(
            data: successState,
            pinCode: localPinCode,
          ),
        );
      } else {
        emit(successState);
      }
    } catch (e) {
      errorBloc.add(AuthErrorE(e));
      emit(AuthorizationNeedLoginS());
    }
  }

  @override
  AuthorizationState? fromJson(Map<String, dynamic> json) {
    return AuthorizationState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthorizationState state) {
    return state.toJson();
  }

  FutureOr<void> _logOut(
      AuthorizationLogOutE event, Emitter<AuthorizationState> emit) async {
    try {
      if (DioClient.currentToken.isNotEmpty) {
        DioClient.currentToken = '';
        await repository.logout();
        add(AuthorizationDeleteLocalAuthE());
        bannerBloc.add(BannerInitializeE());

        //emit(AuthorizationNeedLoginS());
      }
    } catch (e) {
      errorBloc.add(ErrorSimpleE(e));
    }
  }

// context.read<BannerBloc>().add(BannerInitializeE());
  FutureOr<void> _initialize(
      AuthorizationInitializeE event, Emitter<AuthorizationState> emit) async {
    try {
      final localPinCode = getLocalAuthUseCase.call();

      final currentState = state;
      AuthorizationSuccesS? successState;
      if (currentState is AuthorizationSuccesS) {
        if (localPinCode == null) {
          successState = currentState;
        } else {
          successState = currentState;
          emit(AuthorizationLocalNeedS(
              data: currentState, pinCode: localPinCode));
        }
      }

      if (currentState is AuthorizationLocalNeedS) {
        successState = currentState.data;
      }
      if (currentState is AuthorizationLocalSuccesS) {
        successState = currentState.data;
      }
      if (successState == null) return;
      DioClient().setAuthInterceptor(
          accessToken: successState.token,
          unauthorizedCallback: () => add(AuthorizationLogOutCallBack()));

      try {
        //TODO: переделать
        await repository.getProfile();
      } catch (e) {
        L.e('Auth error repository.getProfile() $e');
      }

      // final localPinCode = getLocalAuthUseCase.call();
      // if (localPinCode != null) {
      //   emit(
      //     AuthorizationLocalNeedS(
      //       data: successState,
      //       pinCode: localPinCode,
      //     ),
      //   );
      // }
    } catch (e, s) {
      L.e('Auth error $e $s');
      emit(AuthorizationNeedLoginS());
    }
  }

  FutureOr<void> _logOutCallBack(
      AuthorizationLogOutCallBack event, Emitter<AuthorizationState> emit) {
    try {
      //DioClient().unSetAuthInterceptor();
      DioClient.currentToken = '';
      emit(AuthorizationNeedLoginS());
    } catch (e) {
      errorBloc.add(ErrorSimpleE(e));
    }
  }

  FutureOr<void> _rightPin(
      AuthorizationRightPinE event, Emitter<AuthorizationState> emit) {
    final currentState = state;
    if (currentState is AuthorizationLocalNeedS) {
      emit(currentState.data);
    }
  }

  Future<void> _saveUserData(String login, int filial) async {
    await userRepository.saveUserLogin(login);
    await userRepository.saveRegionalCompany(filial);
  }

  FutureOr<void> _deleteLocalAuth(
      AuthorizationDeleteLocalAuthE event, Emitter<AuthorizationState> emit) {
    setLocalAuthUseCase.call(null);
    emit(AuthorizationNeedLoginS());
  }
}
