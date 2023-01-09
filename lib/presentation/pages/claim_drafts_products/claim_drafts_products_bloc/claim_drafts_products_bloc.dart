import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/claim_drafts/delete_products/params/claim_drafts_delete_products_params.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/domain/validators/claim_drafts/claim_drafts_validator.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import 'package:super_validation/super_validation_enum.dart';
import 'package:super_validation/super_validation_string.dart';

import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import '../../../../data/api/claim_drafts/save/params/claim_drafts_save_params.dart';

part 'claim_drafts_products_event.dart';
part 'claim_drafts_products_state.dart';

class ClaimDraftsProductsBloc
    extends Bloc<ClaimDraftsProductsEvent, ClaimDraftsProductsState> {
  final int id;
  final Repository repository;
  final ClaimDraftAddProductBloc addProductBloc;

  ClaimDraftsProductsBloc({
    required this.repository,
    required this.id,
    required this.addProductBloc,
  }) : super(ClaimDraftsProductsInitialS()) {
    on<ClaimDraftsProductsFetchE>(_fetchProducts);
    on<ClaimDraftsProductsDeleteE>(_deleteProduct);
    on<ClaimDraftsProductsSaveE>(_saveProduct);

    _initialize();

    _subscription = addProductBloc.stream.distinct().listen(_listener);
  }

  late StreamSubscription<ClaimDraftAddProductState> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  FutureOr<void> _fetchProducts(ClaimDraftsProductsFetchE event,
      Emitter<ClaimDraftsProductsState> emit) async {
    try {
      emit(ClaimDraftsProductsLoadingS());
      final products = await repository.claimDraftProducts(id, event.params);
      products.data.isNotEmpty
          ? emit(ClaimDraftsProductsLoadedS(products: products))
          : emit(ClaimDraftsProductsEmptyS());
    } catch (e) {
      emit(ClaimDraftsProductsErrorS());
    }
  }

  void _initialize() {
    final params = ClaimDraftsProductsParams(id: id, isSelected: 1);
    add(ClaimDraftsProductsFetchE(params: params));
  }

  FutureOr<void> _deleteProduct(ClaimDraftsProductsDeleteE event,
      Emitter<ClaimDraftsProductsState> emit) async {
    try {
      emit(ClaimDraftsProductsLoadingS());
      final params = ClaimDraftsDeleteProductsParams(ids: [event.id]);
      await repository.claimDraftsDeleteProducts(id: id, params: params);
      emit(ClaimDraftsProductsDeletedS());
      _initialize();
    } catch (e) {
      emit(ClaimDraftsProductsErrorS());
    }
  }

  FutureOr<void> _saveProduct(ClaimDraftsProductsSaveE event,
      Emitter<ClaimDraftsProductsState> emit) async {
    try {
      final params = ClaimDraftsSaveParams(
        comment: comment.text,
        products: [
          ClaimDraftsProductsModel(
            id: event.productId,
            claimType: claimTypeNumber.value,
            claimQuantity: int.tryParse(quantityClaim.text),
            claimComment: comment.text.isEmpty ? null : comment.text,
          ),
        ],
      );
      await repository.claimDraftsSave(id, params);
      _initialize();
    } catch (e) {
      emit(ClaimDraftsProductsErrorS());
    }
  }

  SuperValidation quantityClaim = SuperValidation(
    validationFunc: ClaimDraftsValidator.quantityClaim,
  );

  SuperValidation comment = SuperValidation(
    validationFunc: ClaimDraftsValidator.quantityClaim,
  );

  final SuperValidationEnum<String> claimType = SuperValidationEnum(
    validateFunc: ClaimDraftsValidator.claimTypeWithDrafts,
  );

  final SuperValidationEnum<int> claimTypeNumber = SuperValidationEnum(
    validateFunc: null,
  );

  void _listener(ClaimDraftAddProductState addProductState) {
    if (addProductState is ClaimDraftAddProductSaveSuccesS) {
      _initialize();
    }
  }
}
