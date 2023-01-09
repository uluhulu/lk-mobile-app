import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/claims/claims_bloc/claims_bloc.dart';
import 'package:mkk/presentation/pages/claims/widgets/sorting/claims_sort_content.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import '../../../../../../config/app_routes.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../core/help/navigation_claims_filter_page_params.dart';
import '../../../../../data/api/claims/main/entity/claims_entity.dart';
import '../../../../../data/api/claims/main/params/claims_params.dart';
import '../search/widgets/claim_search_field.dart';

class ClaimsSearchSort extends StatelessWidget {
  const ClaimsSearchSort({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ClaimsEntity data;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimsBloc>();
    final myColors = MyTheme.of(context);
    final l10n = S.of(context);
    return Column(
      children: [
        const ClaimSearchField(),
        const SizedBox(height: kBasePadding),
        _sortButton(context, bloc, myColors, l10n),
      ],
    );
  }

  Widget _sortButton(
    BuildContext context,
    ClaimsBloc bloc,
    MyThemeData myColors,
    S l10n,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            BaseBottomSheetWidget(
                context: context,
                child: ClaimsSortContentProvider(
                  bloc: bloc,
                )).show();
          },
          child: _sortButtonText(l10n),
        ),
        _filterButton(context, bloc, myColors, l10n)
      ],
    );
  }

  Widget _sortButtonText(S l10n) {
    return Row(
      children: [
        BlocBuilder<ClaimsBloc, ClaimsState>(
          builder: (context, state) {
            late ClaimsSorting sortType;
            if (state is ClaimsLoadedS) {
              sortType = state.sortType;
            } else {
              sortType = ClaimsSorting.desk;
            }
            return Text(
              sortType == ClaimsSorting.desk ? l10n.new_first : l10n.old_first,
              style: Theme.of(context).textTheme.headline3,
            );
          },
        ),
        const SizedBox(width: kPadding),
        SvgPicture.asset(
          'assets/icon/arrow.svg',
          width: 24,
          height: 24,
        ),
      ],
    );
  }

  Widget _filterButton(
    BuildContext context,
    ClaimsBloc bloc,
    MyThemeData myColors,
    S l10n,
  ) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () => _filterOnPressed(context, bloc),
          icon: SvgPicture.asset(
            'assets/icon/filter.svg',
            width: 24,
            height: 24,
            color: myColors.primaryButtonColor,
          ),
          label: Text(l10n.filter,
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(color: myColors.primaryButtonColor)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
          decoration: BoxDecoration(
            color: myColors.lightBlueColor,
            borderRadius: BorderRadius.circular(kBorderRadius / 2),
          ),
          child: bloc.getFilterCount() != null
              ? Text(bloc.getFilterCount() ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: myColors.whiteColor))
              : const SizedBox.shrink(),
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
}
