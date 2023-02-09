import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import 'add_product_item_title.dart';

class AddProductItemList extends StatefulWidget {
  const AddProductItemList({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductItemList> createState() => _AddProductItemListState();
}

class _AddProductItemListState extends State<AddProductItemList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    context.read<ClaimDraftAddProductBloc>().perPage = 25;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftAddProductBloc>();
    return SuperValidationEnumBuilder(
      superValidation: bloc.claimItem,
      builder: (context, value) {
        return BlocBuilder<ClaimDraftAddProductBloc, ClaimDraftAddProductState>(
            builder: (context, state) {
          if (state is ClaimDraftAddProductStartS) {
            return Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: kBasePadding * 5),
                shrinkWrap: true,
                separatorBuilder: _separatorBuilder,
                controller: _scrollController,
                itemCount: state.data.data.length,
                itemBuilder: ((context, index) {
                  final item = state.data.data[index];
                  return RadioListTile<ClaimDraftsProductsData>(
                    contentPadding: const EdgeInsets.all(0),
                    visualDensity: VisualDensity.comfortable,
                    activeColor: MyTheme.of(context).primaryButtonColor,
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: state.data.data[index],
                    groupValue: value,
                    onChanged: (newValue) {
                      bloc.claimItem.value = newValue;
                    },
                    title: AddProductItemTitle(item: item),
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

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      context
          .read<ClaimDraftAddProductBloc>()
          .add(ClaimDraftAddProductPaginationE());
    }
  }
}
