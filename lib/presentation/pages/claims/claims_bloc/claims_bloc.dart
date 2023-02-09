import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:mkk/domain/validators/claims/claims_validator.dart';
import 'package:mkk/services/claim_filter_saver_service.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/time_zone.dart';
import '../../../../data/api/claims/main/entity/claims_entity.dart';
import '../../../../data/api/claims/main/params/claims_params.dart';
import '../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../domain/validators/invoices/invoices_validator.dart';
import '../../claim_drafts_observer/claim_drafts_observer_bloc/claim_drafts_observer.dart';
import 'package:timezone/standalone.dart' as tz;

part 'claims_event.dart';
part 'claims_state.dart';

class ClaimsBloc extends Bloc<ClaimsEvent, ClaimsState> {
  final Repository repository;
  final ClaimDraftsObserverBloc observerBloc;
  ClaimsBloc({
    required this.repository,
    required this.observerBloc,
  }) : super(ClaimsInitialS()) {
    on<ClaimsFetchE>(_fetchClaims);
    on<ClaimsSortListE>(_sort);
    on<ClaimsResetFiltersE>(_resetFilters);
    on<ClaimsApplyFiltersE>(_applyFilters);
    on<ClaimsRefreshE>(_refresh);

    _initialize();

    _observerSubscription = observerBloc.stream.listen(_observerListener);
  }

  final filterSaver = ClaimFilterSaverService.instance;

  StreamSubscription<ClaimDraftsObserverState>? _observerSubscription;

  int? getFilterCount() {
    int count = 0;
    if (address.value != null) {
      count += 1;
    }
    if (claimStatus.value != null) {
      count += 1;
    }

    return count > 0 ? count : null;
  }

  void _initialize() {
    final DateTime now = tz.TZDateTime.from(DateTime.now(), TimeZone.moscow);

    final dayCounter = now.day - 1;

    String dateFrom =
        DateFormats.yyyyMMdd(now.subtract(Duration(days: dayCounter)));
    String dateTo = DateFormats.yyyyMMdd(now);

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
        dateFrom = getClaimsFilter['dateFrom'];
        dateTo = getClaimsFilter['dateTo'];
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

      result.data.isNotEmpty
          ? emit(ClaimsLoadedS(
              data: result,
              currentPage: result.meta.currentPage,
              numberPages: result.meta.lastPage,
              sortType: sort.value ?? ClaimsSorting.desk,
              params: event.params,
            ))
          : emit(ClaimsEmptyS(data: result));
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

  void _observerListener(ClaimDraftsObserverState observerState) {
    if (observerState is ClaimDraftsObserverNeedUpdateS) {
      add(ClaimsRefreshE());
    }
  }

  @override
  Future<void> close() async {
    await dateRange.dispose();
    await address.dispose();
    await claimStatus.dispose();
    await sort.dispose();
    await _observerSubscription?.cancel();
    return super.close();
  }
}
