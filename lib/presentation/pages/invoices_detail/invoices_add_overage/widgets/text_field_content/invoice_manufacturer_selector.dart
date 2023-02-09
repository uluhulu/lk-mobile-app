import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../widgets/fields/custom_input_decoration.dart';
import '../../invoice_add_overage_bloc/invoice_add_overage_bloc.dart';
import '../invoice_add_overage_manufac_text_field.dart';

class InvoiceOverageManufacturerSelector extends StatelessWidget {
  const InvoiceOverageManufacturerSelector({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final InvoiceAddOverageBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SuperValidationEnumBuilder<String?>(
        superValidation: bloc.manufacturer,
        builder: (context, value) {
          return BlocBuilder<InvoiceAddOverageBloc, InvoiceAddOverageState>(
            builder: (context, state) {
              if (state is InvoiceAddOverageProductS) {
                if (state.entity.data.isNotEmpty) {
                  return InvoiceOverageManufacturerTextField(bloc: bloc);
                }
              }
              return _inactiveField(context);
            },
          );
        });
  }

  Widget _inactiveField(BuildContext context) {
    return TextField(
      decoration: _overdueDecoration(context),
      readOnly: true,
      enabled: true,
    );
  }

  CustomInputDecoration _overdueDecoration(BuildContext context) {
    return CustomInputDecoration(
      filled: true,
      needOtherFocusColor: true,
      otherEnabledColor: true,
      hintText: bloc.manufacturer.value ?? S.of(context).all_manufacturers,
      //TODO: поменять цвет для работы разных тем
      hintStyle: Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(color: Colors.grey.shade700),
      myColors: MyTheme.of(context),
      suffixIcon: SvgPicture.asset(
        'assets/icon/arrow-right.svg',
        color: MyTheme.of(context).hintColor.withOpacity(0.5),
      ),
    );
  }
}