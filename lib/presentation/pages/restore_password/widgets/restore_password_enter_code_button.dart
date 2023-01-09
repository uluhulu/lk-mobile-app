import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../restore_password_bloc/restore_password_bloc.dart';

class EnterCodeButton extends StatelessWidget {
  const EnterCodeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RestorePasswordBloc>();
    final myColors = MyTheme.of(context);
    return SuperValidationMultiBuilder(
        superValidation: {'code': bloc.code},
        builder: (context, validation, isValid) {
          return InkWell(
            onTap: () {
              isValid ? bloc.add(RestorePasswordCheckCodeE()) : null;
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isValid
                    ? myColors.primaryButtonColor
                    : Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/icon/arrow_right.svg',
                  color: isValid ? myColors.whiteColor : myColors.greyIconColor,
                ),
              ),
            ),
          );
        });
  }
}
