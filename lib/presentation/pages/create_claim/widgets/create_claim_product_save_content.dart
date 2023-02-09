import 'package:flutter/material.dart';
import 'package:super_validation/super_validation_string.dart';
import 'package:super_validation/validation_builder.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';

class CreateClaimProductSaveContent extends StatelessWidget {
  final SuperValidation validation;
  final VoidCallback onSaved;
  final VoidCallback onCanceled;

  const CreateClaimProductSaveContent({
    super.key,
    required this.onSaved,
    required this.validation,
    required this.onCanceled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: _padding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).save_changes,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: kBasePadding * 3),
            _saveButton(context),
            const SizedBox(height: kBasePadding),
            _cancelButton(context)
          ],
        ));
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      top: kBasePadding * 2,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kBottomSheetBottomPadding,
    );
  }

  Widget _saveButton(BuildContext context) {
    return SuperValidationBuilder(
        superValidation: validation,
        builder: (context, validation, isValid) {
          return PrimaryElevatedButton(
            canPress: isValid,
            onPressed: () {
              Navigator.of(context).pop();
              onSaved();
            },
            text: S.of(context).save,
          );
        });
  }

  Widget _cancelButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        onCanceled();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: kBasePadding * 2),
        minimumSize: const Size(double.infinity, 40),
      ),
      child: Text(
        S.of(context).dont_saved,
        style: Theme.of(context).textTheme.headline4?.copyWith(
              color: MyTheme.of(context).primaryColor,
            ),
      ),
    );
  }
}
