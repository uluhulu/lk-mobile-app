import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/add_overage/widgets/overage_product_info_card.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/claim_draft_overages/find_overages/entity/claim_drafts_find_overages_entity.dart';
import '../../../../widgets/fields/search_clear_text.dart';
import '../../../../widgets/scaffold/screen_view.dart';
import '../../../create_claim/widgets/create_claim_search_field.dart';
import '../invoice_add_overage_bloc/invoice_add_overage_bloc.dart';
import '../widgets/invoice_add_overage_nav_bar.dart';
import '../widgets/invoice_add_overage_series_list.dart';

class InvoiceAddOverageSeriesPage extends StatelessWidget {
  final ClaimDraftFindOverageData product;
  const InvoiceAddOverageSeriesPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<InvoiceAddOverageBloc>();
    return _content(context, bloc);
  }

  Widget _content(BuildContext context, InvoiceAddOverageBloc bloc) {
    final colors = MyTheme.of(context);
    return WillPopScope(
      onWillPop: () async {
        bloc.add(InvoiceAddOverageBackE());
        return false;
      },
      child: ScreenView(
        context: context,
        title: S.of(context).claim_draft,
        needPadding: false,
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.only(
                  top: kBasePadding, left: kBasePadding, right: kBasePadding),
              children: [
                _title(context),
                const SizedBox(height: kPadding),
                _subtitleInfo(colors, context),
                const SizedBox(height: kPadding * 3),
                OverageProductInfoCard(product: product),
                const SizedBox(height: kPadding * 3),
                CreateClaimSearchField(
                  searchValidation: bloc.searchSeries,
                  hintText: S.of(context).search,
                  suffixIcon: _clearText(bloc, colors),
                  onChanged: (value) =>
                      bloc.add(InvoiceAddOverageSearchSeriesE()),
                ),
                const SizedBox(height: kPadding),
                Text('${S.of(context).found_serials} ${product.series.length}'),
                const SizedBox(height: kPadding * 3),
                const InvoiceOverageSeriesList(),
              ],
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InvoiceAddOveragesNavBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kPadding),
      child: Text(
        S.of(context).overage_select_serial,
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
            S.of(context).overage_select_serial_subtitle,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: myColors.blueColor),
          ),
        ),
      ],
    );
  }

  Widget _clearText(InvoiceAddOverageBloc bloc, MyThemeData colors) {
    return SearchClearText(
      stream: bloc.searchSeries.stream,
      initialize: () => bloc.add(InvoiceAddOverageClearSeriesE()),
      clear: () => bloc.search.clear(),
    );
  }
}
