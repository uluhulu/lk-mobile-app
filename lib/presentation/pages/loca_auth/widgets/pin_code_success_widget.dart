import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';

class PinCodeSuccessWidget extends StatelessWidget {
  const PinCodeSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: _padding(),
      shrinkWrap: true,
      children: [
        const _PinCodeSuccessIconTitle(),
        const SizedBox(height: kBasePadding),
        Text(
          S.of(context).change_code_info,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: kBasePadding * 3),
        PrimaryElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: S.of(context).ok,
        ),
        const SizedBox(height: kPadding * 3),
      ],
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      top: kBasePadding * 2,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kBottomSheetBottomPadding,
    );
  }
}

class _PinCodeSuccessIconTitle extends StatelessWidget {
  const _PinCodeSuccessIconTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icon/tick-circle.svg',
          width: 36,
          height: 36,
          color: myColors.successColor,
        ),
        const SizedBox(height: kPadding),
        Text(
          S.of(context).change_code_success,
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}
