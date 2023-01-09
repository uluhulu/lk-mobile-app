import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/invoices/invoices_bloc/invoices_bloc.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/invoices/list/entity/invoices_entity.dart';
import 'invoices_filter_empty_field.dart';

class AddressListWidget extends StatefulWidget {
  const AddressListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressListWidget> createState() => _AddressListWidgetState();
}

class _AddressListWidgetState extends State<AddressListWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return BlocBuilder<InvoicesBloc, InvoicesState>(
      builder: (context, state) {
        if (state is InvoicesLoadedS) {
          final addresses = state.data.filter.addresses;
          return addresses.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: kBasePadding * 2,
                          left: kBasePadding,
                          right: kBasePadding,
                          bottom: kBasePadding),
                      child: Text(l10n.delivery_address,
                          style: Theme.of(context).textTheme.headline2),
                    ),
                    Flexible(
                      child: ListView.separated(
                        padding:
                            const EdgeInsets.only(bottom: kBasePadding * 2),
                        shrinkWrap: true,
                        separatorBuilder: _separator,
                        itemCount: addresses.length,
                        itemBuilder: (context, index) =>
                            _itemBuilder(context, index, state),
                      ),
                    )
                  ],
                )
              : const FilterEmptyFieldWidget();
        }
        if (state is InvoicesEmptyS) {
          return const FilterEmptyFieldWidget();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _separator(BuildContext context, int index) => const Divider(
        indent: kBasePadding,
        endIndent: kBasePadding,
      );

  Widget _itemBuilder(BuildContext context, int index, InvoicesLoadedS state) {
    final addresses = state.data.filter.addresses;
    final bloc = context.read<InvoicesBloc>();
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
            onChanged: (value) {
              if (value != null) {
                bloc.address.value = value;
                Navigator.pop(context);
                bloc.add(InvoicesApplyFiltersE());
              }
            },
          );
        });
  }
}
