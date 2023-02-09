import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/fields/search_clear_text.dart';
import '../../../create_claim/widgets/create_claim_search_field.dart';
import '../invoice_add_overage_bloc/invoice_add_overage_bloc.dart';
import '../widgets/invoice_add_overage_products_list.dart';
import '../widgets/text_field_content/invoice_manufacturer_selector.dart';
import '../widgets/invoice_overage_search_info_card.dart';

class InvoiceAddOverageContent extends StatelessWidget {
  const InvoiceAddOverageContent({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final InvoiceAddOverageBloc bloc;

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
        InvoiceOverageManufacturerSelector(bloc: bloc),
        const SizedBox(height: kPadding * 3),
        const InvoiceOverageSearchInfoCard(),
        const SizedBox(height: kPadding * 3),
        const InvoiceAddOverageProductsList(),
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

  Widget _clearText(InvoiceAddOverageBloc bloc, MyThemeData colors) {
    if (bloc.search.text.isNotEmpty) {
      return _defaultClearText(bloc, colors);
    }
    return SearchClearText(
      stream: bloc.search.stream,
      initialize: () => bloc.add(InvoiceAddOverageInitializeE()),
      clear: () => bloc.search.clear(),
    );
  }

  Widget _defaultClearText(InvoiceAddOverageBloc bloc, MyThemeData colors) {
    return InkWell(
        onTap: () {
          if (bloc.search.text.length < 3) {
            bloc.search.clear();
          } else {
            bloc.add(InvoiceAddOverageInitializeE());
          }
        },
        child: Icon(Icons.clear_rounded, color: colors.spaceGrey));
  }
}
