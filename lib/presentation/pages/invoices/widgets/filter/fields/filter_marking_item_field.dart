import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:super_validation/super_validation.dart';
import 'package:mkk/presentation/pages/invoices/invoices_bloc/invoices_bloc.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../domain/enums/invoices/invoices_marked_type.dart';
import '../../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../invoices_marked_list.dart';

class FilterMarkingItem extends StatelessWidget {
  final InvoicesBloc bloc;
  const FilterMarkingItem({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).marking_item,
            style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: kPadding),
        SuperValidationEnumBuilder<InvoicesMarkedType?>(
            superValidation: bloc.marked,
            builder: (context, value) {
              return SuperValidationTextFieldListener(
                superValidation: bloc.marked,
                transformer: (value) => value?.name ?? '',
                readOnly: true,
                decoration: CustomInputDecoration(
                  needOtherFocusColor: true,
                  hintText: 'Не выбрано',
                  myColors: MyTheme.of(context),
                  suffixIcon: SvgPicture.asset(
                    'assets/icon/arrow-right.svg',
                    color: MyTheme.of(context).greyIconColor,
                  ),
                ),
                maxLines: 3,
                minLines: 1,
                onTap: () {
                  BaseBottomSheetWidget(
                    context: context,
                    child: BlocProvider.value(
                      value: bloc,
                      child: const MarkedListWidget(),
                    ),
                  ).show();
                },
              );
            }),
      ],
    );
  }
}
