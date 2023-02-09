import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/claims/products/entity/claims_detail_products_entity.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../../data/api/claims/attachments/entity/claim_new_attachment_entity.dart';
import '../../../../data/api/claims/attachments/params/claim_new_attachment_params.dart';
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
    // on<ClaimProductsNewImagesE>(_uploadImages);

    add(ClaimProductsFetchE());
  }

  FutureOr<void> _fetchProducts(
      ClaimProductsFetchE event, Emitter<ClaimProductsState> emit) async {
    try {
      emit(ClaimProductsLoadingS());
      final ClaimsDetailProductsEntity result =
          await repository.claimsDetailProducts(uuid);
      emit(ClaimProductsLoadedS(products: result));
    } catch (e) {
      emit(ClaimProductsErrorS(message: e.toString()));
    }
  }
}
