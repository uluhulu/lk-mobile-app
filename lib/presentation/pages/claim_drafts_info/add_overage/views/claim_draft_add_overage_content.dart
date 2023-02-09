import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/fields/search_clear_text.dart';
import '../../../create_claim/widgets/create_claim_search_field.dart';
import '../../claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';
import '../widgets/claim_draft_overage_products_list.dart';
import '../widgets/text_field_content/overage_manufacturer_selector.dart';
import '../widgets/overage_search_info_card.dart';

class ClaimDraftAddOverageContent extends StatelessWidget {
  const ClaimDraftAddOverageContent({
    Key? key,
    required this.bloc,
    required this.id,
  }) : super(key: key);

  final ClaimDraftAddOverageBloc bloc;
  final int id;

  @override
  Widget build(BuildContext context) {
    final colors = MyTheme.of(context);
    return ListView(
      children: [
        _title(context),
        const SizedBox(height: kPadding),
        _subtitleInfo(colors, context),
        const SizedBox(height: kPadding * 3),
        CreateClaimSearchField(
          searchValidation: bloc.search,
          suffixIcon: _clearText(bloc, colors),
        ),
        const SizedBox(height: kPadding * 3),
        Text(S.of(context).manufacturer,
            style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: kPadding),
        OverageManufacturerSelector(bloc: bloc),
        const SizedBox(height: kPadding * 3),
        const OverageSearchInfoCard(),
        const SizedBox(height: kPadding * 3),
        const ClaimDraftAddOverageProductsList(),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kPadding),
      child: Text(
        S.of(context).overage_select_product,
        style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 24),
      ),
    );
  }

  Widget _subtitleInfo(
    MyThemeData myColors,
    BuildContext context,
  ) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icon/info-circle.svg',
          width: 24,
          height: 24,
          color: myColors.blueColor,
        ),
        const SizedBox(width: kPadding / 2),
        Flexible(
          child: Text(
            S.of(context).overage_select_product_subtitle,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: myColors.blueColor),
          ),
        ),
      ],
    );
  }

  Widget _clearText(ClaimDraftAddOverageBloc bloc, MyThemeData colors) {
    if (bloc.search.text.isNotEmpty) {
      return _defaultClearText(bloc, colors);
    }
    return SearchClearText(
      stream: bloc.search.stream,
      initialize: () => bloc.add(ClaimDraftAddOverageInitializeE()),
      clear: () => bloc.search.clear(),
    );
  }

  Widget _defaultClearText(ClaimDraftAddOverageBloc bloc, MyThemeData colors) {
    return InkWell(
        onTap: () {
          if (bloc.search.text.length < 3) {
            bloc.search.clear();
          } else {
            bloc.add(ClaimDraftAddOverageInitializeE());
          }
        },
        child: Icon(Icons.clear_rounded, color: colors.spaceGrey));
  }
}
