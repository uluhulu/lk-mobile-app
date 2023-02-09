import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/create_claim/widgets/create_claim_search_field.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';
import '../../../../widgets/fields/search_clear_text.dart';
import '../../../../widgets/scaffold/screen_view.dart';
import '../../claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import '../../widgets/add_product/add_product_item_list.dart';

class AddProductStartPage extends StatelessWidget {
  final ClaimDraftsProductsEntity entity;
  const AddProductStartPage({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftAddProductBloc>();
    return SafeArea(
      top: false,
      right: false,
      left: false,
      child: ScreenView(
        context: context,
        title: S.of(context).claim_draft,
        floatingActionButton: _navBarButton(bloc),
        child: const AddProductStartContent(),
      ),
    );
  }

  Widget _navBarButton(ClaimDraftAddProductBloc bloc) {
    return SuperValidationBuilder(
        superValidation: bloc.claimItem,
        builder: (context, validation, isValid) {
          return PrimaryElevatedButton(
            canPress:
                context.read<ClaimDraftAddProductBloc>().claimItem.isValid,
            btnWidth: 200,
            onPressed: () {
              bloc.add(ClaimDraftAddProductE());
              // bloc.add(ClaimDraftAddProductSaveE());
            },
            text: S.of(context).apply,
          );
        });
  }
}

class AddProductStartContent extends StatelessWidget {
  const AddProductStartContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    final bloc = context.read<ClaimDraftAddProductBloc>();
    final height = MediaQuery.of(context).size.height;
    if (height < 540) {
      return _lowHeightScreen(context, bloc, myColors);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(context),
          const SizedBox(height: kPadding),
          _subtitleInfo(myColors, context),
          const SizedBox(height: kPadding * 3),
          CreateClaimSearchField(
            scrollPadding: const EdgeInsets.only(bottom: 100),
            searchValidation: bloc.search,
            suffixIcon: _clearText(bloc, myColors),
          ),
          const SizedBox(height: kPadding * 3),
          const AddProductItemList(),
        ],
      );
    }
  }

  Widget _lowHeightScreen(BuildContext context, ClaimDraftAddProductBloc bloc,
      MyThemeData myColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _title(context),
                const SizedBox(height: kPadding),
                _subtitleInfo(myColors, context),
                const SizedBox(height: kPadding * 3),
                CreateClaimSearchField(
                  scrollPadding: const EdgeInsets.only(bottom: 100),
                  searchValidation: bloc.search,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: kPadding * 3),
        const AddProductItemList(),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kPadding),
      child: Text(
        S.of(context).select_product,
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
            S.of(context).select_one_product,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: myColors.blueColor),
          ),
        ),
      ],
    );
  }

  Widget _clearText(ClaimDraftAddProductBloc bloc, MyThemeData colors) {
    return SearchClearText(
      stream: bloc.search.stream,
      initialize: () => bloc.add(ClaimDraftInitializeE()),
      clear: () => bloc.search.clear(),
    );
  }
}
