import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mkk/core/utils/formatter.dart';
import 'package:mkk/data/api/claim_drafts/create/params/claim_drafts_create_params.dart';
import 'package:mkk/data/api/claim_drafts/save/params/claim_drafts_save_params.dart';
import 'package:mkk/data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import 'package:mkk/presentation/pages/app_loader/app_loader_bloc/app_loader_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';
import 'package:super_validation/super_validation_enum.dart';
import 'package:super_validation/super_validation_string.dart';

import '../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';
import '../../../../data/api/claim_drafts/delete_products/params/claim_drafts_delete_products_params.dart';
import '../../../../data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import '../../../../data/api/invoices/detail/products/params/invoices_detail_products_params.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../domain/validators/claim_drafts/claim_drafts_validator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';

part 'create_claim_event.dart';

part 'create_claim_state.dart';

class CreateClaimBloc extends Bloc<CreateClaimEvent, CreateClaimState> {
  final Repository repository;
  final String uuid;
  final AppLoaderBloc appLoader;

  CreateClaimBloc({
    required this.repository,
    required this.uuid,
    required this.appLoader,
  }) : super(CreateClaimInitialS()) {
    on<CreateClaimStartE>(_startCreate);
    on<CreateClaimProductE>(_editProduct);
    on<CreateClaimDeleteProductE>(_deleteProduct);
    on<CreateClaimSaveE>(_saveClaim);
    on<CreateClaimInitializeE>(_initialize);
    on<CreateClaimPaginationE>(_pagination);
    on<CreateClaimSearchE>(_searchProduct,
        transformer: debounceDroppable(const Duration(milliseconds: 1500)));

    add(CreateClaimStartE());

    _searchSubscription = search.stream.distinct().listen(_searchListener);
    _stateSubscription = stream.listen(_stateListener);

    claimType.streamValue.listen(_claimTypeListener);
    quantityClaim.stream.listen(_quantityClaimListener);
  }

  StreamSubscription<String?>? _searchSubscription;
  StreamSubscription<CreateClaimState>? _stateSubscription;
  bool showLoading = false;

  int maxQuantityClaim = 0;
  int perPage = 25;

  FutureOr<void> _searchProduct(
      CreateClaimSearchE event, Emitter<CreateClaimState> emit) async {
    try {
      if (search.text.isEmpty) {
        //showLoading ? appLoader.add(AppLoaderStartE()) : null;
        invoiceItem.value = null;
        final InvoicesDetailProductsParams productsParams =
            InvoicesDetailProductsParams(uuid: uuid, searchQuery: search.text);
        final result = await repository.invoicesDetailProducts(productsParams);
        emit(CreateClaimStartS(data: result));
        //showLoading ? appLoader.add(AppLoaderStopE()) : null;
        //showLoading = false;
      }
      if (search.text.length < 3) return;
      appLoader.add(AppLoaderStartE());
      invoiceItem.value = null;
      final InvoicesDetailProductsParams productsParams =
          InvoicesDetailProductsParams(
              uuid: uuid, searchQuery: search.text.trimLeft());
      final result = await repository.invoicesDetailProducts(productsParams);
      emit(CreateClaimStartS(data: result));
      appLoader.add(AppLoaderStopE());
    } catch (e) {
      emit(CreateClaimErrorS());
      appLoader.add(AppLoaderStopE());
    }
  }

  FutureOr<void> _initialize(
      CreateClaimInitializeE event, Emitter<CreateClaimState> emit) async {
    _resetValidation();
    try {
      final InvoicesDetailProductsParams productsParams =
          InvoicesDetailProductsParams(uuid: uuid);
      final result = await repository.invoicesDetailProducts(productsParams);
      emit(CreateClaimStartS(data: result));
    } catch (e) {
      emit(CreateClaimErrorS());
    }
  }

