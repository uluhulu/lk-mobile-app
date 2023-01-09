import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/claims/claims_search_bloc/claims_search_bloc.dart';
import 'package:mkk/presentation/pages/claims/widgets/search/widgets/claim_search_text_field.dart';
import 'package:mkk/presentation/pages/claims/widgets/search/widgets/claims_search_type_picker.dart';
import '../../../../../../core/utils/constants.dart';

class ClaimsSearchContent extends StatelessWidget {
  const ClaimsSearchContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimsSearchBloc>();
    return ListView(
      padding: const EdgeInsets.only(top: kPadding),
      children: [
        Text(S.of(context).search,
            style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: kBasePadding),
        const ClaimsSearchTypePicker(),
        const SizedBox(height: kBasePadding),
        ClaimSearchTextField(searchValidation: bloc.number),
        const SizedBox(height: kBasePadding),
      ],
    );
  }
}
