import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/widgets/text/text_with_copy.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/claim_draft_overages/find_overages/entity/claim_drafts_find_overages_entity.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/error/app_error_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';

class ClaimDraftAddOverageProductsList extends StatelessWidget {
  const ClaimDraftAddOverageProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftAddOverageBloc>();
    return BlocBuilder<ClaimDraftAddOverageBloc, ClaimDraftAddOverageState>(
      builder: (context, state) {
        // if (state is ClaimDraftAddOverageLoadingS) {
        //   return const LoadingWidget();
        // }
        if (state is ClaimDraftAddOverageSearchErrorS) {
          return AppBaseErrorWidget(
            callback: () => bloc.add(ClaimDraftAddOverageInitializeE()),
          );
        }
        if (state is ClaimDraftAddOverageProductS) {
          if (state.entity.data.isNotEmpty) {
            return ListView.separated(
              padding: const EdgeInsets.only(bottom: kBasePadding * 4),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: _separator,
              itemCount: state.entity.data.length,
              itemBuilder: (context, index) =>
                  _itemBuilder(context, index, state),
            );
          } else {
            return Center(
              child: Text(
                S.of(context).overage_search_not_found,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _itemBuilder(
      BuildContext context, int index, ClaimDraftAddOverageProductS state) {
    final bloc = context.read<ClaimDraftAddOverageBloc>();
    final myColors = MyTheme.of(context);
    return SuperValidationEnumBuilder<ClaimDraftFindOverageData>(
      superValidation: bloc.product,
      builder: (context, value) {
        return RadioListTile<ClaimDraftFindOverageData>(
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.comfortable,
          activeColor: MyTheme.of(context).primaryButtonColor,
          controlAffinity: ListTileControlAffinity.trailing,
          value: state.entity.data[index],
          groupValue: value,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWithCopy(state.entity.data[index].name,
                  style: Theme.of(context).textTheme.headline3),
              const SizedBox(height: kPadding / 2),
              Text(S.of(context).manufacturer,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: myColors.spaceGrey)),
              TextWithCopy(state.entity.data[index].manufacturer,
                  style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
          onChanged: (newValue) {
            if (newValue != null) {
              bloc.product.value = newValue;
            }
          },
        );
      },
    );
  }

  Widget _separator(BuildContext context, int index) => const Divider(
        indent: kBasePadding,
        endIndent: kBasePadding,
      );
}
