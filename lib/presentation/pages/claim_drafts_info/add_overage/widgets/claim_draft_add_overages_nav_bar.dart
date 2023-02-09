import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_draft_add_overage_bloc/claim_draft_add_overage_bloc.dart';
import 'package:mkk/presentation/widgets/buttons/secondary_elevated_button.dart';

import 'package:mkk/services/platform.dart';
import 'package:super_validation/validation_builder.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';

class ClaimDraftAddOveragesNavBar extends StatelessWidget {
  const ClaimDraftAddOveragesNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(kBasePadding),
      decoration: _decoration(),
      child: Column(
        children: [
          Row(
            children: [
              AddOveragesBackButton(myColors: myColors),
              const SizedBox(width: kBasePadding),
              AddOveragesSelectButton(myColors: myColors),
            ],
          ),
          isIOS()
              ? const SizedBox(height: kBasePadding)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.09),
          spreadRadius: 0,
          blurRadius: 20,
          offset: const Offset(0, -1),
        ),
      ],
    );
  }
}

class AddOveragesSelectButton extends StatelessWidget {
  const AddOveragesSelectButton({
    Key? key,
    required this.myColors,
  }) : super(key: key);

  final MyThemeData myColors;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftAddOverageBloc>();
    return Flexible(
      flex: 2,
      child: SuperValidationBuilder(
          superValidation: bloc.series,
          builder: (context, validation, isValid) {
            return PrimaryElevatedButton(
              canPress: isValid,
              onPressed: () {
                bloc.add(ClaimDraftAddOverageSaveE());
              },
              text: S.of(context).select,
            );
          }),
    );
  }
}

class AddOveragesBackButton extends StatelessWidget {
  const AddOveragesBackButton({
    Key? key,
    required this.myColors,
  }) : super(key: key);

  final MyThemeData myColors;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftAddOverageBloc>();
    return Flexible(
      flex: 1,
      child: SecondaryElevatedButton(
        onPressed: () {
          bloc.add(ClaimDraftAddOverageBackE());
        },
        text: S.of(context).back,
      ),
    );
  }
}
