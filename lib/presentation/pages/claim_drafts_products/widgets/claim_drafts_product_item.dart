import 'package:flutter/material.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/claims/main/entity/claims_entity.dart';
import '../../../../../generated/l10n.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../claims/widgets/card/claim_item_card_title.dart';
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
  var initiallyExpanded = false;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        decoration: _decoration(),
        child: _content(myColors, context),
      ),
    );
  }

  Widget _content(MyThemeData myColors, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kBasePadding,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClaimDraftsProductsItemTitle(
            title: item.productName,
            status: item.seriesName,
          ),
          const SizedBox(height: kPadding),
        ],
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(kBorderRadius),
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
}
