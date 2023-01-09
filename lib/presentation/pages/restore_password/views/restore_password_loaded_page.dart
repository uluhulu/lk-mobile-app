import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/restore_password/restore_password_bloc/restore_password_bloc.dart';
import 'package:super_validation/validation_builder.dart';

import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../../authorization/widgets/fields/login_text_field.dart';
import '../widgets/restore_password_info.dart';
import '../widgets/restore_password_region_company_field.dart';

class RestorePasswordLoadedPage extends StatelessWidget {
  const RestorePasswordLoadedPage({
    Key? key,
    required this.bloc,
    required this.state,
  }) : super(key: key);

  final RestorePasswordBloc bloc;
  final RestorePasswordLoadedS state;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
          altValidation: bloc.loginValid,
          loginValidation: bloc.login,
        ),
        const SizedBox(height: kPadding * 3),
        Text(
          S.of(context).region_company,
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 12),
        StreamBuilder<int?>(
            stream: bloc.filialValidation.streamValue,
            builder: (context, snapshot) {
              return RestorePasswordRegionCompanyField(
                bloc: bloc,
              );
            }),
        const SizedBox(height: kPadding * 4),
        SuperValidationMultiBuilder(
            superValidation: {
              'login': bloc.login,
              'region': bloc.filialValidation,
            },
            builder: (context, validation, isValid) {
              return PrimaryElevatedButton(
                canPress: isValid,
                onPressed: () {
                  context.read<RestorePasswordBloc>().add(
                        RestorePasswordSendE(),
                      );
                },
                text: S.of(context).send,
              );
            }),
      ],
    );
  }
}