  FutureOr<void> _pagination(
      CreateClaimPaginationE event, Emitter<CreateClaimState> emit) async {
    try {
      perPage += 25;
      final currentData =
          state is CreateClaimStartS ? (state as CreateClaimStartS).data : null;
      if (currentData == null) return;
      if (currentData.meta.total <= perPage) return;
      final InvoicesDetailProductsParams productsParams =
          InvoicesDetailProductsParams(
        uuid: uuid,
        searchQuery: search.text,
        perPage: perPage,
      );
      final result = await repository.invoicesDetailProducts(productsParams);
      emit(CreateClaimStartS(data: result));
    } catch (e) {
      emit(CreateClaimErrorS());
    }
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
    if (invoiceItem.value?.series == null) return;
    try {
      emit(CreateClaimLoadingS());

      final params = ClaimDraftsCreateParams(
        invoiceGuid: uuid,
        selectedProducts: <String>[invoiceItem.value?.series?.uuid ?? ''],
      );
      final result = await repository.claimDraftsCreate(params);

      ClaimDraftsProductsData? currentProduct;
      bool hasFind = false;
      int editPerPage = 1;
      while (!hasFind) {
        Future.delayed(const Duration(seconds: 5)).then((value) {
          if (hasFind) return;
          throw TimeoutException('Превышено время ожидания');
        });
        final productResult = await repository.claimDraftProducts(
            result.draftId,
            ClaimDraftsProductsParams(
              id: result.draftId,
              page: editPerPage,
              perPage: 25,
            ));

        for (var item in productResult.data) {
          if (item.seriesName == invoiceItem.value?.series?.name) {
            currentProduct = item;
            hasFind = true;
            break;
          }
        }
        editPerPage += 1;
      }

      if (currentProduct != null) {
        maxQuantityClaim = currentProduct.invoiceQuantity;
        if (currentProduct.claimQuantity == 0) {
          quantityClaim.text = '';
        } else {
          quantityClaim.text = currentProduct.claimQuantity.toString();
        }
        comment.text = currentProduct.claimComment ?? '';
        final params = ClaimDraftsSaveParams(
          //comment: '',
          products: [
            ClaimDraftsProductsModel(
              id: currentProduct.id,
              claimType: currentProduct.claimType,
              claimQuantity: currentProduct.claimQuantity,
              claimComment: currentProduct.claimComment,
            ),
          ],
        );

        claimTypeNumber.value = currentProduct.claimType;

        claimType.value = currentProduct.possibleClaimTypes?.entries
            .firstWhereOrNull((element) =>
                int.tryParse(element.key) == currentProduct?.claimType)
            ?.value;

        await repository.claimDraftsSave(result.draftId, params);
        var imagesList = await loadImages(currentProduct.attachments ?? []);

        emit(
          CreateClaimProductS(
            id: result.draftId,
            product: currentProduct,
            attachments: imagesList,
            isImageGalleryLoading: false,
          ),
        );
        return;
      } else {
        emit(CreateClaimErrorS());
      }
    } catch (e) {
      emit(CreateClaimErrorS());
    }
  }

  Future<List<ClaimDraftFile>> loadImages(
      List<ClaimDraftsListAttachments> attachments) async {
    List<ClaimDraftFile> list = [];
    for (var attachment in attachments) {
      var path = attachment.url!.split("/").last;

      final response = await repository.getClaimDraftImage(attachment.id!);

      Uint8List bytes = base64.decode(response.base64);
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File(join(documentDirectory.path, attachment.name));
      file.writeAsBytesSync(bytes);
      var item = ClaimDraftFile(
        attachment: file,
        id: attachment.id!,
      );
      list.add(item);
    }
    return list;
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
        //comment: '',
        products: [
          ClaimDraftsProductsModel(
            id: product?.id ?? 0,
            claimType: claimTypeNumber.value,
            claimQuantity: int.tryParse(quantityClaim.text) ?? 0,
            claimComment: comment.text.isEmpty
                ? null
                : Formatter.textFormatter(comment.text),
          ),
        ],
      );

      await repository.claimDraftsSave(draftId, params);

      emit(CreateClaimSaveSuccesS(id: draftId));
    } catch (e) {
      emit(CreateClaimErrorS());
    }
  }

  void _searchListener(String event) {
    add(CreateClaimSearchE());
  }

  void _claimTypeListener(String? value) {
    if (value != 'Излишки') {
      final currentProduct = state is CreateClaimProductS
          ? (state as CreateClaimProductS).product
          : null;
      maxQuantityClaim = currentProduct?.invoiceQuantity ?? 5;
      quantityClaim.validation = ClaimDraftsValidator.quantityClaim(
          quantityClaim.text, maxQuantityClaim);
    } else {
      maxQuantityClaim = 1000000;
      quantityClaim.validation = null;
    }
  }

  void _stateListener(CreateClaimState currentState) {
    if (currentState is CreateClaimProductS) {
      maxQuantityClaim = currentState.product.invoiceQuantity;
    }
  }

  void _quantityClaimListener(String value) {
    if (claimType.value != 'Излишки') {
      final currentProduct = state is CreateClaimProductS
          ? (state as CreateClaimProductS).product
          : null;
      maxQuantityClaim = currentProduct?.invoiceQuantity ?? 0;
    }
  }

  void _resetValidation() {
    claimType.value = null;
    claimTypeNumber.value = null;
    quantityClaim.text = '';
    invoiceItem.value = null;
    comment.text = '';
    search.text = '';
  }

  final SuperValidationEnum<InvoicesDetailProductData> invoiceItem =
      SuperValidationEnum(
    validateFunc: ClaimDraftsValidator.claimType,
  );

  final SuperValidation search = SuperValidation(
    validationFunc: ClaimDraftsValidator.search,
  );

  late SuperValidation quantityClaim = SuperValidation(
    validationFunc: (value) {
      return ClaimDraftsValidator.quantityClaim(value, maxQuantityClaim);
    },
  );

  SuperValidation comment = SuperValidation();

  final SuperValidationEnum<String> claimType = SuperValidationEnum(
    validateFunc: ClaimDraftsValidator.claimTypeWithDrafts,
  );

  final SuperValidationEnum<int> claimTypeNumber = SuperValidationEnum(
    validateFunc: null,
  );

  @override
  Future<void> close() async {
    await _searchSubscription?.cancel();
    await _stateSubscription?.cancel();
    await claimTypeNumber.dispose();
    await claimType.dispose();
    await comment.dispose();
    await quantityClaim.dispose();
    await search.dispose();

    return super.close();
  }
}
