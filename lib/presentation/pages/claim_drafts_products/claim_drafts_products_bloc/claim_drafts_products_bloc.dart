import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/claim_drafts/delete_products/params/claim_drafts_delete_products_params.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_drafts_bloc/claim_drafts_info_bloc.dart';

import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import '../../../../data/api/claim_drafts/save/params/claim_drafts_save_params.dart';
import '../../claim_drafts_info/claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';
import '../../claim_drafts_info/claim_drafts_error_cubit/claim_drafts_error_cubit.dart';

part 'claim_drafts_products_event.dart';
part 'claim_drafts_products_state.dart';

class ClaimDraftsProductsBloc
    extends Bloc<ClaimDraftsProductsEvent, ClaimDraftsProductsState> {
  final int id;
  final Repository repository;
  final ClaimDraftAddProductBloc addProductBloc;
  final ClaimDraftAddOverageBloc addOverageBloc;
  final ClaimDraftsErrorCubit claimDraftsErrorCubit;
  final ClaimDraftsInfoBloc claimDraftsInfoBloc;

  ClaimDraftsProductsBloc({
    required this.repository,
    required this.id,
    required this.addProductBloc,
    required this.claimDraftsInfoBloc,
    required this.claimDraftsErrorCubit,
    required this.addOverageBloc,
  }) : super(ClaimDraftsProductsInitialS()) {
    on<ClaimDraftsProductsFetchE>(_fetchProducts);
    on<ClaimDraftsProductsDeleteE>(_deleteProduct);
    on<ClaimDraftsProductsSaveE>(_saveProduct);
    on<ClaimDraftsProductsReloadE>(_reload);

    _initialize();

    _subscription =
        addProductBloc.stream.distinct().listen(_addProductBlocListener);
    _subscriptionOverage =
        addOverageBloc.stream.distinct().listen(_addOverageBlocListener);
  }

  late StreamSubscription<ClaimDraftAddProductState> _subscription;
  late StreamSubscription<ClaimDraftAddOverageState> _subscriptionOverage;

  @override
  Future<void> close() {
    _subscription.cancel();
    _subscriptionOverage.cancel();

    return super.close();
  }

  int maxQuantityClaim = 0;

  FutureOr<void> _fetchProducts(ClaimDraftsProductsFetchE event,
      Emitter<ClaimDraftsProductsState> emit) async {
    try {
      emit(ClaimDraftsProductsLoadingS());
      final products = await repository.claimDraftProducts(id, event.params);
      final limit = await repository.claimDraftProducts(
          id, ClaimDraftsProductsParams(id: id, isSelected: 0));

      products.data.isNotEmpty
          ? emit(ClaimDraftsProductsLoadedS(products: products, limit: limit))
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

  void saveProduct(ClaimDraftsProductsModel model) {
    add(ClaimDraftsProductsSaveE(model: model));
  }

  FutureOr<void> _saveProduct(ClaimDraftsProductsSaveE event,
      Emitter<ClaimDraftsProductsState> emit) async {
    try {
      final params = ClaimDraftsSaveParams(
        comment: claimDraftsInfoBloc.message.text,
        products: [event.model],
      );
      await repository.claimDraftsSave(id, params);
      _initialize();
    } catch (e) {
      emit(ClaimDraftsProductsErrorS());
    }
  }

  FutureOr<void> _reload(ClaimDraftsProductsReloadE event,
      Emitter<ClaimDraftsProductsState> emit) {
    _initialize();
  }

  void _addProductBlocListener(ClaimDraftAddProductState addProductState) {
    if (addProductState is ClaimDraftAddProductSaveSuccesS ||
        addProductState is ClaimDraftAddProductS) {
      _initialize();
    }
  }

  void _addOverageBlocListener(ClaimDraftAddOverageState addOverageState) {
    if (addOverageState is ClaimDraftAddOverageEditProductS) {
      _initialize();
    }
  }
}
