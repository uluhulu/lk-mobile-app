import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../data/api/claim_drafts/delete_products/params/claim_drafts_delete_products_params.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import '../../../../data/api/claim_drafts/save/params/claim_drafts_save_params.dart';
import '../../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import '../../../../domain/validators/claim_drafts/claim_drafts_validator.dart';

part 'claim_draft_add_product_event.dart';
part 'claim_draft_add_product_state.dart';

class ClaimDraftAddProductBloc
    extends Bloc<ClaimDraftAddProductEvent, ClaimDraftAddProductState> {
  final Repository repository;
  final int draftId;

  ClaimDraftAddProductBloc({
    required this.repository,
    required this.draftId,
  }) : super(ClaimDraftAddProductInitialS()) {
    on<ClaimDraftAddProductStartE>(_addProductsStart);
    on<ClaimDraftAddProductE>(_editProduct);
    on<ClaimDraftAddProductDeleteE>(_deleteProduct);
    on<ClaimDraftAddProductSaveE>(_saveProduct);

    //add(ClaimDraftAddProductStartE());
  }

  FutureOr<void> _addProductsStart(ClaimDraftAddProductStartE event,
      Emitter<ClaimDraftAddProductState> emit) async {
    try {
      emit(ClaimDraftAddProductLoadingS());
      final result = await repository.claimDraftProducts(
        draftId,
        ClaimDraftsProductsParams(id: draftId, isSelected: 0),
      );
      emit(ClaimDraftAddProductStartS(data: result));
    } catch (e) {
      emit(ClaimDraftAddProductErrorS());
    }
  }

  FutureOr<void> _editProduct(ClaimDraftAddProductE event,
      Emitter<ClaimDraftAddProductState> emit) async {
    try {
      emit(ClaimDraftAddProductLoadingS());

      final products = await repository.claimDraftProducts(
        draftId,
        ClaimDraftsProductsParams(id: draftId),
      );

      final ClaimDraftsProductsData product = products.data.firstWhere(
        (element) => element.seriesName == claimItem.value?.seriesName,
      );

      emit(ClaimDraftAddProductS(id: draftId, product: product));
    } catch (e) {
      emit(ClaimDraftAddProductErrorS());
    }
  }

  FutureOr<void> _deleteProduct(ClaimDraftAddProductDeleteE event,
      Emitter<ClaimDraftAddProductState> emit) async {
    try {
      final claimId = state is ClaimDraftAddProductS
          ? (state as ClaimDraftAddProductS).id
          : 0;
      emit(ClaimDraftAddProductLoadingS());
      final params = ClaimDraftsDeleteProductsParams(ids: [event.id]);
      await repository.claimDraftsDeleteProducts(id: claimId, params: params);
      add(ClaimDraftAddProductStartE());
    } catch (e) {
      emit(ClaimDraftAddProductErrorS());
    }
  }

  FutureOr<void> _saveProduct(ClaimDraftAddProductSaveE event,
      Emitter<ClaimDraftAddProductState> emit) async {
    try {
      final draftId = state is ClaimDraftAddProductS
          ? (state as ClaimDraftAddProductS).id
          : 0;
      final product = state is ClaimDraftAddProductS
          ? (state as ClaimDraftAddProductS).product
          : null;
      emit(ClaimDraftAddProductLoadingS());
      final params = ClaimDraftsSaveParams(
        comment: comment.text,
        products: [
          ClaimDraftsProductsModel(
            id: product?.id ?? 0,
            claimType: claimTypeNumber.value,
            claimQuantity: int.tryParse(quantityClaim.text),
            claimComment: comment.text.isEmpty ? null : comment.text,
          ),
        ],
      );
      await repository.claimDraftsSave(draftId, params);
      emit(ClaimDraftAddProductSaveSuccesS(id: draftId));
    } catch (e) {
      emit(ClaimDraftAddProductErrorS());
    }
  }

  final SuperValidationEnum<ClaimDraftsProductsData> claimItem =
      SuperValidationEnum(
    validateFunc: ClaimDraftsValidator.addProductClaimType,
  );

  final SuperValidation search = SuperValidation(
    validationFunc: null,
  );

  SuperValidation quantityClaim = SuperValidation(
    validationFunc: null,
  );

  SuperValidation comment = SuperValidation(
    validationFunc: null,
  );

  final SuperValidationEnum<String> claimType = SuperValidationEnum(
    validateFunc: null,
  );

  final SuperValidationEnum<int> claimTypeNumber = SuperValidationEnum(
    validateFunc: null,
  );
}
