// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:mkk/presentation/pages/authorization/authorization_bloc/authorization_bloc.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends HydratedBloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerShowS()) {
    on<BannerInitializeE>(_initialize);
    on<BannerSetPinShowedE>(_setPinShowed);
    on<BannerRemoveAllE>(_removeAll);
  }

  late StreamSubscription<AuthorizationState> _authorizationSubscription;

  @override
  Future<void> close() async {
    await _authorizationSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _initialize(
      BannerInitializeE event, Emitter<BannerState> emit) {
    emit(BannerShowS());
  }

  @override
  BannerState? fromJson(Map<String, dynamic> json) {
    return BannerState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(BannerState state) {
    return state.toJson();
  }

  FutureOr<void> _setPinShowed(
      BannerSetPinShowedE event, Emitter<BannerState> emit) {
    emit(const BannerOkS(showSetPin: false));
  }

  //FutureOr<void> _postInit(BannerPostInitE event, Emitter<BannerState> emit) {}

  FutureOr<void> _removeAll(BannerRemoveAllE event, Emitter<BannerState> emit) {
    emit(const BannerOkS(showSetPin: true));
  }
}
