import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/claim_drafts/create/params/claim_drafts_create_params.dart';
import 'package:mkk/data/api/claim_drafts/save/params/claim_drafts_save_params.dart';
import 'package:mkk/data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import 'package:super_validation/super_validation_enum.dart';
import 'package:super_validation/super_validation_string.dart';

import '../../../../data/api/claim_drafts/delete_products/params/claim_drafts_delete_products_params.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import '../../../../data/api/invoices/detail/products/params/invoices_detail_products_params.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../domain/validators/claim_drafts/claim_drafts_validator.dart';

part 'create_claim_event.dart';
part 'create_claim_state.dart';

class CreateClaimBloc extends Bloc<CreateClaimEvent, CreateClaimState> {
  final Repository repository;
  final String uuid;
  CreateClaimBloc({
    required this.repository,
    required this.uuid,
  }) : super(CreateClaimInitialS()) {
    on<CreateClaimStartE>(_startCreate);
    on<CreateClaimProductE>(_editProduct);
    on<CreateClaimDeleteProductE>(_deleteProduct);
    on<CreateClaimSaveE>(_saveClaim);

    add(CreateClaimStartE());
  }

  FutureOr<void> _startCreate(
      CreateClaimStartE event, Emitter<CreateClaimState> emit) async {
    try {
      emit(CreateClaimLoadingS());
      final InvoicesDetailProductsParams productsParams =
          InvoicesDetailProductsParams(uuid: uuid);
      final result = await repository.invoicesDetailProducts(productsParams);
      emit(CreateClaimStartS(data: result));
    } catch (e) {
      emit(CreateClaimErrorS());
    }
  }

  FutureOr<void> _editProduct(
      CreateClaimProductE event, Emitter<CreateClaimState> emit) async {
    try {
      emit(CreateClaimLoadingS());
      final params = ClaimDraftsCreateParams(
        invoiceGuid: uuid,
        selectedProducts: <String>[invoiceItem.value?.series?.uuid ?? ''],
      );
      final result = await repository.claimDraftsCreate(params);
      final products = await repository.claimDraftProducts(
        result.draftId,
        ClaimDraftsProductsParams(id: result.draftId),
      );

      final ClaimDraftsProductsData product = products.data.firstWhere(
        (element) => element.seriesName == invoiceItem.value?.series?.name,
      );

      emit(CreateClaimProductS(id: result.draftId, product: product));
    } catch (e) {
      emit(CreateClaimErrorS());
    }
  }

  FutureOr<void> _deleteProduct(
      CreateClaimDeleteProductE event, Emitter<CreateClaimState> emit) async {
    try {
      final claimId =
          state is CreateClaimProductS ? (state as CreateClaimProductS).id : 0;
      emit(CreateClaimLoadingS());
      final params = ClaimDraftsDeleteProductsParams(ids: [event.id]);
      await repository.claimDraftsDeleteProducts(id: claimId, params: params);
      add(CreateClaimStartE());
    } catch (e) {
      emit(CreateClaimErrorS());
    }
  }

  FutureOr<void> _saveClaim(
      CreateClaimSaveE event, Emitter<CreateClaimState> emit) async {
    try {
      final draftId =
          state is CreateClaimProductS ? (state as CreateClaimProductS).id : 0;
      final product = state is CreateClaimProductS
          ? (state as CreateClaimProductS).product
          : null;
      emit(CreateClaimLoadingS());
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
      emit(CreateClaimSaveSuccesS(id: draftId));
    } catch (e) {
      emit(CreateClaimErrorS());
    }
  }

  final SuperValidationEnum<InvoicesDetailProductData> invoiceItem =
      SuperValidationEnum(
    validateFunc: ClaimDraftsValidator.claimType,
  );

  final SuperValidation search = SuperValidation(
    validationFunc: ClaimDraftsValidator.search,
  );

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
}
