import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/pages/invoices_detail/invoices_add_overage/widgets/text_field_content/invoice_add_overage_manufacturer_list.dart';
import 'package:super_validation/text_field_listener.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../invoice_add_overage_bloc/invoice_add_overage_bloc.dart';

class InvoiceOverageManufacturerTextField extends StatelessWidget {
  const InvoiceOverageManufacturerTextField({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final InvoiceAddOverageBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SuperValidationTextFieldListener(
      superValidation: bloc.manufacturer,
      transformer: (value) => value ?? '',
      maxLines: 5,
      minLines: 1,
      readOnly: true,
      onTap: () {
        BaseBottomSheetWidget(
          context: context,
          child: BlocProvider.value(
            value: bloc,
            child: const InvoiceAddOveragesManufacturerList(),
          ),
        ).show();
      },
      decoration: _decoration(context),
    );
  }

  CustomInputDecoration _decoration(BuildContext context) {
    return CustomInputDecoration(
      needOtherFocusColor: true,
      hintText: S.of(context).not_selected,
      myColors: MyTheme.of(context),
      suffixIcon: SvgPicture.asset(
        'assets/icon/arrow-right.svg',
        color: MyTheme.of(context).greyIconColor,
      ),
    );
  }
}
