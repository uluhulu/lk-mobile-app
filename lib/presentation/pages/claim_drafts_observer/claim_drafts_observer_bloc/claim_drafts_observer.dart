import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'claim_drafts_observer_event.dart';
part 'claim_drafts_observer_state.dart';

class ClaimDraftsObserverBloc
    extends Bloc<ClaimDraftsObserverEvent, ClaimDraftsObserverState> {
  ClaimDraftsObserverBloc() : super(ClaimDraftsObserverInitialS()) {
    on<AppObserverNeedUpdateE>(_needUpdate);
  }

  FutureOr<void> _needUpdate(AppObserverNeedUpdateE event,
      Emitter<ClaimDraftsObserverState> emit) async {
    emit(ClaimDraftsObserverNeedUpdateS());
    await Future.delayed(const Duration(seconds: 2), () {
      emit(ClaimDraftsObserverInitialS());
    });
  }
}
