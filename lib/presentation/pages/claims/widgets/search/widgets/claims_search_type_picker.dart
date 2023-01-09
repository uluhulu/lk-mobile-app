import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../domain/enums/claims/claims_search_type.dart';
import '../../../../../../domain/enums/invoices/invoices_search_type.dart';
import '../../../claims_search_bloc/claims_search_bloc.dart';

class ClaimsSearchTypePicker extends StatelessWidget {
  const ClaimsSearchTypePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: _separator,
      itemCount: ClaimsSearchType.values.length,
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final bloc = context.read<ClaimsSearchBloc>();
    return SuperValidationEnumBuilder<ClaimsSearchType?>(
      superValidation: bloc.type,
      builder: (context, value) {
        return RadioListTile<ClaimsSearchType>(
          contentPadding: const EdgeInsets.all(0),
          visualDensity: VisualDensity.comfortable,
          activeColor: MyTheme.of(context).primaryButtonColor,
          controlAffinity: ListTileControlAffinity.trailing,
          value: ClaimsSearchType.values[index],
          groupValue: value ?? ClaimsSearchType.number,
          title: InvoicesSearchType.values[index].claimName,
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
