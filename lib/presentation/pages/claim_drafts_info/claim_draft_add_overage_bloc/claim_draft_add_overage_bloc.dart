import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/claim_draft_overages/add_overages/params/claim_drafts_add_overages_params.dart';
import 'package:mkk/data/api/claim_draft_overages/find_overages/entity/claim_drafts_find_overages_entity.dart';
import 'package:mkk/data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import 'package:mkk/domain/validators/claim_drafts/add_overages_validator.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../core/utils/resources/exception.dart';
import '../../../../data/api/claim_draft_overages/find_overages/params/claim_drafts_find_overage_params.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../domain/repositories/repository.dart';
import '../../app_loader/app_loader_bloc/app_loader_bloc.dart';

part 'claim_draft_add_overage_event.dart';
part 'claim_draft_add_overage_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class ClaimDraftAddOverageBloc
    extends Bloc<ClaimDraftAddOverageEvent, ClaimDraftAddOverageState> {
  final Repository repository;
  final int draftId;
  final AppLoaderBloc appLoaderBloc;
  ClaimDraftAddOverageBloc({
    required this.repository,
    required this.draftId,
    required this.appLoaderBloc,
  }) : super(ClaimDraftAddOverageInitialS()) {
    on<ClaimDraftAddOverageSearchE>(_search,
        transformer: debounceDroppable(const Duration(milliseconds: 1500)));
    on<ClaimDraftAddOverageSeriesE>(_selectSeries);
    on<ClaimDraftAddOverageSearchSeriesE>(_searchSeries);
    on<ClaimDraftAddOverageFiltersE>(_filters, transformer: droppable());
    on<ClaimDraftAddOverageInitialE>(_initial);
    on<ClaimDraftAddOverageBackE>(_back);
    on<ClaimDraftAddOverageSaveE>(_saveOverage);
    on<ClaimDraftAddOverageInitializeE>(_initialize);
    on<ClaimDraftAddOverageClearSeriesE>(_clearSeries);

    _searchSubscription = search.stream.distinct().listen(_searchListener);
  }

  StreamSubscription<String?>? _searchSubscription;

  FutureOr<void> _search(ClaimDraftAddOverageSearchE event,
      Emitter<ClaimDraftAddOverageState> emit) async {
    try {
      if (search.text.isEmpty) {
        add(ClaimDraftAddOverageInitializeE());
        return;
      }
      if (search.text.length < 3) return;
      //emit(ClaimDraftAddOverageLoadingS());
      _startLoading();
      final params =
          ClaimDraftsFindOveragesParams(searchQuery: search.text.trimLeft());
      final result = await repository.claimDraftsFindOverages(params);
      _clearProduct();
      emit(ClaimDraftAddOverageProductS(entity: result));
      _stopLoading();
    } catch (e) {
      emit(ClaimDraftAddOverageSearchErrorS(message: e.toString()));
      _stopLoading();
    }
  }

  FutureOr<void> _filters(ClaimDraftAddOverageFiltersE event,
      Emitter<ClaimDraftAddOverageState> emit) async {
    try {
      if (search.text.length < 3) return;
      //emit(ClaimDraftAddOverageLoadingS());
      _startLoading();
      if (manufacturer.value == 'Все производители') {
        final params = ClaimDraftsFindOveragesParams(searchQuery: search.text);
        final result = await repository.claimDraftsFindOverages(params);
        emit(ClaimDraftAddOverageProductS(entity: result));
        _stopLoading();
        return;
      }

      final params = ClaimDraftsFindOveragesParams(
          searchQuery: search.text, manufacturer: manufacturer.value);
      final result = await repository.claimDraftsFindOverages(params);

      emit(ClaimDraftAddOverageProductS(entity: result));
      _stopLoading();
    } catch (e) {
      emit(ClaimDraftAddOverageErrorS());
      _stopLoading();
    }
  }

  FutureOr<void> _selectSeries(ClaimDraftAddOverageSeriesE event,
      Emitter<ClaimDraftAddOverageState> emit) async {
    if (product.value == null) return;
    emit(ClaimDraftAddOveragesSeriesS(product: product.value!));
  }

  FutureOr<void> _searchSeries(ClaimDraftAddOverageSearchSeriesE event,
      Emitter<ClaimDraftAddOverageState> emit) async {
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
    emit(ClaimDraftAddOveragesSeriesS(
        product: newProd.copyWith(series: filteredSeries)));
  }

  FutureOr<void> _clearSeries(ClaimDraftAddOverageClearSeriesE event,
      Emitter<ClaimDraftAddOverageState> emit) async {
    if (product.value == null) return;
    searchSeries.clear();
    emit(ClaimDraftAddOveragesSeriesS(product: product.value!));
  }

  FutureOr<void> _saveOverage(ClaimDraftAddOverageSaveE event,
      Emitter<ClaimDraftAddOverageState> emit) async {
    final overageProduct = product.value;
    final overageSeries = series.value;
    if (overageProduct == null || overageSeries == null) return;
    _startLoading();
    try {
      final params = ClaimDraftAddOveragesParams(
        guid: overageProduct.guid,
        name: overageProduct.name,
        seriesGuid: overageSeries.guid,
        seriesName: overageSeries.name,
      );
      await repository.claimDraftAddOverages(params, draftId);

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
          if (item.seriesName == overageSeries.name) {
            currentProduct = item;
            hasFind = true;
            break;
          }
        }
        perPage += 1;
      }

      if (currentProduct != null) {
        emit(ClaimDraftAddOverageEditProductS(product: currentProduct));
        add(ClaimDraftAddOverageInitialE());
        _stopLoading();
        return;
      }
      add(ClaimDraftAddOverageInitialE());
      _stopLoading();
    } catch (e) {
      _resetValidation();
      if (e is BadRequestHttpFailure) {
        emit(ClaimDraftAddOverageSaveErrorS(
            message: e.message, title: 'Внимание!'));
        _stopLoading();
        return;
      }
      emit(const ClaimDraftAddOverageSaveErrorS(
          message: 'Непредвиденная ошибка', title: 'Внимание!'));
      _stopLoading();
    }
  }

  FutureOr<void> _initialize(ClaimDraftAddOverageInitializeE event,
      Emitter<ClaimDraftAddOverageState> emit) {
    _resetValidation();
    emit(ClaimDraftAddOverageInitialS());
  }

  FutureOr<void> _initial(ClaimDraftAddOverageInitialE event,
      Emitter<ClaimDraftAddOverageState> emit) {
    emit(ClaimDraftAddOverageInitialS());
    add(ClaimDraftAddOverageSearchE());
    _resetValidation();
  }

  FutureOr<void> _back(ClaimDraftAddOverageBackE event,
      Emitter<ClaimDraftAddOverageState> emit) async {
    if (manufacturer.value != 'Все производители') {
      emit(ClaimDraftAddOverageInitialS());
      _backWithFilters();
      return;
    }
    emit(ClaimDraftAddOverageInitialS());
    _backWithSearch();
  }

  void _backWithSearch() {
    add(ClaimDraftAddOverageSearchE());
    product.value = null;
    series.value = null;
    searchSeries.text = '';
  }

  void _backWithFilters() {
    add(ClaimDraftAddOverageFiltersE());
    product.value = null;
    series.value = null;
    searchSeries.text = '';
  }

  void _resetValidation() {
    search.text = '';
    searchSeries.text = '';
    manufacturer.value = 'Все производители';
    product.value = null;
    series.value = null;
  }

  void _searchListener(String event) {
    add(ClaimDraftAddOverageSearchE());
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

  @override
  Future<void> close() {
    _searchSubscription?.cancel();
    search.dispose();
    searchSeries.dispose();
    manufacturer.dispose();
    product.dispose();
    series.dispose();
    return super.close();
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
}
