// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import '../../../../data/api/invoices/detail/products/params/invoices_detail_products_params.dart';
import '../../../../domain/repositories/repository.dart';

part 'invoices_products_event.dart';
part 'invoices_products_state.dart';

class InvoicesProductsBloc
    extends Bloc<InvoicesProductsEvent, InvoicesProductsState> {
  final Repository repository;
  final String uuid;
  InvoicesProductsBloc({
    required this.repository,
    required this.uuid,
  }) : super(InvoicesProductsInitialS()) {
    on<InvoicesProductsFetchE>(_fetchProducts);
    on<InvoicesProductsRefreshE>(_refreshProducts);
    add(InvoicesProductsFetchE(uuid: uuid));
  }

  FutureOr<void> _fetchProducts(
      InvoicesProductsFetchE event, Emitter<InvoicesProductsState> emit) async {
    try {
      emit(InvoicesProductsLoadingS());
      final InvoicesDetailProductsParams productsParams =
          InvoicesDetailProductsParams(uuid: uuid);
      final result = await repository.invoicesDetailProducts(productsParams);
      emit(InvoicesProductsLoadedS(products: result));
    } catch (e) {
      emit(InvoicesProductsErrorS(message: e.toString()));
    }
  }

  FutureOr<void> _refreshProducts(
      InvoicesProductsRefreshE event, Emitter<InvoicesProductsState> emit) {
    add(InvoicesProductsFetchE(uuid: uuid));
  }
}
