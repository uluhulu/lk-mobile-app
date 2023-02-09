import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/core/utils/formatter.dart';
import 'package:mkk/data/api/claim_drafts/create/params/claim_drafts_create_params.dart';
import 'package:mkk/services/logger/logger_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../core/utils/resources/exception.dart';
import '../../../../../data/api/claim_draft_overages/add_overages/params/claim_drafts_add_overages_params.dart';
import '../../../../../data/api/claim_draft_overages/find_overages/entity/claim_drafts_find_overages_entity.dart';
import '../../../../../data/api/claim_draft_overages/find_overages/params/claim_drafts_find_overage_params.dart';
import '../../../../../data/api/claim_drafts/claim_draft_attachments/add_claim_draft_attachments/params/add_claim_draft_attachments_params.dart';
import '../../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';
import '../../../../../data/api/claim_drafts/delete_products/params/claim_drafts_delete_products_params.dart';
import '../../../../../data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../../data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import '../../../../../data/api/claim_drafts/save/params/claim_drafts_save_params.dart';
import '../../../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import '../../../../../domain/repositories/repository.dart';
import '../../../../../domain/validators/claim_drafts/add_overages_validator.dart';
import '../../../../../domain/validators/claim_drafts/claim_drafts_validator.dart';
import '../../../app_loader/app_loader_bloc/app_loader_bloc.dart';
import '../../../claim_drafts_info/claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';

import 'package:path/path.dart';

part 'invoice_add_overage_event.dart';
part 'invoice_add_overage_state.dart';

