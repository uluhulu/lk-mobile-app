import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/invoices/find/params/invoices_find_params.dart';

import 'package:mkk/domain/repositories/repository.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../../domain/enums/invoices/invoices_search_type.dart';
import '../../../../domain/validators/invoices/invoices_validator.dart';

part 'invoices_search_event.dart';
part 'invoices_search_state.dart';

class InvoicesSearchBloc
    extends Bloc<InvoicesSearchEvent, InvoicesSearchState> {
  final Repository repository;
  InvoicesSearchBloc({
    required this.repository,
  }) : super(InvoicesSearchInitialS()) {
    on<InvoicesSearchFetchE>(_fetchSearch);
  }

  FutureOr<void> _fetchSearch(
      InvoicesSearchFetchE event, Emitter<InvoicesSearchState> emit) async {
    try {
      emit(InvoicesSearchLoadingS());
      //loading();
      final params = InvoicesFindParams(
        search: search.text.trim(),
        searchBy: InvoicesSearchTypeParser.searchBy(
            type.value ?? InvoicesSearchType.invoice),
      );
      final result = await repository.invoicesSearch(params);

      emit(InvoicesSearchLoadedS(invoicesSearch: result.data));
      //loaded();
    } catch (e) {
      emit(InvoicesSearchErrorS(message: search.text));
    }
  }

  final SuperValidation search = SuperValidation(
    validationFunc: InvoicesValidator.validateSearch,
  );

  final SuperValidationEnum<InvoicesSearchType> type = SuperValidationEnum(
    validateFunc: InvoicesValidator.validateSearchType,
  );

  // final SuperLoading superLoading = SuperLoading();

  // void loading() {
  //   superLoading.value = true;
  // }

  // void loaded() {
  //   superLoading.value = false;
  // }
}
