import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:mkk/data/providers/dio/transformers/dio_client.dart';
import 'package:mkk/domain/repositories/user_repository.dart';
import 'package:mkk/presentation/pages/banner/banner_bloc/banner_bloc.dart';
import 'package:mkk/services/error/bloc/error_bloc.dart';
import 'package:mkk/services/invoices_filter_saver_service.dart';
import 'package:mkk/services/logger/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../../data/providers/dio/transformers/interceptors/dio_auth_synchronizer.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../domain/use_cases/user/local_auth_use_case.dart';
import '../../../../services/claim_filter_saver_service.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc
    extends HydratedBloc<AuthorizationEvent, AuthorizationState> {
  final Repository repository;
  final ErrorBloc errorBloc;
  final AuthSynchronizer authSynchronizer;
  final GetLocalAuthUseCase getLocalAuthUseCase;
  final SetLocalAuthUseCase setLocalAuthUseCase;
  final UserRepository userRepository;
  final BannerBloc bannerBloc;

  AuthorizationBloc({
    required this.repository,
    required this.errorBloc,
    required this.authSynchronizer,
    required this.bannerBloc,
    required this.getLocalAuthUseCase,
    required this.setLocalAuthUseCase,
    required this.userRepository,
  }) : super(AuthorizationNeedLoginS()) {
    on<AuthorizationLoginE>(_login);
    on<AuthorizationLogOutE>(_logOut, transformer: droppable());
    on<AuthorizationInitializeE>(_initialize);
    on<AuthorizationRightPinE>(_rightPin);
    on<AuthorizationDeleteLocalAuthE>(_deleteLocalAuth);
    on<AuthorizationNewLocalAuthE>(_newLocalAuth);
    _isLoginSubscription = authSynchronizer.isLoginStream.listen((event) {
      add(AuthorizationLogOutE());
    });

    authSynchronizer.initialize();
  }

  int isEnterForLogin = 0;

  StreamSubscription<bool>? _isLoginSubscription;

  final InvoiceFilterSaverService invoiceFilterSaverService =
      InvoiceFilterSaverService.instance;
  final ClaimFilterSaverService claimFilterSaverService =
      ClaimFilterSaverService.instance;

  @override
  Future<void> close() {
    _isLoginSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _login(
      AuthorizationLoginE event, Emitter<AuthorizationState> emit) async {
    try {
      emit(AuthorizationLoadingS());
      _clearCache();
      final localPinCode = getLocalAuthUseCase.call();
      final successState = AuthorizationSuccesS();
      if (localPinCode != null && isEnterForLogin == 0) {
        emit(
          AuthorizationLocalNeedS(
            data: successState,
            pinCode: localPinCode,
          ),
        );
      } else {
        emit(successState);
        isEnterForLogin = 0;
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
      try {
        await repository.logout();
        _clearCache();
      } catch (e) {
        L.e('Auth error repository.logout() $e');
      }
      final localPinCode = getLocalAuthUseCase.call();
      DioClient.currentToken = '';

      if (localPinCode != null) {
        add(AuthorizationInitializeE());
      } else {
        add(AuthorizationDeleteLocalAuthE());
        //bannerBloc.add(BannerInitializeE());
      }
    } catch (e) {
      errorBloc.add(ErrorSimpleE(e));
    }
  }

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
            data: currentState,
            pinCode: localPinCode,
          ));
        }
      }

      if (currentState is AuthorizationLocalNeedS) {
        successState = currentState.data;
      }
      if (currentState is AuthorizationLocalSuccesS) {
        successState = currentState.data;
      }
      if (successState == null) return;

      authSynchronizer.initialize();
      // try {
      //   //TODO: переделать
      //   await repository.getProfile();
      // } catch (e) {
      //   L.e('Auth error repository.getProfile() $e');
      // }
    } catch (e, s) {
      L.e('Auth error $e $s');
      emit(AuthorizationNeedLoginS());
    }
  }

  FutureOr<void> _rightPin(
      AuthorizationRightPinE event, Emitter<AuthorizationState> emit) {
    final currentState = state;
    if (currentState is AuthorizationLocalNeedS) {
      emit(currentState.data);
    }
  }

  FutureOr<void> _deleteLocalAuth(
      AuthorizationDeleteLocalAuthE event, Emitter<AuthorizationState> emit) {
    //setLocalAuthUseCase.call(null);
    emit(AuthorizationNeedLoginS());
  }

  FutureOr<void> _newLocalAuth(
      AuthorizationNewLocalAuthE event, Emitter<AuthorizationState> emit) {
    setLocalAuthUseCase.call(null);
    emit(AuthorizationNeedLoginS());
  }

  void _clearCache() {
    invoiceFilterSaverService.clearAllFilters();
    claimFilterSaverService.clearAllFilters();
  }
}
