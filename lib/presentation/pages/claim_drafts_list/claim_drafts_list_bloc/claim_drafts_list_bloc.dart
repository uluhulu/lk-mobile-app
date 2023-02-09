import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import 'package:mkk/data/api/claim_drafts/list/params/claim_drafts_list_params.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/domain/validators/claims/claims_validator.dart';
import 'package:super_validation/super_validation_enum.dart';

import '../../claim_drafts_observer/claim_drafts_observer_bloc/claim_drafts_observer.dart';

part 'claim_drafts_list_event.dart';
part 'claim_drafts_list_state.dart';

class ClaimDraftsListBloc
    extends Bloc<ClaimDraftsListEvent, ClaimDraftsListState> {
  final Repository repository;
  final ClaimDraftsObserverBloc appObserverBloc;
  ClaimDraftsListBloc({
    required this.repository,
    required this.appObserverBloc,
  }) : super(ClaimDraftsListInitialS()) {
    on<ClaimDraftsListFetchE>(_fetchList);
    on<ClaimDraftsDeleteE>(_delete);

    _initialize();

    _subscription = appObserverBloc.stream.distinct().listen(_listener);
  }

  late StreamSubscription<ClaimDraftsObserverState> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    sort.dispose();
    return super.close();
  }

  FutureOr<void> _fetchList(
      ClaimDraftsListFetchE event, Emitter<ClaimDraftsListState> emit) async {
    try {
      emit(ClaimDraftsListLoadingS());
      final ClaimDraftsListParams params = event.params;
      final result = await repository.claimDraftsList(params);
      result.data.isNotEmpty
          ? emit(ClaimDraftsListLoadedS(
              entity: result,
              currentPage: result.meta.currentPage,
              numberPages: result.meta.lastPage,
              params: event.params,
              sorting: event.params.sorting ?? ClaimDraftsListSorting.desk,
            ))
          : emit(ClaimDraftsListEmptyS(entity: result));
    } catch (e) {
      emit(ClaimDraftsListErrorS(message: e.toString()));
    }
  }

  void _initialize() {
    final params = ClaimDraftsListParams();
    add(ClaimDraftsListFetchE(params: params));
  }

  FutureOr<void> _delete(
      ClaimDraftsDeleteE event, Emitter<ClaimDraftsListState> emit) async {
    try {
      emit(ClaimDraftsListLoadingS());
      await repository.claimDraftsDelete(event.id);
      _initialize();
    } catch (e) {
      emit(ClaimDraftsListErrorS(message: e.toString()));
    }
  }

  final SuperValidationEnum<ClaimDraftsListSorting> sort = SuperValidationEnum(
    validateFunc: ClaimsValidator.validateSort,
  );

  void _listener(ClaimDraftsObserverState event) {
    if (event is ClaimDraftsObserverNeedUpdateS) {
      _initialize();
    }
  }
}