class InvoiceAddOverageBloc
    extends Bloc<InvoiceAddOverageEvent, InvoiceAddOverageState> {
  final Repository repository;
  final AppLoaderBloc appLoaderBloc;
  final String guid;
  InvoiceAddOverageBloc({
    required this.repository,
    required this.guid,
    required this.appLoaderBloc,
  }) : super(InvoiceAddOverageInitialS()) {
    on<InvoiceAddOverageSearchE>(_search,
        transformer: debounceDroppable(const Duration(milliseconds: 1500)));
    on<InvoiceAddOverageSeriesE>(_selectSeries);
    on<InvoiceAddOverageSearchSeriesE>(_searchSeries);
    on<InvoiceAddOverageFiltersE>(_filters, transformer: droppable());
    on<InvoiceAddOverageInitialE>(_initial);
    on<InvoiceAddOverageSaveE>(_saveOverage);
    on<InvoiceAddOverageInitializeE>(_initialize);
    on<InvoiceAddOverageDeleteProductE>(_deleteProduct);
    on<InvoiceAddOverageSaveProductE>(_saveClaim);
    on<InvoiceAddOverageUploadAttachmentsE>(_updateClaimDraftImages);
    on<InvoiceAddOverageDeleteImageE>(_deleteImage);
    on<InvoiceAddOverageClearSeriesE>(_clearSeries);
    on<InvoiceAddOverageBackE>(_back);

    _searchSubscription = search.stream.distinct().listen(_searchListener);
  }

  StreamSubscription<String?>? _searchSubscription;

  FutureOr<void> _search(InvoiceAddOverageSearchE event,
      Emitter<InvoiceAddOverageState> emit) async {
    try {
      if (search.text.length < 3) return;
      // emit(InvoiceAddOverageLoadingS());
      _startLoading();
      final params =
          ClaimDraftsFindOveragesParams(searchQuery: search.text.trimLeft());
      final result = await repository.claimDraftsFindOverages(params);
      _clearProduct();
      emit(InvoiceAddOverageProductS(entity: result));
      _stopLoading();
    } catch (e) {
      emit(InvoiceAddOverageSearchErrorS(message: e.toString()));
      _stopLoading();
    }
  }

  FutureOr<void> _filters(InvoiceAddOverageFiltersE event,
      Emitter<InvoiceAddOverageState> emit) async {
    try {
      if (search.text.length < 3) return;
      // emit(InvoiceAddOverageLoadingS());
      _startLoading();
      if (manufacturer.value == 'Все производители') {
        final params = ClaimDraftsFindOveragesParams(searchQuery: search.text);
        final result = await repository.claimDraftsFindOverages(params);
        emit(InvoiceAddOverageProductS(entity: result));
        _stopLoading();
        return;
      }

      final params = ClaimDraftsFindOveragesParams(
          searchQuery: search.text, manufacturer: manufacturer.value);
      final result = await repository.claimDraftsFindOverages(params);
      emit(InvoiceAddOverageProductS(entity: result));
      _stopLoading();
    } catch (e) {
      emit(InvoiceAddOverageErrorS(message: e.toString()));
      _stopLoading();
    }
  }

  FutureOr<void> _selectSeries(InvoiceAddOverageSeriesE event,
      Emitter<InvoiceAddOverageState> emit) async {
    if (product.value == null) return;
    emit(InvoiceAddOveragesSeriesS(product: product.value!));
  }

  FutureOr<void> _searchSeries(InvoiceAddOverageSearchSeriesE event,
      Emitter<InvoiceAddOverageState> emit) async {
    if (product.value == null) return;
    final ClaimDraftFindOverageData newProd = product.value!;
    final List<OverageSeries> seriesList = newProd.series;
    if (seriesList.isEmpty) return;
    final List<OverageSeries> filteredSeries = seriesList.where((element) {
      return element.name
              .toLowerCase()
              .contains(searchSeries.text.toLowerCase()) ||
          element.code.toLowerCase().contains(searchSeries.text.toLowerCase());
    }).toList();
    emit(InvoiceAddOveragesSeriesS(
        product: newProd.copyWith(series: filteredSeries)));
  }

  FutureOr<void> _clearSeries(InvoiceAddOverageClearSeriesE event,
      Emitter<InvoiceAddOverageState> emit) async {
    if (product.value == null) return;
    searchSeries.clear();
    emit(InvoiceAddOveragesSeriesS(product: product.value!));
  }

  FutureOr<void> _saveOverage(InvoiceAddOverageSaveE event,
      Emitter<InvoiceAddOverageState> emit) async {
    final overageProduct = product.value;
    final overageSeries = series.value;
    if (overageProduct == null || overageSeries == null) return;

    _startLoading();
    final createDraftId =
        await repository.claimDraftsCreate(ClaimDraftsCreateParams(
      invoiceGuid: guid,
      selectedProducts: [],
    ));
    try {
      final params = ClaimDraftAddOveragesParams(
        guid: overageProduct.guid,
        name: overageProduct.name,
        seriesGuid: overageSeries.guid,
        seriesName: overageSeries.name,
      );
      await repository.claimDraftAddOverages(params, createDraftId.draftId);

      ClaimDraftsProductsData? currentProduct;
      bool hasFind = false;
      int perPage = 1;
      while (!hasFind) {
        Future.delayed(const Duration(seconds: 5)).then((value) {
          if (hasFind) return;
          throw TimeoutException('Превышено время ожидания');
        });
        final productResult = await repository.claimDraftProducts(
            createDraftId.draftId,
            ClaimDraftsProductsParams(
              id: createDraftId.draftId,
              perPage: 25,
              page: perPage,
            ));

        for (var item in productResult.data) {
          if (item.seriesName == overageSeries.name) {
            currentProduct = item;
            hasFind = true;
            break;
          }
        }
        perPage += 1;
      }

      var imagesList = await loadImages(currentProduct?.attachments ?? []);

      if (currentProduct != null) {
        if (currentProduct.claimQuantity == 0) {
          quantityClaim.text = '';
        } else {
          quantityClaim.text = currentProduct.claimQuantity.toString();
        }
        comment.text = currentProduct.claimComment ?? '';

        emit(InvoiceAddOverageEditProductS(
          product: currentProduct,
          draftId: createDraftId.draftId,
          isImageGalleryLoading: false,
          attachments: imagesList,
        ));
        _stopLoading();
        return;
      }
      add(InvoiceAddOverageInitializeE());
      _stopLoading();
    } catch (e) {
      _resetValidation();
      if (e is BadRequestHttpFailure) {
        emit(InvoiceAddOverageSaveErrorS(
            message: e.message, title: 'Внимание!'));
        _stopLoading();
        return;
      }
      emit(const InvoiceAddOverageSaveErrorS(
          message: 'Непредвиденная ошибка', title: 'Внимание!'));
      _stopLoading();
    }
  }

  FutureOr<void> _back(InvoiceAddOverageBackE event,
      Emitter<InvoiceAddOverageState> emit) async {
    if (manufacturer.value != 'Все производители') {
      emit(InvoiceAddOverageInitialS());
      _backWithFilters();
      return;
    }
    emit(InvoiceAddOverageInitialS());
    _backWithSearch();
  }

  void _backWithSearch() {
    add(InvoiceAddOverageSearchE());
    product.value = null;
    series.value = null;
    searchSeries.clear();
  }

  void _backWithFilters() {
    add(InvoiceAddOverageFiltersE());
    product.value = null;
    series.value = null;
    searchSeries.clear();
  }

  Future<List<ClaimDraftFile>> loadImages(
      List<ClaimDraftsListAttachments> attachments) async {
    List<ClaimDraftFile> list = [];

    for (var attachment in attachments) {
      var path = attachment.url!.split("/").last;
      // print("qwertyu123 $path");
      // final uri = Uri.parse(attachment.url!);
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

  FutureOr<void> _deleteProduct(InvoiceAddOverageDeleteProductE event,
      Emitter<InvoiceAddOverageState> emit) async {
    _startLoading();
    try {
      final claimId = state is InvoiceAddOverageEditProductS
          ? (state as InvoiceAddOverageEditProductS).draftId
          : 0;

      final params = ClaimDraftsDeleteProductsParams(ids: [event.id]);
      await repository.claimDraftsDeleteProducts(id: claimId, params: params);
      add(InvoiceAddOverageInitialE());
      _stopLoading();
    } catch (e) {
      add(InvoiceAddOverageInitialE());
      _stopLoading();
    }
  }

  FutureOr<void> _saveClaim(InvoiceAddOverageSaveProductE event,
      Emitter<InvoiceAddOverageState> emit) async {
    try {
      _startLoading();
      final draftId = state is InvoiceAddOverageEditProductS
          ? (state as InvoiceAddOverageEditProductS).draftId
          : 0;
      final product = state is InvoiceAddOverageEditProductS
          ? (state as InvoiceAddOverageEditProductS).product
          : null;

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
      emit(InvoiceAddOverageSaveSuccesS(id: draftId));
      _stopLoading();
    } catch (e) {
      emit(InvoiceAddOverageErrorS(message: e.toString()));
      //add(InvoiceAddOverageInitialE());
      _stopLoading();
    }
  }

  FutureOr<void> _updateClaimDraftImages(
      InvoiceAddOverageUploadAttachmentsE event,
      Emitter<InvoiceAddOverageState> emit) async {
    try {
      var s = state as InvoiceAddOverageEditProductS;
      final draftId = state is InvoiceAddOverageEditProductS ? s.draftId : 0;
      final product = state is InvoiceAddOverageEditProductS ? s.product : null;
      var list = event.newAttachments
          .map((file) => ClaimDraftAttachmentsParams.fromFile(file))
          .toList();
      final addClaimDraftAttachmentsParams = AddClaimDraftAttachmentsParams(
        claimId: draftId,
        productId: product?.id ?? 0,
        attachments: list,
      );

      emit(InvoiceAddOverageEditProductS(
        draftId: draftId,
        product: product!,
        attachments: s.attachments,
        isImageGalleryLoading: true,
      ));

      await repository
          .updateClaimDraftAttachments(addClaimDraftAttachmentsParams);
      final updatedProduct = await repository.claimDraftsInfo(draftId);

      var updatedImages =
          await loadImages(updatedProduct.data.attachments ?? []);
      emit(
        InvoiceAddOverageEditProductS(
          draftId: draftId,
          product: product,
          attachments: updatedImages,
          isImageGalleryLoading: false,
        ),
      );
    } catch (e) {
      emit(InvoiceAddOverageErrorS(message: e.toString()));
    }
  }

  FutureOr<void> _deleteImage(InvoiceAddOverageDeleteImageE event,
      Emitter<InvoiceAddOverageState> emit) async {
    try {
      await repository.deleteClaimDraftImage(event.id);
      var s = state as InvoiceAddOverageEditProductS;
      final draftId = state is InvoiceAddOverageEditProductS ? s.draftId : 0;
      final product = state is InvoiceAddOverageEditProductS ? s.product : null;
      var imagesList = [...s.attachments];
      imagesList.removeWhere((element) => element.id == event.id);

      emit(InvoiceAddOverageEditProductS(
        draftId: draftId,
        product: product!,
        attachments: imagesList,
        isImageGalleryLoading: false,
      ));
    } catch (e) {
      emit(InvoiceAddOverageErrorS(message: e.toString()));
    }
  }

  FutureOr<void> _initialize(InvoiceAddOverageInitializeE event,
      Emitter<InvoiceAddOverageState> emit) {
    _resetValidation();
    emit(InvoiceAddOverageInitialS());
  }

  FutureOr<void> _initial(
      InvoiceAddOverageInitialE event, Emitter<InvoiceAddOverageState> emit) {
    emit(InvoiceAddOverageInitialS());
    add(InvoiceAddOverageSearchE());
    product.value = null;
    series.value = null;
  }

  void _resetValidation() {
    search.text = '';
    searchSeries.text = '';
    manufacturer.value = 'Все производители';
    product.value = null;
    series.value = null;
  }

  void _searchListener(String event) {
    add(InvoiceAddOverageSearchE());
  }

  void _startLoading() {
    appLoaderBloc.add(AppLoaderStartE());
  }

  void _stopLoading() {
    appLoaderBloc.add(AppLoaderStopE());
  }

  void _clearProduct() {
    if (product.value != null) {
      product.value = null;
      manufacturer.value = 'Все производители';
    }
  }

  final SuperValidation search = SuperValidation();

  final SuperValidation searchSeries = SuperValidation();

  final SuperValidationEnum<String> manufacturer = SuperValidationEnum<String>()
    ..value = 'Все производители';

  final SuperValidationEnum<ClaimDraftFindOverageData> product =
      SuperValidationEnum<ClaimDraftFindOverageData>(
    validateFunc: AddOveragesValidator.productValidation,
  );

  final SuperValidationEnum<OverageSeries> series =
      SuperValidationEnum<OverageSeries>(
    validateFunc: AddOveragesValidator.seriesValidation,
  );

  final SuperValidationEnum<InvoicesDetailProductData> invoiceItem =
      SuperValidationEnum(
    validateFunc: ClaimDraftsValidator.claimType,
  );

  late SuperValidation quantityClaim = SuperValidation(
    validationFunc: (value) {
      return ClaimDraftsValidator.quantityClaim(value, 1000000);
    },
  );

  SuperValidation comment = SuperValidation();

  final SuperValidationEnum<String> claimType = SuperValidationEnum(
    validateFunc: ClaimDraftsValidator.claimTypeWithDrafts,
  )..value = 'Излишки';

  final SuperValidationEnum<int> claimTypeNumber = SuperValidationEnum(
    validateFunc: null,
  );

  @override
  Future<void> close() {
    _searchSubscription?.cancel();
    search.dispose();
    searchSeries.dispose();
    manufacturer.dispose();
    product.dispose();
    series.dispose();
    invoiceItem.dispose();
    claimType.dispose();
    comment.dispose();
    quantityClaim.dispose();

    return super.close();
  }
}
