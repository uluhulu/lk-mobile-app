import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/data/api/claims/main/entity/claims_entity.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/buttons/primary_elevated_button.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/help/navigation_claims_filter_page_params.dart';
import '../../../../data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../claims_bloc/claims_bloc.dart';
import '../widgets/claims_drafts_widget.dart';
import '../widgets/sorting/claims_search_sort.dart';

class ClaimsEmpty extends StatelessWidget {
  final ClaimsEntity data;
  final ClaimDraftsListEntity? claimDrafts;
  const ClaimsEmpty({
    Key? key,
    required this.data,
    this.claimDrafts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimsBloc>();
    return ListView(
      children: [
        ClaimsDraftsWidget(claims: claimDrafts),
        Padding(
          padding: _bodyPadding(),
          child: Column(
            children: [
              ClaimsSearchSort(data: data),
              const SizedBox(height: kPadding),
              //TODO: переписать под маленькие экраны и отрефакторить
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: kBasePadding * 2),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 230),
                    child: Lottie.asset(
                      'assets/lottie/searching_animation.json',
                    ),
                  ),
                  const SizedBox(height: kPadding),
                  Text(S.of(context).no_data,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: MyTheme.of(context).greyIconColor)),
                  const SizedBox(height: kPadding * 3),
                  PrimaryElevatedButton(
                    btnWidth: 250,
                    onPressed: () {
                      _filterOnPressed(context, bloc);
                    },
                    text: S.of(context).change_period,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _filterOnPressed(BuildContext context, ClaimsBloc bloc) {
    Navigator.of(context).pushNamed(
      AppRoutes.claimsFilters,
      arguments: ClaimsFilterPageParams(data: data, bloc: bloc),
    );
  }

  EdgeInsets _bodyPadding() {
    return const EdgeInsets.only(
      top: kPadding * 3,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kPadding,
    );
  }
}
