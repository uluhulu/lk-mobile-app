import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../../../invoices_bloc/invoices_bloc.dart';
import '../invoices_marked_status_list.dart';

class FilterMarkingStatus extends StatelessWidget {
  final InvoicesBloc bloc;
  final InvoicesEntity data;
  const FilterMarkingStatus({
    Key? key,
    required this.bloc,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).status_marking,
            style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: kPadding),
        SuperValidationEnumBuilder<String>(
            superValidation: bloc.markedStatus,
            builder: (context, value) {
              return SuperValidationTextFieldListener(
                superValidation: bloc.markedStatus,
                transformer: (value) => value ?? '',
                readOnly: true,
                maxLines: 3,
                minLines: 1,
                decoration: CustomInputDecoration(
                  needOtherFocusColor: true,
                  hintText: 'Не выбрано',
                  myColors: MyTheme.of(context),
                  suffixIcon: SvgPicture.asset(
                    'assets/icon/arrow-right.svg',
                    color: MyTheme.of(context).greyIconColor,
                  ),
                ),
                onTap: () {
                  _onPressed(context);
                },
              );
            }),
      ],
    );
  }

  void _onPressed(BuildContext context) {
    BaseBottomSheetWidget(
      context: context,
      child: BlocProvider.value(
        value: bloc,
        child: const MarkedStatusListWidget(),
      ),
    ).show();
  }
}
