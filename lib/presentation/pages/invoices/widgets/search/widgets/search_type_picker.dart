import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../domain/enums/invoices/invoices_search_type.dart';
import '../../../invoices_search_bloc/invoices_search_bloc.dart';

class InvoicesSearchTypePicker extends StatelessWidget {
  const InvoicesSearchTypePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: _separator,
      itemCount: InvoicesSearchType.values.length,
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final bloc = context.read<InvoicesSearchBloc>();
    return SuperValidationEnumBuilder<InvoicesSearchType?>(
      superValidation: bloc.type,
      builder: (context, value) {
        return RadioListTile<InvoicesSearchType>(
          contentPadding: const EdgeInsets.all(0),
          visualDensity: VisualDensity.comfortable,
          activeColor: MyTheme.of(context).primaryButtonColor,
          controlAffinity: ListTileControlAffinity.trailing,
          value: InvoicesSearchType.values[index],
          groupValue: value ?? InvoicesSearchType.invoice,
          title: InvoicesSearchType.values[index].name,
          onChanged: (value) {
            if (value != null) {
              bloc.type.value = value;
            }
          },
        );
      },
    );
  }

  Widget _separator(BuildContext context, int index) => const Divider(
        indent: kBasePadding,
        endIndent: kBasePadding,
      );
}
