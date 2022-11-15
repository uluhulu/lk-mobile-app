import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/restore_password/restore_password_bloc/restore_password_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../../authorization/widgets/login_text_field.dart';
import '../widgets/restore_password_info.dart';
import '../widgets/restore_password_region_company_field.dart';

class RestorePasswordLoadedPage extends StatelessWidget {
  const RestorePasswordLoadedPage({
    Key? key,
    required TextEditingController loginController,
    required this.bloc,
    required this.companyId,
    required this.state,
  })  : _loginController = loginController,
        super(key: key);

  final TextEditingController _loginController;
  final RestorePasswordBloc bloc;
  final RestorePasswordLoadedS state;
  final int companyId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kPadding),
        const RestorePasswordInfo(),
        const SizedBox(height: kPadding * 4),
        Text(
          S.of(context).login,
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 12),
        LoginTextField(
          controller: _loginController,
        ),
        const SizedBox(height: kPadding * 3),
        Text(
          S.of(context).region_company,
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 12),
        RestorePasswordRegionCompanyField(bloc: bloc, state: state),
        const SizedBox(height: kPadding * 4),
        PrimaryElevatedButton(
          onPressed: () {
            context.read<RestorePasswordBloc>().add(RestorePasswordSendE(
                filial: companyId, login: _loginController.text));
          },
          text: S.of(context).send,
        ),
      ],
    );
  }
}
