import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';

class PinCodeSuccessWidget extends StatelessWidget {
  final bool? isFirstEnter;
  const PinCodeSuccessWidget({super.key, this.isFirstEnter});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: _padding(),
      shrinkWrap: true,
      children: [
        _PinCodeSuccessIconTitle(isFirstEnter: isFirstEnter),
        const SizedBox(height: kBasePadding),
        Text(
          isFirstEnter ?? false
              ? S.of(context).change_code_info
              : S.of(context).change_code_info_new,
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
  final bool? isFirstEnter;
  const _PinCodeSuccessIconTitle({
    Key? key,
    this.isFirstEnter,
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
          isFirstEnter ?? false
              ? S.of(context).change_code_success
              : S.of(context).change_code_success_title,
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}
