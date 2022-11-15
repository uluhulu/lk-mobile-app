// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/repositories/user_repository.dart';
import '../../../../domain/use_cases/user/local_auth_use_case.dart';

part 'local_auth_event.dart';
part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  final UserRepository userRepository;

  LocalAuthBloc({
    required this.userRepository,
  }) : super(LocalAuthInitialS()) {
    on<LocalAuthInitializeE>(_localAuthInitializeE);
    on<LocalAuthEnteredE>(_enteredPinCode);
    on<LocalAuthReEnterE>(_reEnterPinCode);
    on<LocalAuthUnSetPinCodeE>(_unSetPinCode);
    //on<LocalAuthSuccessE>(_success);
  }

  late final getLocalAuthUseCase = GetLocalAuthUseCase(userRepository);
  late final setLocalAuthUseCase = SetLocalAuthUseCase(userRepository);
  String pin = '';

  FutureOr<void> _enteredPinCode(
      LocalAuthEnteredE event, Emitter<LocalAuthState> emit) {
    pin = event.pin;
    emit(LocalAuthEnteredS(pin: event.pin));
  }

  FutureOr<void> _reEnterPinCode(
      LocalAuthReEnterE event, Emitter<LocalAuthState> emit) async {
    if (pin == event.pin) {
      emit(LocalAuthSuccessS(pin: pin));
      await userRepository.setLocalAuthPin(pin);
    } else {
      emit(LocalAuthLocalPinErrorS());
    }
  }

  FutureOr<void> _localAuthInitializeE(
      LocalAuthInitializeE event, Emitter<LocalAuthState> emit) async {
    // final localPinCode = getLocalAuthUseCase.call();
    // if (localPinCode != null) {
    //   emit(LocalAuthPinS(pin: localPinCode));
    // } else {}
    emit(LocalAuthInitialS());
  }

  FutureOr<void> _unSetPinCode(
      LocalAuthUnSetPinCodeE event, Emitter<LocalAuthState> emit) {
    setLocalAuthUseCase.call(null);
    add(LocalAuthInitializeE());
  }

  // FutureOr<void> _success(
  //     LocalAuthSuccessE event, Emitter<LocalAuthState> emit) async {
  //   if (pin == event.pin) {
  //     emit(LocalAuthSuccessS(pin: pin));
  //     await userRepository.setLocalAuthPin(pin);
  //   } else {
  //     emit(LocalAuthLocalPinErrorS());
  //   }
  // }
}
