import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/claims/claims_bloc/claims_bloc.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../invoices/widgets/filter/invoices_filter_empty_field.dart';

class ClaimsStatusList extends StatefulWidget {
  const ClaimsStatusList({
    Key? key,
  }) : super(key: key);

  @override
  State<ClaimsStatusList> createState() => _ClaimsStatusListState();
}

class _ClaimsStatusListState extends State<ClaimsStatusList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimsBloc, ClaimsState>(
      builder: (context, state) {
        if (state is ClaimsLoadedS) {
          final markingStatuses = state.data.filter.statuses;
          if (markingStatuses != null && markingStatuses.isNotEmpty) {
            return _content(context, markingStatuses);
          } else {
            return const FilterEmptyFieldWidget();
          }
        }
        if (state is ClaimsEmptyS) {
          final markingStatuses = state.data.filter.statuses;
          if (markingStatuses != null && markingStatuses.isNotEmpty) {
            return _content(context, markingStatuses);
          } else {
            return const FilterEmptyFieldWidget();
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _content(
    BuildContext context,
    List<String> markingStatuses,
  ) {
    final l10n = S.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: _padding(),
          child: Text(
            l10n.claim_status,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        ListView.separated(
          padding: const EdgeInsets.only(bottom: kBasePadding * 2),
          shrinkWrap: true,
          separatorBuilder: _separator,
          itemCount: markingStatuses.length,
          itemBuilder: (context, index) =>
              _itemBuilder(context, index, markingStatuses),
        )
      ],
    );
  }

  Widget _itemBuilder(
      BuildContext context, int index, List<String> markingStatuses) {
    final bloc = context.read<ClaimsBloc>();
    return SuperValidationEnumBuilder<String>(
        superValidation: bloc.claimStatus,
        builder: (context, value) {
          return RadioListTile<String>(
            visualDensity: VisualDensity.comfortable,
            activeColor: MyTheme.of(context).primaryButtonColor,
            controlAffinity: ListTileControlAffinity.trailing,
            value: markingStatuses[index],
            groupValue: value,
            title: Text(markingStatuses[index]),
            onChanged: (value) {
              if (value != null) {
                bloc.claimStatus.value = value;
                Navigator.pop(context);
                bloc.add(ClaimsApplyFiltersE());
              }
            },
          );
        });
  }

  Widget _separator(BuildContext context, int index) => const Divider(
        indent: kBasePadding,
        endIndent: kBasePadding,
      );

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      top: kBasePadding * 2,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kBasePadding,
    );
  }
}
