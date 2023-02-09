import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mkk/services/npm/date_time_server.dart';
import 'package:super_validation/text_form_field.dart';
import 'package:mkk/presentation/pages/invoices/invoices_bloc/invoices_bloc.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/time_zone.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../widgets/fields/custom_input_decoration.dart';
import 'package:timezone/standalone.dart' as tz;

class FilterPeriodField extends StatefulWidget {
  final InvoicesBloc bloc;
  final bool? openCalendar;
  const FilterPeriodField({
    Key? key,
    required this.bloc,
    this.openCalendar = false,
  }) : super(key: key);

  @override
  State<FilterPeriodField> createState() => _FilterPeriodFieldState();
}

class _FilterPeriodFieldState extends State<FilterPeriodField> {
  InvoicesBloc get bloc => widget.bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).period,
            style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: kPadding),
        TextFieldSuperValidation(
          superValidation: bloc.dateRange,
          readOnly: true,
          onTap: () async => await _openDateRangePicker(),
          decoration: CustomInputDecoration(
            needOtherFocusColor: true,
            hintText: S.of(context).select_period,
            suffixIcon: SvgPicture.asset(
              'assets/icon/calendar.svg',
              color: MyTheme.of(context).greyIconColor,
            ),
            myColors: MyTheme.of(context),
          ),
        ),
      ],
    );
  }

  Future<void> _openDateRangePicker() async {
    DateTimeRange? dateTimeRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2010),
        lastDate: tz.TZDateTime.from(DateTime.now(), TimeZone.moscow).server,
        currentDate: tz.TZDateTime.from(DateTime.now(), TimeZone.moscow).server,
        initialEntryMode: DatePickerEntryMode.calendarOnly);

    if (dateTimeRange != null) {
      bloc.dateRange.text =
          '${DateFormat('dd.MM.yyyy').format(dateTimeRange.start)} - ${DateFormat('dd.MM.yyyy').format(dateTimeRange.end)}';
      bloc.add(InvoicesApplyFiltersE());
    }
  }
}
