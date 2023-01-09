import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mkk/core/utils/date_format.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/profile/act/params/profile_act_params.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';
import '../act_bloc/act_bloc.dart';

class CreateActPage extends StatefulWidget {
  const CreateActPage({super.key});

  @override
  State<CreateActPage> createState() => _CreateActPageState();
}

class _CreateActPageState extends State<CreateActPage> {
  late TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: kPadding),
      children: [
        Text(
          S.of(context).act_info,
        ),
        const SizedBox(height: kPadding * 3),
        TextField(
          controller: _textController,
          readOnly: true,
          onTap: () async {
            DateTimeRange? dateTimeRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2010),
                lastDate: DateTime.now(),
                initialEntryMode: DatePickerEntryMode.calendarOnly);
            if (dateTimeRange != null) {
              setState(() {
                _textController.text =
                    '${DateFormat('dd.MM.yyyy').format(dateTimeRange.start)} - ${DateFormat('dd.MM.yyyy').format(dateTimeRange.end)}';
              });
            }
          },
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
        const SizedBox(height: kPadding * 3),
        PrimaryElevatedButton(
          canPress: _textController.text.isNotEmpty,
          onPressed: () {
            final ProfileActParams params = ProfileActParams(
                dateFrom: DateFormats.yyyyMMdd(_stringToDateTime(
                  _textController.text.split(' - ')[0],
                )),
                dateTo: DateFormats.yyyyMMdd(_stringToDateTime(
                  _textController.text.split(' - ')[1],
                )));
            context.read<ActBloc>().add(ActRequestE(params: params));
          },
          text: S.of(context).request,
        ),
      ],
    );
  }

  DateTime _stringToDateTime(String date) {
    final List<String> dateList = date.split('.');
    return DateTime(
      int.parse(dateList[2]),
      int.parse(dateList[1]),
      int.parse(dateList[0]),
    );
  }
}
