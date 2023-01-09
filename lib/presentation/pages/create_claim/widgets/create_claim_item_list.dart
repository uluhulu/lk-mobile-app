import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import '../create_claim_bloc/create_claim_bloc.dart';
import 'create_claim_item_title.dart';

class CreateClaimItemList extends StatelessWidget {
  const CreateClaimItemList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateClaimBloc>();
    return SuperValidationEnumBuilder(
      superValidation: bloc.invoiceItem,
      builder: (context, value) {
        return BlocBuilder<CreateClaimBloc, CreateClaimState>(
            builder: (context, state) {
          if (state is CreateClaimStartS) {
            return Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: kBasePadding * 4),
                shrinkWrap: true,
                separatorBuilder: _separatorBuilder,
                itemCount: state.data.data.length,
                itemBuilder: ((context, index) {
                  final item = state.data.data[index];
                  return RadioListTile<InvoicesDetailProductData>(
                    contentPadding: const EdgeInsets.all(0),
                    visualDensity: VisualDensity.comfortable,
                    activeColor: MyTheme.of(context).primaryButtonColor,
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: state.data.data[index],
                    groupValue: value,
                    onChanged: (newValue) {
                      bloc.invoiceItem.value = newValue;
                    },
                    title: CreateClaimItemTitle(item: item),
                  );
                }),
              ),
            );
          }
          return const SizedBox.shrink();
        });
      },
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const Divider(
      height: 48,
    );
  }
}
