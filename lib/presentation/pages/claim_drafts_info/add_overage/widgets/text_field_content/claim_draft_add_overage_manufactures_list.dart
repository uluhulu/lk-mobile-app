import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_validation/enum_builder.dart';

import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../invoices/widgets/filter/invoices_filter_empty_field.dart';
import '../../../claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';

class AddOveragesManufacturerList extends StatelessWidget {
  const AddOveragesManufacturerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return BlocBuilder<ClaimDraftAddOverageBloc, ClaimDraftAddOverageState>(
      builder: (context, state) {
        if (state is ClaimDraftAddOverageProductS) {
          List<String> manufacturerList = ['Все производители'];
          final manufacturers = state.entity.filter.manufacturers;
          if (manufacturers != null) {
            manufacturerList.addAll(manufacturers);
          }
          return manufacturers?.isNotEmpty ?? false
              ? _content(context, l10n, manufacturerList)
              : FilterEmptyFieldWidget(
                  message: l10n.no_manufacturers,
                );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _content(
    BuildContext context,
    S l10n,
    List<String> manufacturerList,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: _padding(),
          child: Text(
            S.of(context).manufacturer,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Flexible(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: kBasePadding * 2),
            shrinkWrap: true,
            separatorBuilder: _separator,
            itemCount: manufacturerList.length,
            itemBuilder: (context, index) =>
                _itemBuilder(context, index, manufacturerList),
          ),
        )
      ],
    );
  }

  Widget _itemBuilder(
      BuildContext context, int index, List<String> manufacturerList) {
    final bloc = context.read<ClaimDraftAddOverageBloc>();
    return SuperValidationEnumBuilder<String>(
      superValidation: bloc.manufacturer,
      builder: (context, value) {
        return RadioListTile<String>(
          visualDensity: VisualDensity.comfortable,
          activeColor: MyTheme.of(context).primaryButtonColor,
          controlAffinity: ListTileControlAffinity.trailing,
          value: manufacturerList[index],
          groupValue: value ?? manufacturerList[0],
          title: Text(manufacturerList[index]),
          onChanged: (newValue) => _onChanged(context, newValue, bloc),
        );
      },
    );
  }

  void _onChanged(
      BuildContext context, String? newValue, ClaimDraftAddOverageBloc bloc) {
    if (newValue != null) {
      bloc.manufacturer.value = newValue;
      bloc.add(ClaimDraftAddOverageFiltersE());
      Navigator.pop(context);
    }
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      top: kBasePadding * 2,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kBasePadding,
    );
  }

  Widget _separator(BuildContext context, int index) => const Divider(
        indent: kBasePadding,
        endIndent: kBasePadding,
      );
}
