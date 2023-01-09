import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/invoices/invoices_bloc/invoices_bloc.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../invoices_address_list.dart';

class FilterAddressField extends StatelessWidget {
  final InvoicesBloc bloc;
  final InvoicesEntity data;
  const FilterAddressField({
    Key? key,
    required this.bloc,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).delivery_address,
            style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: kPadding),
        SuperValidationEnumBuilder<Addresses?>(
            superValidation: bloc.address,
            builder: (context, value) {
              return SuperValidationTextFieldListener(
                superValidation: bloc.address,
                transformer: (value) => value?.name ?? '',
                maxLines: 5,
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
                readOnly: true,
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
        child: const AddressListWidget(),
      ),
    ).show();
  }
}
