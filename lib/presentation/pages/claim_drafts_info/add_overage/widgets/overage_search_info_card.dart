import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';

class OverageSearchInfoCard extends StatelessWidget {
  const OverageSearchInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimDraftAddOverageBloc, ClaimDraftAddOverageState>(
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, ClaimDraftAddOverageState state) {
    final colors = MyTheme.of(context);
    if (state is ClaimDraftAddOverageProductS) {
      if (state.entity.meta.total > 25) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(kCardPadding),
              decoration: _decoration(colors),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _svgIcon(colors),
                  const SizedBox(width: kPadding),
                  _text(context, state, colors),
                ],
              ),
            ),
          ],
        );
      }
    }
    return const SizedBox.shrink();
  }

  Widget _text(BuildContext context, ClaimDraftAddOverageProductS state,
      MyThemeData colors) {
    return Flexible(
      child: Text(
        S.of(context).search_overage_product_result(
              state.entity.meta.total,
              state.entity.meta.perPage,
            ),
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: colors.whiteColor),
      ),
    );
  }

  Widget _svgIcon(MyThemeData colors) {
    return SvgPicture.asset(
      'assets/icon/info-circle.svg',
      width: 28,
      height: 28,
      color: colors.whiteColor,
    );
  }

  BoxDecoration _decoration(MyThemeData colors) {
    return BoxDecoration(
      color: colors.blueColor,
      borderRadius: BorderRadius.circular(kBorderRadius),
    );
  }
}
