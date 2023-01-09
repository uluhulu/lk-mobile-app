import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mkk/presentation/pages/claims/claims_bloc/claims_bloc.dart';
import 'package:super_validation/text_form_field.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';

class ClaimFilterPeriodField extends StatefulWidget {
  final ClaimsBloc bloc;

  const ClaimFilterPeriodField({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  State<ClaimFilterPeriodField> createState() => _ClaimFilterPeriodFieldState();
}

class _ClaimFilterPeriodFieldState extends State<ClaimFilterPeriodField> {
  ClaimsBloc get bloc => widget.bloc;

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
        lastDate: DateTime.now(),
        //.add(const Duration(days: 365)),
        initialEntryMode: DatePickerEntryMode.calendarOnly);

    if (dateTimeRange != null) {
      bloc.dateRange.text =
          '${DateFormat('dd.MM.yyyy').format(dateTimeRange.start)} - ${DateFormat('dd.MM.yyyy').format(dateTimeRange.end)}';
      bloc.add(ClaimsApplyFiltersE());
    }
  }
}
