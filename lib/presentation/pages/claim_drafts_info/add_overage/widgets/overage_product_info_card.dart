import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mkk/generated/l10n.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/claim_draft_overages/find_overages/entity/claim_drafts_find_overages_entity.dart';
import '../../../../widgets/ui/helpers/widget_or_null_column_helper.dart';

class OverageProductInfoCard extends StatelessWidget {
  const OverageProductInfoCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ClaimDraftFindOverageData product;

  @override
  Widget build(BuildContext context) {
    final colors = MyTheme.of(context);
    return SizedBox(
      width: double.infinity,
      child: DottedBorder(
        radius: const Radius.circular(kBorderRadius),
        color: colors.spaceGrey,
        dashPattern: const [2, 2],
        padding: _padding(),
        borderType: BorderType.RRect,
        child: _content(context),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetOrNullColumnHelper(
          title: S.of(context).overage_product_name,
          needPadding: false,
          needColumnPadding: false,
          valueStyle: Theme.of(context).textTheme.headline3,
          value: product.name,
        ),
        const SizedBox(height: kCardPadding),
        WidgetOrNullColumnHelper(
          title: S.of(context).manufacturer,
          needPadding: false,
          needColumnPadding: false,
          valueStyle: Theme.of(context).textTheme.headline3,
          value: product.manufacturer,
        ),
      ],
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.symmetric(
        vertical: kCardPadding, horizontal: kBasePadding);
  }
}
