import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../login_bloc/login_bloc.dart';
import '../widgets/fields/filial_text_field.dart';
import '../widgets/fields/login_text_field.dart';
import '../widgets/modal_register_info_widget.dart';
import '../widgets/fields/password_text_field.dart';
import '../widgets/restore_password_button.dart';

class LoginLoadedContent extends StatelessWidget {
  final LoginLoadedS state;
  const LoginLoadedContent({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(kBasePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/images/auth_logo.svg',
                  width: 141,
                  height: 31,
                ),
              ),
              const Spacer(flex: 4),
              Text(
                S.of(context).login,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 12),
              LoginTextField(
                altValidation: loginBloc.loginValid,
                loginValidation: loginBloc.loginValidation,
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).password,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 12),
              PasswordTextField(
                obscureText: true,
                passwordValidation: loginBloc.passwordValidation,
              ),
              const SizedBox(height: 12),
              const RestorePasswordButton(),
              const SizedBox(height: 24),
              Text(
                S.of(context).region_company,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 12),
              const FilialTextField(),
              const SizedBox(height: 32),
              SuperValidationMultiBuilder(
                superValidation: {
                  'login': loginBloc.loginValidation,
                  'password': loginBloc.passwordValidation,
                  'filial': loginBloc.filialValidation,
                },
                builder: (context, validation, isValid) {
                  return PrimaryElevatedButton(
                    canPress: isValid,
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginEnterE());
                    },
                    text: S.of(context).enter,
                  );
                },
              ),
              const Spacer(flex: 4),
              const Center(
                child: ModalRegisterInfoWidget(),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
