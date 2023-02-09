import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_drafts_error_cubit/claim_drafts_error_cubit.dart';
import 'package:mkk/presentation/widgets/fields/error_icon_widget.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import 'claim_drafts_product_item_title.dart';

class ClaimDraftsProductItem extends StatefulWidget {
  final ClaimDraftsProductsData claim;
  final VoidCallback onPressed;

  const ClaimDraftsProductItem({
    Key? key,
    required this.claim,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<ClaimDraftsProductItem> createState() => _ClaimDraftsProductItemState();
}

class _ClaimDraftsProductItemState extends State<ClaimDraftsProductItem> {
  ClaimDraftsProductsData get item => widget.claim;
  ClaimDraftsErrorCubit get cubit => context.read<ClaimDraftsErrorCubit>();
  var initiallyExpanded = false;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return InkWell(
      onTap: widget.onPressed,
      child: StreamBuilder(
          stream: cubit.itemValidation.streamValue,
          initialData: cubit.itemValidation.value,
          builder: (context, snapshot) {
            bool isValid = true;
            var items = snapshot.data;
            try {
              items!.firstWhere((element) => element == item.id);
              isValid = false;
            } catch (e) {
              isValid = true;
            }
            return Container(
              decoration: _decoration(isValid, myColors),
              child: _content(context, myColors, isValid),
            );
          }),
    );
  }

  Widget _content(BuildContext context, MyThemeData myColors, bool isValid) {
    return Padding(
      padding: _padding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClaimDraftsProductsItemTitle(
            title: item.productName,
            status: item.seriesName,
          ),
          isValid ? const SizedBox() : _errorText(context, myColors),
          const SizedBox(height: kPadding),
        ],
      ),
    );
  }

  Widget _errorText(BuildContext context, MyThemeData myColors) {
    return Padding(
      padding: const EdgeInsets.only(top: kPadding),
      child: Row(
        children: [
          const ErrorIconWidget(),
          Text(
            'Заполните данные',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: myColors.errorColor,
                ),
          )
        ],
      ),
    );
  }

  BoxDecoration _decoration(bool isValid, MyThemeData myColors) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(kBorderRadius),
      border: isValid
          ? null
          : Border.all(
              color: myColors.errorColor,
              width: 1,
            ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.30),
          spreadRadius: 0,
          blurRadius: 2,
          offset: const Offset(0, 1.3),
        ),
      ],
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.symmetric(
      horizontal: kBasePadding,
      vertical: 12,
    );
  }
}
