import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../invoices/widgets/filter/invoices_filter_empty_field.dart';

class AddProductClaimTypeList extends StatefulWidget {
  final Map<String, String> claimTypeData;
  const AddProductClaimTypeList({
    Key? key,
    required this.claimTypeData,
  }) : super(key: key);

  @override
  State<AddProductClaimTypeList> createState() =>
      _AddProductClaimTypeListState();
}

class _AddProductClaimTypeListState extends State<AddProductClaimTypeList> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return BlocBuilder<ClaimDraftAddProductBloc, ClaimDraftAddProductState>(
      builder: (context, state) {
        if (state is ClaimDraftAddProductS) {
          final claimTypes = state.product.possibleClaimTypes;
          return claimTypes?.isNotEmpty ?? false
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: _padding(),
                      child: Text(
                        'Тип претензии',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Flexible(
                      child: ListView.separated(
                        padding:
                            const EdgeInsets.only(bottom: kBasePadding * 2),
                        shrinkWrap: true,
                        separatorBuilder: _separator,
                        itemCount: widget.claimTypeData.values.toList().length,
                        itemBuilder: (context, index) =>
                            _itemBuilder(context, index, state),
                      ),
                    )
                  ],
                )
              :
              //TODO: переделать
              FilterEmptyFieldWidget(
                  message: S.of(context).no_claims,
                );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _itemBuilder(
      BuildContext context, int index, ClaimDraftAddProductS state) {
    final bloc = context.read<ClaimDraftAddProductBloc>();
    return SuperValidationEnumBuilder<String>(
      superValidation: bloc.claimType,
      builder: (context, value) {
        return RadioListTile<String>(
          visualDensity: VisualDensity.comfortable,
          activeColor: MyTheme.of(context).primaryButtonColor,
          controlAffinity: ListTileControlAffinity.trailing,
          value: widget.claimTypeData.values.toList()[index],
          groupValue: value,
          title: Text(
            widget.claimTypeData.values.toList()[index],
          ),
          onChanged: (value) {
            if (value != null) {
              bloc.claimType.value = value;
              bloc.claimTypeNumber.value =
                  int.tryParse(widget.claimTypeData.keys.toList()[index]);
              Navigator.pop(context);
            }
          },
        );
      },
    );
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
