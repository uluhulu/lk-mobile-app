import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../domain/enums/invoices/invoices_marked_type.dart';
import '../../invoices_bloc/invoices_bloc.dart';

class MarkedListWidget extends StatefulWidget {
  const MarkedListWidget({super.key});

  @override
  State<MarkedListWidget> createState() => _MarkedListWidgetState();
}

class _MarkedListWidgetState extends State<MarkedListWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: kBasePadding * 2,
            left: kBasePadding,
            right: kBasePadding,
            bottom: kBasePadding,
          ),
          child: Text(l10n.marking_item,
              style: Theme.of(context).textTheme.headline2),
        ),
        ListView.separated(
          padding: const EdgeInsets.only(bottom: kBasePadding * 2),
          shrinkWrap: true,
          separatorBuilder: _separator,
          itemCount: InvoicesMarkedType.values.length,
          itemBuilder: _itemBuilder,
        ),
      ],
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final bloc = context.read<InvoicesBloc>();
    return SuperValidationEnumBuilder<InvoicesMarkedType?>(
        superValidation: bloc.marked,
        builder: (context, value) {
          return RadioListTile<InvoicesMarkedType>(
            visualDensity: VisualDensity.comfortable,
            activeColor: MyTheme.of(context).primaryButtonColor,
            controlAffinity: ListTileControlAffinity.trailing,
            value: InvoicesMarkedType.values[index],
            groupValue: value ?? InvoicesMarkedType.none,
            title: Text(InvoicesMarkedType.values[index].name),
            onChanged: (value) {
              if (value != null) {
                bloc.marked.value = value;
                Navigator.pop(context);
                bloc.add(InvoicesApplyFiltersE());
              }
            },
          );
        });
  }

  Widget _separator(BuildContext context, int index) => const Divider(
        indent: kBasePadding,
        endIndent: kBasePadding,
      );
}


//  return BlocBuilder<InvoicesBloc, InvoicesState>(
//       builder: (context, state) {
//         if (state is InvoicesLoadedS) {
//           final filters = state.data.filter.addresses;
//           return filters.isNotEmpty
//               ? Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: kBasePadding * 2,
//                         left: kBasePadding,
//                         right: kBasePadding,
//                       ),
//                       child: Text(l10n.marking_item,
//                           style: Theme.of(context).textTheme.headline2),
//                     ),
//                     ListView.separated(
//                       padding: const EdgeInsets.only(
//                           top: kBasePadding, bottom: kBasePadding * 2),
//                       shrinkWrap: true,
//                       separatorBuilder: _separator,
//                       itemCount: InvoicesMarkedType.values.length,
//                       itemBuilder: _itemBuilder,
//                     ),
//                   ],
//                 )
//               : const FilterEmptyFieldWidget();
//         } else {
//           return const FilterEmptyFieldWidget();
//         }
//       },
//     );