import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:mkk/core/utils/date_format.dart';
import 'package:mkk/data/api/invoices/list/entity/invoices_entity.dart';
import 'package:mkk/data/api/invoices/list/params/invoices_list_params.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/domain/validators/invoices/invoices_validator.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../domain/enums/invoices/invoices_marked_type.dart';
import '../../../../domain/enums/invoices/invoices_sort_type.dart';

part 'invoices_event.dart';
part 'invoices_state.dart';

class InvoicesBloc extends Bloc<InvoicesEvent, InvoicesState> {
  final Repository repository;

  InvoicesBloc({
    required this.repository,
  }) : super(InvoicesInitialS()) {
    on<InvoicesFetchE>(_fetchList);
    on<InvoicesResetFiltersE>(_reset);
    on<InvoicesSortListE>(_sort);
    on<InvoicesApplyFiltersE>(_applyFilters);
    on<InvoicesRefreshE>(_refresh);

    _initialize();
  }

  String? getFilterCount() {
    String count = '';
    if (address.value != null) {
      count = '1';
    }
    if (marked.value != null) {
      count = '2';
    }
    if (markedStatus.value != null) {
      count = '3';
    }

    return count.isNotEmpty ? count : null;
  }

  late InvoicesEntity currentData;

  InvoicesEntity? copyData;

  void _initialize() {
    final DateTime now = DateTime.now();

    final dateFrom =
        DateFormats.yyyyMMdd(now.subtract(Duration(days: now.weekday - 1)));
    final dateTo = DateFormats.yyyyMMdd(now);

    // ///ДЛЯ ТЕСТОВ
    // final dateFrom =
    //     DateFormats.yyyyMMdd(now.subtract(const Duration(days: 360)));
    // final dateTo = DateFormats.yyyyMMdd(now);

    address.value = null;
    marked.value = null;
    markedStatus.value = null;
    sort.value = null;

    final params = InvoicesListParams(
      dateFrom: dateFrom,
      dateTo: dateTo,
    );

    dateRange.text =
        '${DateFormats.isoDateFormatter(dateFrom)} - ${DateFormats.isoDateFormatter(dateTo)}';

    add(InvoicesFetchE(params: params));
  }

  FutureOr<void> _fetchList(
      InvoicesFetchE event, Emitter<InvoicesState> emit) async {
    try {
      emit(InvoicesLoadingS());
      final result = await repository.invoices(event.params);

      result.data.isNotEmpty
          ? emit(InvoicesLoadedS(
              data: result,
              currentPage: result.meta.currentPage,
              numberPages: result.meta.lastPage,
              sortType: sort.value ?? InvoicesSorting.desk,
              params: event.params,
            ))
          : emit(InvoicesEmptyS(data: result));
      copyData = result;
      currentData = result;
    } catch (e) {
      emit(InvoicesErrorS(message: e.toString()));
    }
  }

  FutureOr<void> _reset(
      InvoicesResetFiltersE event, Emitter<InvoicesState> emit) {
    _initialize();
  }

  FutureOr<void> _sort(InvoicesSortListE event, Emitter<InvoicesState> emit) {
    if (state is InvoicesLoadedS) {
      final currentPage = (state as InvoicesLoadedS).currentPage;
      add(InvoicesFetchE(
        params: (state as InvoicesLoadedS).params.copyWith(
              sorting: event.type,
              page: currentPage,
            ),
      ));
    }
  }

  FutureOr<void> _applyFilters(
      InvoicesApplyFiltersE event, Emitter<InvoicesState> emit) {
    final dateFrom = DateFormats.yyyyMMdd(
        DateFormat().add_yMd().parse(splitDates(dateRange.text).first));

    final dateTo = DateFormats.yyyyMMdd(
        DateFormat().add_yMd().parse(splitDates(dateRange.text).last));

    final InvoicesListParams params = InvoicesListParams(
      dateFrom: dateFrom,
      dateTo: dateTo,
      address: address.value?.uuid,
      markingStatus: markedStatus.value,
      sorting: sort.value ?? InvoicesSorting.desk,
      isMarking: InvoicesMarkedTypeParser.isMarking(
          marked.value ?? InvoicesMarkedType.none),
    );

    add(InvoicesFetchE(params: params));
  }

  final SuperValidation dateRange = SuperValidation(
    validationFunc: InvoicesValidator.validateDateFrom,
  );

  final SuperValidationEnum<Addresses> address = SuperValidationEnum(
    validateFunc: InvoicesValidator.validateAddress,
  );

  final SuperValidationEnum<InvoicesMarkedType> marked = SuperValidationEnum(
    validateFunc: InvoicesValidator.validateMarked,
  );

  final SuperValidationEnum<String> markedStatus = SuperValidationEnum(
    validateFunc: InvoicesValidator.validateMarkedStatus,
  );

  final SuperValidationEnum<InvoicesSorting> sort = SuperValidationEnum(
    validateFunc: InvoicesValidator.validateSort,
  );

  List<String> splitDates(String date) {
    return date.split(' - ');
  }

  FutureOr<void> _refresh(InvoicesRefreshE event, Emitter<InvoicesState> emit) {
    _initialize();
  }
}
