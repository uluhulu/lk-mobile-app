import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/domain/repositories/repository.dart';

import '../../../../data/api/claims/detail/entity/claim_detail_entity.dart';

part 'claim_detail_event.dart';
part 'claim_detail_state.dart';

class ClaimDetailBloc extends Bloc<ClaimDetailEvent, ClaimDetailState> {
  final Repository repository;
  final String uuid;
  ClaimDetailBloc({
    required this.repository,
    required this.uuid,
  }) : super(ClaimDetailInitialS()) {
    on<ClaimDetailFetchE>(_fetchDetail);
  }

  FutureOr<void> _fetchDetail(
      ClaimDetailFetchE event, Emitter<ClaimDetailState> emit) async {
    try {
      emit(ClaimDetailLoadingS());
      final claimDetail = await repository.claimsDetail(uuid);
      emit(ClaimDetailLoadedS(claimDetail: claimDetail));
    } catch (e) {
      emit(ClaimDetailErrorS(message: e.toString()));
    }
  }
}
