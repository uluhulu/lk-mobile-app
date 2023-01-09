import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_list/claim_drafts_list_bloc/claim_drafts_list_bloc.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../data/api/claim_drafts/list/params/claim_drafts_list_params.dart';

class ClaimDraftsSortContent extends StatelessWidget {
  const ClaimDraftsSortContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: _padding(),
          child: Text(
            l10n.sort_by_date,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        BlocBuilder<ClaimDraftsListBloc, ClaimDraftsListState>(
          builder: (context, state) {
            late ClaimDraftsListSorting sortType;
            if (state is ClaimDraftsListLoadedS) {
              sortType = state.sorting;
            } else {
              sortType = ClaimDraftsListSorting.desk;
            }
            return ListView.separated(
                separatorBuilder: _separatorBuilder,
                itemCount: ClaimDraftsListSorting.values.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RadioListTile<ClaimDraftsListSorting>(
                    visualDensity: VisualDensity.comfortable,
                    activeColor: MyTheme.of(context).primaryButtonColor,
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: index == 0
                        ? ClaimDraftsListSorting.desk
                        : ClaimDraftsListSorting.asc,
                    groupValue: sortType,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ClaimDraftsListBloc>().add(
                              ClaimDraftsListFetchE(
                                params: ClaimDraftsListParams(sorting: value),
                              ),
                            );
                        Navigator.of(context).pop();
                      }
                    },
                    title: Text(
                      index == 0 ? l10n.new_first : l10n.old_first,
                    ),
                  );
                });
          },
        ),
      ],
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      right: kBasePadding,
      top: kBasePadding * 2,
      left: kBasePadding,
      bottom: kBasePadding,
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const Divider(
      indent: kBasePadding,
      endIndent: kBasePadding,
    );
  }
}

 // contentPadding: index == 1
                    //     ? const EdgeInsets.only(
                    //         bottom: kBasePadding,
                    //         right: kBasePadding,
                    //         left: kBasePadding,
                    //       )
                    //     : null,