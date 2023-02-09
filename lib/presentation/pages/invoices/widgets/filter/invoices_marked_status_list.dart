import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../invoices_bloc/invoices_bloc.dart';
import 'invoices_filter_empty_field.dart';

class MarkedStatusListWidget extends StatefulWidget {
  const MarkedStatusListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MarkedStatusListWidget> createState() => _MarkedStatusListWidgetState();
}

class _MarkedStatusListWidgetState extends State<MarkedStatusListWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return BlocBuilder<InvoicesBloc, InvoicesState>(
      builder: (context, state) {
        if (state is InvoicesLoadedS) {
          final markingStatuses = state.data.filter.markingStatuses;
          if (markingStatuses != null && markingStatuses.isNotEmpty) {
            return _content(l10n, context, markingStatuses);
          } else {
            return const FilterEmptyFieldWidget();
          }
        }
        if (state is InvoicesEmptyS) {
          final markingStatuses = state.data.filter.markingStatuses;
          if (markingStatuses != null && markingStatuses.isNotEmpty) {
            return _content(l10n, context, markingStatuses);
          } else {
            return const FilterEmptyFieldWidget();
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _content(
    S l10n,
    BuildContext context,
    List<String> markingStatuses,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: _padding(),
          child: Text(
            l10n.status_marking,
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
    BuildContext context,
    int index,
    List<String>? markingStatuses,
  ) {
    final bloc = context.read<InvoicesBloc>();
    return SuperValidationEnumBuilder<String>(
        superValidation: bloc.markedStatus,
        builder: (context, value) {
          return RadioListTile<String>(
            visualDensity: VisualDensity.comfortable,
            activeColor: MyTheme.of(context).primaryButtonColor,
            controlAffinity: ListTileControlAffinity.trailing,
            value: markingStatuses?[index] ?? '',
            groupValue: value,
            title: Text(markingStatuses?[index] ?? ''),
            onChanged: (value) {
              if (value != null) {
                bloc.markedStatus.value = value;
                Navigator.pop(context);
                bloc.add(InvoicesApplyFiltersE());
              }
            },
          );
        });
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
        top: kBasePadding * 2,
        left: kBasePadding,
        right: kBasePadding,
        bottom: kBasePadding);
  }

  Widget _separator(BuildContext context, int index) => const Divider(
        indent: kBasePadding,
        endIndent: kBasePadding,
      );
}
