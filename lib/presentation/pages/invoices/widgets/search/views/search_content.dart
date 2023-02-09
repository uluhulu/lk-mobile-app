import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/invoices/widgets/search/widgets/search_text_field.dart';
import 'package:mkk/presentation/pages/invoices/widgets/search/widgets/search_type_picker.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../invoices_search_bloc/invoices_search_bloc.dart';

class InvoicesSearchContentWidget extends StatelessWidget {
  const InvoicesSearchContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<InvoicesSearchBloc>();
    return ListView(
      padding: const EdgeInsets.only(top: kPadding),
      children: [
        Text(S.of(context).search,
            style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: kBasePadding),
        const InvoicesSearchTypePicker(),
        const SizedBox(height: kBasePadding),
        SearchTextField(searchValidation: bloc.search),
        const SizedBox(height: kBasePadding * 4),
      ],
    );
  }
}
