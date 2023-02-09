import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/config/app_routes.dart';
import 'package:mkk/core/help/navigation_claims_filter_page_params.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/appmetrica/bloc/appmetrica_bloc.dart';
import '../../claim_drafts_products/claim_drafts_products_bloc/claim_drafts_products_bloc.dart';
import '../../invoices_detail/widgets/invoices_detail_button.dart';
import '../claim_drafts_error_cubit/claim_drafts_error_cubit.dart';

class ClaimDraftRowButtons extends StatelessWidget {
  final int draftId;

  const ClaimDraftRowButtons({
    super.key,
    required this.draftId,
  });

  @override
  Widget build(BuildContext context) {
    final addProductBloc = context.read<ClaimDraftAddProductBloc>();
    final addOveragesBloc = context.read<ClaimDraftAddOverageBloc>();
    final myColors = MyTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(kBasePadding),
      color: myColors.greyContainerColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _selectProductButton(addProductBloc, myColors),
          _addOveragesButton(context, addOveragesBloc),
        ],
      ),
    );
  }

  Widget _addOveragesButton(
    BuildContext context,
    ClaimDraftAddOverageBloc addOveragesBloc,
  ) {
    return BlocBuilder<AppMetricaBloc, AppMetricaState>(
      builder: (context, state) {
        final appMetricaBloc = BlocProvider.of<AppMetricaBloc>(context);
        return DetailButton(
          iconPath: 'assets/icon/box-add.svg',
          title: S.of(context).add_excess,
          iconColor: Colors.yellow.shade700,
          onTap: () {
            _addOverages(context, addOveragesBloc);
            appMetricaBloc.add(
              AppmetricaOnEventE(
                eventName:
                    "Черновики претензий ${S.of(context).button_on_pressed} ${S.of(context).add_excess}",
              ),
            );
          },
        );
      },
    );
  }

  Widget _selectProductButton(
    ClaimDraftAddProductBloc bloc,
    MyThemeData myColors,
  ) {
    return BlocBuilder<ClaimDraftsProductsBloc, ClaimDraftsProductsState>(
      builder: (context, state) {
        if (state is ClaimDraftsProductsLoadedS) {
          return state.limit.data.isNotEmpty
              ? _activeButton(context, myColors, bloc)
              : _disableButton(context, myColors);
        }
        if (state is ClaimDraftsProductsEmptyS) {
          return _activeButton(context, myColors, bloc);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _activeButton(
    BuildContext context,
    MyThemeData myColors,
    ClaimDraftAddProductBloc bloc,
  ) {
    return DetailButton(
      iconPath: 'assets/icon/clipboard-text.svg',
      title: S.of(context).select_product_one,
      iconColor: myColors.deepBlueCardColor,
      onTap: () {
        _addProduct(context, bloc);
      },
    );
  }

  Widget _disableButton(BuildContext context, MyThemeData myColors) {
    return DetailButton(
      iconPath: 'assets/icon/clipboard-text.svg',
      title: S.of(context).select_product_one,
      iconColor: myColors.greyIconColor,
      textColor: myColors.greyIconColor,
      onTap: () {},
    );
  }

  void _addProduct(BuildContext context, ClaimDraftAddProductBloc bloc) {
    Navigator.of(context).pushNamed(
      AppRoutes.claimAddItem,
      arguments: ClaimsDraftsAddItemParams(
        id: draftId,
        bloc: bloc,
      ),
    );
    bloc.add(ClaimDraftAddProductStartE());
  }

  void _addOverages(
      BuildContext context, ClaimDraftAddOverageBloc addOveragesBloc) {
    final productsBloc = context.read<ClaimDraftsProductsBloc>();
    final claimErrorBloc = context.read<ClaimDraftsErrorCubit>();
    Navigator.of(context).pushNamed(
      AppRoutes.claimDraftAddOverages,
      arguments: ClaimDraftAddOveragesParams(
        id: draftId,
        bloc: addOveragesBloc,
        productsBloc: productsBloc,
        claimErrorBloc: claimErrorBloc,
      ),
    );
  }
}
