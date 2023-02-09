import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/claims/find/params/search_claims_params.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../data/api/claims/main/entity/claims_entity.dart';
import '../../../../domain/enums/claims/claims_search_type.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../domain/validators/claims/claims_validator.dart';
import '../../../../domain/validators/invoices/invoices_validator.dart';

part 'claims_search_event.dart';
part 'claims_search_state.dart';

class ClaimsSearchBloc extends Bloc<ClaimsSearchEvent, ClaimsSearchState> {
  final Repository repository;
  ClaimsSearchBloc({
    required this.repository,
  }) : super(ClaimsSearchInitialS()) {
    on<ClaimsSearchFetchE>(_fetchSearch);
  }

  FutureOr<void> _fetchSearch(
      ClaimsSearchFetchE event, Emitter<ClaimsSearchState> emit) async {
    try {
      emit(ClaimsSearchLoadingS());

      final params = SearchClaimsParams(
        number: number.text.trim(),
      );
      final result = await repository.claimsSearch(params);

      emit(ClaimsSearchLoadedS(claimsData: result.data.first));
    } catch (e) {
      emit(ClaimsSearchErrorS(message: number.text));
    }
  }

  final SuperValidation number = SuperValidation(
    validationFunc: InvoicesValidator.validateSearch,
  );

  final SuperValidationEnum<ClaimsSearchType> type = SuperValidationEnum(
    validateFunc: ClaimsValidator.validateSearchType,
  );

  @override
  Future<void> close() {
    number.dispose();
    type.dispose();
    return super.close();
  }
}
