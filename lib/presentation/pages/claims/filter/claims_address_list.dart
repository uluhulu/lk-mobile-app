import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../invoices/widgets/filter/invoices_filter_empty_field.dart';
import '../claims_bloc/claims_bloc.dart';

class ClaimsAddressList extends StatefulWidget {
  const ClaimsAddressList({
    Key? key,
  }) : super(key: key);

  @override
  State<ClaimsAddressList> createState() => _ClaimsAddressListState();
}

class _ClaimsAddressListState extends State<ClaimsAddressList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimsBloc, ClaimsState>(
      builder: (context, state) {
        if (state is ClaimsLoadedS) {
          final addresses = state.data.filter.addresses;
          return addresses.isNotEmpty
              ? _content(context, addresses)
              : FilterEmptyFieldWidget(
                  message: S.of(context).no_claims,
                );
        }
        if (state is ClaimsEmptyS) {
          final addresses = state.data.filter.addresses;
          return addresses.isNotEmpty
              ? _content(context, addresses)
              : FilterEmptyFieldWidget(
                  message: S.of(context).no_claims,
                );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _content(
    BuildContext context,
    List<Addresses> addresses,
  ) {
    final l10n = S.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: _padding(),
          child: Text(
            l10n.delivery_address,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Flexible(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: kBasePadding * 2),
            shrinkWrap: true,
            separatorBuilder: _separator,
            itemCount: addresses.length,
            itemBuilder: (context, index) =>
                _itemBuilder(context, index, addresses),
          ),
        )
      ],
    );
  }

  Widget _itemBuilder(
    BuildContext context,
    int index,
    List<Addresses> addresses,
  ) {
    final bloc = context.read<ClaimsBloc>();
    return SuperValidationEnumBuilder<Addresses?>(
        superValidation: bloc.address,
        builder: (context, value) {
          return RadioListTile<Addresses>(
            visualDensity: VisualDensity.comfortable,
            activeColor: MyTheme.of(context).primaryButtonColor,
            controlAffinity: ListTileControlAffinity.trailing,
            value: addresses[index],
            groupValue: value,
            title: Text(addresses[index].name),
            onChanged: (newValue) {
              if (newValue != null) {
                bloc.address.value = newValue;
                Navigator.pop(context);
                bloc.add(ClaimsApplyFiltersE());
              }
            },
          );
        });
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
        top: kBasePadding * 2,
        left: kBasePadding,
        right: kBasePadding,
        bottom: kBasePadding);
  }

  Widget _separator(BuildContext context, int index) => const Divider(
        indent: kBasePadding,
        endIndent: kBasePadding,
      );
}
