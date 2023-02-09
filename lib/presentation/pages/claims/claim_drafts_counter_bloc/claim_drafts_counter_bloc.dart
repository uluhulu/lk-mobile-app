import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/services/logger/logger_service.dart';

import '../../../../data/api/claim_drafts/list/params/claim_drafts_list_params.dart';
import '../../claim_drafts_observer/claim_drafts_observer_bloc/claim_drafts_observer.dart';

part 'claim_drafts_counter_event.dart';
part 'claim_drafts_counter_state.dart';

class ClaimDraftsCounterBloc
    extends Bloc<ClaimDraftsCounterEvent, ClaimDraftsCounterState> {
  final Repository repository;
  final ClaimDraftsObserverBloc appBlocObserver;
  ClaimDraftsCounterBloc({
    required this.repository,
    required this.appBlocObserver,
  }) : super(ClaimDraftsCounterInitialS()) {
    on<ClaimDraftsCounterFetchE>(_fetchCount);

    add(ClaimDraftsCounterFetchE());

    _appBlocObserverSubscription =
        appBlocObserver.stream.distinct().listen(_listener);
  }

  late StreamSubscription<ClaimDraftsObserverState>
      _appBlocObserverSubscription;

  @override
  Future<void> close() {
    _appBlocObserverSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _fetchCount(ClaimDraftsCounterFetchE event,
      Emitter<ClaimDraftsCounterState> emit) async {
    try {
      final claimDrafts =
          await repository.claimDraftsList(ClaimDraftsListParams());
      emit(ClaimDraftsCounterLoadedS(claimDrafts.meta.total));
    } catch (e) {
      L.e('ClaimDraftsCounterBloc _fetchCount error: $e');
    }
  }

  void _listener(ClaimDraftsObserverState event) {
    if (event is ClaimDraftsObserverNeedUpdateS) {
      add(ClaimDraftsCounterFetchE());
    }
  }
}
