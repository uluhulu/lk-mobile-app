import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:mkk/domain/validators/claims/claims_validator.dart';
import 'package:mkk/services/filter_saver_service.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../core/utils/date_format.dart';
import '../../../../data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../../../../data/api/claim_drafts/list/params/claim_drafts_list_params.dart';
import '../../../../data/api/claims/main/entity/claims_entity.dart';
import '../../../../data/api/claims/main/params/claims_params.dart';
import '../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../domain/validators/invoices/invoices_validator.dart';

part 'claims_event.dart';
part 'claims_state.dart';

class ClaimsBloc extends Bloc<ClaimsEvent, ClaimsState> {
  final Repository repository;
  ClaimsBloc({
    required this.repository,
  }) : super(ClaimsInitialS()) {
    on<ClaimsFetchE>(_fetchClaims);
    on<ClaimsSortListE>(_sort);
    on<ClaimsResetFiltersE>(_resetFilters);
    on<ClaimsApplyFiltersE>(_applyFilters);
    on<ClaimsRefreshE>(_refresh);

    _initialize();
  }

  final filterSaver = FilterSaverService.instance;

  String? getFilterCount() {
    String count = '';
    if (address.value != null) {
      count = '1';
    }
    if (claimStatus.value != null) {
      count = '2';
    }

    return count.isNotEmpty ? count : null;
  }

  void _initialize() {
    final DateTime now = DateTime.now();
    final dayCounter = now.day - 1;

    final dateFrom =
        DateFormats.yyyyMMdd(now.subtract(Duration(days: dayCounter)));
    final dateTo = DateFormats.yyyyMMdd(now);

    address.value = null;
    claimStatus.value = null;
    sort.value = null;

    dateRange.text =
        '${DateFormats.isoDateFormatter(dateFrom)} - ${DateFormats.isoDateFormatter(dateTo)}';

    final filters = filterSaver.getFilter('claims');
    if (filters != null) {
      final getClaimsFilter = filterSaver.getFilter('claims');
      if (getClaimsFilter != null) {
        dateRange.text =
            '${DateFormats.isoDateFormatter(getClaimsFilter['dateFrom'])} - ${DateFormats.isoDateFormatter(getClaimsFilter['dateTo'])}';
        address.value = getClaimsFilter['address'];
        claimStatus.value = getClaimsFilter['status'];
      }
      final getSortSaves = filterSaver.getFilter('sort');
      if (getSortSaves != null) {
        sort.value = getSortSaves['sort'];
      }
    }

    final params = ClaimsParams(
      dateFrom: dateFrom,
      dateTo: dateTo,
      address: address.value?.uuid,
      status: claimStatus.value,
      sorting: sort.value ?? ClaimsSorting.desk,
    );

    add(ClaimsFetchE(params: params));
  }

  FutureOr<void> _fetchClaims(
      ClaimsFetchE event, Emitter<ClaimsState> emit) async {
    try {
      emit(ClaimsLoadingS());
      final result = await repository.claims(event.params);
      final claimDrafts =
          await repository.claimDraftsList(ClaimDraftsListParams());
      result.data.isNotEmpty
          ? emit(ClaimsLoadedS(
              data: result,
              drafts: claimDrafts,
              currentPage: result.meta.currentPage,
              numberPages: result.meta.lastPage,
              sortType: sort.value ?? ClaimsSorting.desk,
              params: event.params,
            ))
          : emit(ClaimsEmptyS(
              data: result,
              drafts: claimDrafts,
            ));
    } catch (e) {
      emit(ClaimsErrorS(message: e.toString()));
    }
  }

  FutureOr<void> _sort(ClaimsSortListE event, Emitter<ClaimsState> emit) {
    if (state is ClaimsLoadedS) {
      final currentPage = (state as ClaimsLoadedS).currentPage;
      add(ClaimsFetchE(
          params: (state as ClaimsLoadedS).params.copyWith(
                sorting: event.type,
                page: currentPage,
              )));

      filterSaver.saveFilter(
        'sort',
        {
          'sort': sort.value ?? ClaimsSorting.desk,
        },
      );
    }
  }

  List<String> splitDates(String date) {
    return date.split(' - ');
  }

  FutureOr<void> _resetFilters(
      ClaimsResetFiltersE event, Emitter<ClaimsState> emit) {
    filterSaver.clearAllFilters();
    _initialize();
  }

  final SuperValidation dateRange = SuperValidation(
    validationFunc: InvoicesValidator.validateDateFrom,
  );

  final SuperValidationEnum<Addresses> address = SuperValidationEnum(
    validateFunc: InvoicesValidator.validateAddress,
  );

  final SuperValidationEnum<String> claimStatus = SuperValidationEnum(
    validateFunc: InvoicesValidator.validateMarkedStatus,
  );

  final SuperValidationEnum<ClaimsSorting> sort = SuperValidationEnum(
    validateFunc: ClaimsValidator.validateSortClaim,
  );

  FutureOr<void> _applyFilters(
      ClaimsApplyFiltersE event, Emitter<ClaimsState> emit) {
    final dateFrom = DateFormats.yyyyMMdd(
        DateFormat().add_yMd().parse(splitDates(dateRange.text).first));

    final dateTo = DateFormats.yyyyMMdd(
        DateFormat().add_yMd().parse(splitDates(dateRange.text).last));

    final ClaimsParams params = ClaimsParams(
      dateFrom: dateFrom,
      dateTo: dateTo,
      address: address.value?.uuid,
      status: claimStatus.value,
      sorting: sort.value ?? ClaimsSorting.desk,
    );

    filterSaver.saveFilter(
      'claims',
      {
        'dateFrom': dateFrom,
        'dateTo': dateTo,
        'address': address.value,
        'status': claimStatus.value,
      },
    );

    add(ClaimsFetchE(params: params));
  }

  FutureOr<void> _refresh(ClaimsRefreshE event, Emitter<ClaimsState> emit) {
    _initialize();
  }
}
