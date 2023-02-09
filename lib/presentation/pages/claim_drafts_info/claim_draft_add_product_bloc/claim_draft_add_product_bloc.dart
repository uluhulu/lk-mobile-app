import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/core/utils/formatter.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/presentation/pages/app_loader/app_loader_bloc/app_loader_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_drafts_bloc/claim_drafts_info_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';
import '../../../../data/api/claim_drafts/delete_products/params/claim_drafts_delete_products_params.dart';
import '../../../../data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import '../../../../data/api/claim_drafts/save/params/claim_drafts_save_params.dart';
import 'package:path/path.dart';
import '../../../../domain/validators/claim_drafts/claim_drafts_validator.dart';

part 'claim_draft_add_product_event.dart';

part 'claim_draft_add_product_state.dart';

class ClaimDraftAddProductBloc
    extends Bloc<ClaimDraftAddProductEvent, ClaimDraftAddProductState> {
  final Repository repository;
  final ClaimDraftsInfoBloc claimDraftsInfoBloc;
  final AppLoaderBloc appLoader;
  final int draftId;

  ClaimDraftAddProductBloc({
    required this.repository,
    required this.claimDraftsInfoBloc,
    required this.appLoader,
    required this.draftId,
  }) : super(ClaimDraftAddProductInitialS()) {
    on<ClaimDraftAddProductStartE>(_addProductsStart);
    on<ClaimDraftAddProductE>(_editProduct);
    on<ClaimDraftAddProductDeleteE>(_deleteProduct);
    on<ClaimDraftAddProductSaveE>(_saveProduct);
    on<ClaimDraftAddProductPaginationE>(_pagination);
    on<ClaimDraftInitializeE>(_initialize);
    on<ClaimDraftSearchE>(_searchProduct,
        transformer: debounceDroppable(const Duration(milliseconds: 1500)));

    _searchSubscription = search.stream.distinct().listen(_searchListener);
    claimType.streamValue.listen(_claimTypeListener);
    quantityClaim.stream.listen(_quantityClaimListener);
  }

  bool isFirstLoading = true;
  int maxQuantityClaim = 0;
  int perPage = 25;
  StreamSubscription<String?>? _searchSubscription;

  FutureOr<void> _searchProduct(
      ClaimDraftSearchE event, Emitter<ClaimDraftAddProductState> emit) async {
    try {
      if (isFirstLoading) return;
      if (search.text.isEmpty) {
        //appLoader.add(AppLoaderStartE());
        final result = await repository.claimDraftProducts(
          draftId,
          ClaimDraftsProductsParams(
            id: draftId,
            isSelected: 0,
            searchQuery: search.text,
          ),
        );
        emit(ClaimDraftAddProductStartS(data: result));
        //appLoader.add(AppLoaderStopE());
      }
      if (search.text.length < 3) return;
      appLoader.add(AppLoaderStartE());
      claimItem.value = null;
      final result = await repository.claimDraftProducts(
        draftId,
        ClaimDraftsProductsParams(
          id: draftId,
          isSelected: 0,
          searchQuery: search.text.trimLeft(),
        ),
      );
      emit(ClaimDraftAddProductStartS(data: result));
      appLoader.add(AppLoaderStopE());
    } catch (e) {
      emit(ClaimDraftAddProductErrorS());
      appLoader.add(AppLoaderStopE());
    }
  }

  FutureOr<void> _initialize(ClaimDraftInitializeE event,
      Emitter<ClaimDraftAddProductState> emit) async {
    _resetValidation();
    try {
      final result = await repository.claimDraftProducts(
        draftId,
        ClaimDraftsProductsParams(id: draftId, isSelected: 0),
      );
      emit(ClaimDraftAddProductStartS(data: result));
    } catch (e) {
      emit(ClaimDraftAddProductErrorS());
    }
    //add(ClaimDraftAddProductStartE());
  }

  FutureOr<void> _pagination(ClaimDraftAddProductPaginationE event,
      Emitter<ClaimDraftAddProductState> emit) async {
    try {
      perPage += 25;
      final currentData = state is ClaimDraftAddProductStartS
          ? (state as ClaimDraftAddProductStartS).data
          : null;
      if (currentData == null) return;
      if (currentData.meta.total <= perPage) return;
      final ClaimDraftsProductsParams productsParams =
          ClaimDraftsProductsParams(
        id: draftId,
        isSelected: 0,
        perPage: perPage,
        searchQuery: search.text,
      );
      final result =
          await repository.claimDraftProducts(draftId, productsParams);
      emit(ClaimDraftAddProductStartS(data: result));
    } catch (e) {
      emit(ClaimDraftAddProductErrorS());
    }
  }

  FutureOr<void> _addProductsStart(ClaimDraftAddProductStartE event,
      Emitter<ClaimDraftAddProductState> emit) async {
    try {
      _resetValidation();
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
    if (claimItem.value?.seriesName == null) return;
    try {
      emit(ClaimDraftAddProductLoadingS());

      ClaimDraftsProductsData? currentProduct;
      bool hasFind = false;
      int perPage = 1;
      while (!hasFind) {
        Future.delayed(const Duration(seconds: 5)).then((value) {
          if (hasFind) return;
          throw TimeoutException('Превышено время ожидания');
        });
        final productResult = await repository.claimDraftProducts(
            draftId,
            ClaimDraftsProductsParams(
              id: draftId,
              perPage: 25,
              page: perPage,
            ));

        for (var item in productResult.data) {
          if (item.seriesName == claimItem.value!.seriesName) {
            currentProduct = item;
            hasFind = true;
            break;
          }
        }
        perPage += 1;
      }

      if (currentProduct != null) {
        if (currentProduct.claimQuantity == 0) {
          quantityClaim.text = '';
        } else {
          quantityClaim.text = currentProduct.claimQuantity.toString();
          quantityClaim.validation = null;
        }
        comment.text = currentProduct.claimComment ?? '';
        final params = ClaimDraftsSaveParams(
          comment: claimDraftsInfoBloc.message.text,
          products: [
            ClaimDraftsProductsModel(
              id: currentProduct.id,
              claimType: claimTypeNumber.value,
              claimQuantity: int.tryParse(quantityClaim.text) ?? 0,
              claimComment: comment.text.isEmpty
                  ? null
                  : Formatter.textFormatter(comment.text),
            ),
          ],
        );
        await repository.claimDraftsSave(draftId, params);
        var imagesList = await loadImages(currentProduct.attachments ?? []);

        maxQuantityClaim = currentProduct.invoiceQuantity;

        emit(ClaimDraftAddProductS(
          id: draftId,
          product: currentProduct,
          isLoadingGallery: false,
          attachmentsList: imagesList,
        ));
        return;
      } else {
        emit(ClaimDraftAddProductErrorS());
      }
    } catch (e) {
      emit(ClaimDraftAddProductErrorS());
    }
  }

  Future<List<ClaimDraftFile>> loadImages(
      List<ClaimDraftsListAttachments> attachments) async {
    List<ClaimDraftFile> list = [];
    for (var attachment in attachments) {
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
        comment: claimDraftsInfoBloc.message.text,
        products: [
          ClaimDraftsProductsModel(
            id: product?.id ?? 0,
            claimType: claimTypeNumber.value,
            claimQuantity: int.tryParse(quantityClaim.text) ?? 0,
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

  late SuperValidation quantityClaim = SuperValidation(
    validationFunc: (value) => ClaimDraftsValidator.quantityClaim(
      value,
      maxQuantityClaim,
    ),
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

  void _resetValidation() {
    claimItem.value = null;
    search.clear();
    quantityClaim.clear();
    comment.clear();
    claimType.value = null;
    claimTypeNumber.value = null;
    isFirstLoading = true;
  }

  void _claimTypeListener(String? value) {
    if (value != 'Излишки') {
      final currentProduct = state is ClaimDraftAddProductS
          ? (state as ClaimDraftAddProductS).product
          : null;
      maxQuantityClaim = currentProduct?.invoiceQuantity ?? 5;
      quantityClaim.validation = ClaimDraftsValidator.quantityClaim(
          quantityClaim.text, maxQuantityClaim);
    } else {
      maxQuantityClaim = 1000000;
      quantityClaim.validation = null;
    }
  }

  void _quantityClaimListener(String value) {
    if (claimType.value != 'Излишки') {
      final currentProduct = state is ClaimDraftAddProductS
          ? (state as ClaimDraftAddProductS).product
          : null;
      maxQuantityClaim = currentProduct?.invoiceQuantity ?? 0;
    }
  }

  void _searchListener(String event) {
    if (event.isNotEmpty) {
      isFirstLoading = false;
    }
    add(ClaimDraftSearchE());
  }

  @override
  Future<void> close() {
    claimItem.dispose();
    search.dispose();
    quantityClaim.dispose();
    comment.dispose();
    claimType.dispose();
    claimTypeNumber.dispose();
    _searchSubscription?.cancel();

    return super.close();
  }
}
