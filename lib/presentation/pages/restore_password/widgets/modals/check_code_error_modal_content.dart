import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';
import '../../restore_password_bloc/restore_password_bloc.dart';

class CheckCodeErrorModalContent extends StatelessWidget {
  const CheckCodeErrorModalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kBasePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: kBasePadding),
          SvgPicture.asset(
            'assets/icon/tick-circle.svg',
            width: 36,
            height: 36,
            color: MyTheme.of(context).greenColor,
          ),
          const SizedBox(height: kPadding),
          Text(
            S.of(context).password_changed,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: kBasePadding),
          Text(
            S.of(context).cant_use_code,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: kBasePadding * 3),
          PrimaryElevatedButton(
            onPressed: () {
              context.read<RestorePasswordBloc>().add(RestorePasswordSendE());
              Navigator.of(context).pop();
            },
            text: S.of(context).get_new_code,
          ),
          const SizedBox(height: kPadding),
        ],
      ),
    );
  }
}
