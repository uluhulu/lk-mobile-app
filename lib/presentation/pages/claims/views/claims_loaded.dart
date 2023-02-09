import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_routes.dart';
import '../../../../core/help/navigation_route_params.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../../../../data/api/claims/main/entity/claims_entity.dart';
import '../claims_bloc/claims_bloc.dart';
import '../widgets/card/claim_item_card.dart';
import '../widgets/claims_drafts_widget.dart';
import '../widgets/claims_pagination.dart';
import '../widgets/sorting/claims_search_sort.dart';

class ClaimsLoaded extends StatefulWidget {
  const ClaimsLoaded({
    Key? key,
    required this.claims,
    required this.numberPages,
    required this.onPageChange,
  }) : super(key: key);

  final ClaimsEntity claims;
  final int numberPages;
  final Function(int index) onPageChange;

  @override
  State<ClaimsLoaded> createState() => _ClaimsLoadedState();
}

class _ClaimsLoadedState extends State<ClaimsLoaded> {
  final ScrollController _scrollController = ScrollController();
  bool isVisible = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ClaimDraftsCountProvider(),
        Container(
          padding: _bodyPadding(),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              isVisible
                  ? const BoxShadow(color: Colors.transparent)
                  : BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    )
            ],
          ),
          child: ClaimsSearchSort(data: widget.claims),
        ),
        const SizedBox(height: kPadding / 2),
        Expanded(
          child: ListView.separated(
            controller: _scrollController,
            separatorBuilder: _separatorBuilder,
            padding: const EdgeInsets.all(kBasePadding),
            itemCount: widget.claims.data.length,
            itemBuilder: _itemBuilder,
          ),
        ),
      ],
    );
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isVisible) {
        setState(() {
          isVisible = false;
        });
      }
    }
    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        _scrollController.offset <= 0) {
      if (!isVisible) {
        setState(() {
          isVisible = true;
        });
      }
    }
  }

  EdgeInsets _bodyPadding() {
    return const EdgeInsets.only(
      top: kPadding * 3,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kPadding,
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const SizedBox(height: kBasePadding);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final bloc = context.read<ClaimsBloc>();
    final item = widget.claims.data[index];
    if (index == widget.claims.data.length - 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClaimItemCard(
            claim: item,
            onPressed: () {
              _onPressed(context, item.uuid);
            },
          ),
          const SizedBox(height: kBasePadding),
          ClaimsPagination(bloc: bloc),
          const SizedBox(height: kBasePadding),
        ],
      );
    }
    return ClaimItemCard(
      claim: item,
      onPressed: () {
        _onPressed(context, item.uuid);
      },
    );
  }

  void _onPressed(BuildContext context, String uuid) {
    Navigator.of(context).pushNamed(AppRoutes.claimDetail,
        arguments: NavigationRouteParams(uuid));
  }
}
