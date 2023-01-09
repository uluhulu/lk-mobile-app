import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/restore_password/widgets/restore_password_enter_code_button.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../widgets/fields/error_icon_widget.dart';
import '../../restore_password_bloc/restore_password_bloc.dart';

class RestorePasswordCodeTextField extends StatelessWidget {
  const RestorePasswordCodeTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RestorePasswordBloc>();
    final myColors = MyTheme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFieldSuperValidationWithIcon(
            altValidation: bloc.codeValid,
            autovalidateMode: AutovalidateMode.always,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, letterSpacing: -0.5),
            errorIcon: const ErrorIconWidget(),
            superValidation: bloc.code,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: CustomInputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintText: '',
              myColors: myColors,
            ),
          ),
        ),
        const SizedBox(width: kPadding),
        const EnterCodeButton(),
      ],
    );
  }
}
