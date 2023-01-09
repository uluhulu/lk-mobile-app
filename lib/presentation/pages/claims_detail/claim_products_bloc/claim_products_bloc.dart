import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/claims/products/entity/claims_detail_products_entity.dart';

import '../../../../domain/repositories/repository.dart';

part 'claim_products_event.dart';
part 'claim_products_state.dart';

class ClaimProductsBloc extends Bloc<ClaimProductsEvent, ClaimProductsState> {
  final Repository repository;
  final String uuid;
  ClaimProductsBloc({
    required this.repository,
    required this.uuid,
  }) : super(ClaimDetailProductsInitialS()) {
    on<ClaimProductsFetchE>(_fetchProducts);

    add(ClaimProductsFetchE());
  }

  FutureOr<void> _fetchProducts(
      ClaimProductsFetchE event, Emitter<ClaimProductsState> emit) async {
    try {
      emit(ClaimProductsLoadingS());

      final result = await repository.claimsDetailProducts(uuid);
      emit(ClaimProductsLoadedS(products: result));
    } catch (e) {
      emit(ClaimProductsErrorS(message: e.toString()));
    }
  }
}
