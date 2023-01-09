import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/config/app_routes.dart';
import 'package:mkk/presentation/pages/claim_drafts_list/claim_drafts_list_bloc/claim_drafts_list_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_list/widgets/card/claim_drafts_item_card.dart';

import '../../../../core/help/navigation_claims_filter_page_params.dart';
import '../../../../core/help/navigation_route_params.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../widgets/claim_drafts_pagination.dart';
import '../widgets/claim_drafts_sort.dart';

class ClaimDraftsListLoaded extends StatelessWidget {
  final ClaimDraftsListEntity entity;
  const ClaimDraftsListLoaded({
    required this.entity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: _padding(),
          child: ClaimsDraftsSort(data: entity),
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: _separatorBuilder,
            shrinkWrap: true,
            padding: const EdgeInsets.all(kBasePadding),
            itemCount: entity.data.length,
            itemBuilder: _itemBuilder,
          ),
        ),
      ],
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      top: kBasePadding,
      left: kBasePadding,
      bottom: kPadding,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final bloc = context.read<ClaimDraftsListBloc>();
    final item = entity.data[index];
    if (index == entity.data.length - 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClaimDraftsItemCard(
              claim: item,
              onPressed: () {
                _onPressed(context, item.id);
              }),
          const SizedBox(height: kBasePadding),
          ClaimsDraftsPagination(bloc: bloc),
          const SizedBox(height: kBasePadding),
        ],
      );
    }
    return ClaimDraftsItemCard(
        claim: item,
        onPressed: () {
          _onPressed(context, item.id);
        });
  }

  void _onPressed(BuildContext context, int id) {
    final bloc = context.read<ClaimDraftsListBloc>();
    Navigator.of(context).pushNamed(
      AppRoutes.claimDraftsInfo,
      arguments: ClaimsDraftsListPageParams(id: id),
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const SizedBox(height: kBasePadding);
  }
}
