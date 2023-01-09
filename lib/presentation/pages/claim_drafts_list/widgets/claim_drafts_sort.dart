import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../data/api/claim_drafts/list/params/claim_drafts_list_params.dart';
import '../claim_drafts_list_bloc/claim_drafts_list_bloc.dart';
import 'claim_drafts_sort_content.dart';

class ClaimsDraftsSort extends StatelessWidget {
  const ClaimsDraftsSort({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ClaimDraftsListEntity data;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftsListBloc>();
    final myColors = MyTheme.of(context);
    final l10n = S.of(context);
    return _sortButton(context, bloc, myColors, l10n);
  }

  Widget _sortButton(
    BuildContext context,
    ClaimDraftsListBloc bloc,
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
                child: BlocProvider.value(
                  value: bloc,
                  child: const ClaimDraftsSortContent(),
                )).show();
          },
          child: _sortButtonText(l10n),
        ),
      ],
    );
  }

  Widget _sortButtonText(S l10n) {
    return Row(
      children: [
        BlocBuilder<ClaimDraftsListBloc, ClaimDraftsListState>(
          builder: (context, state) {
            late ClaimDraftsListSorting sortType;
            if (state is ClaimDraftsListLoadedS) {
              sortType = state.sorting;
            } else {
              sortType = ClaimDraftsListSorting.desk;
            }
            return Text(
                sortType == ClaimDraftsListSorting.desk
                    ? l10n.new_first
                    : l10n.old_first,
                style: Theme.of(context).textTheme.headline3);
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
}
