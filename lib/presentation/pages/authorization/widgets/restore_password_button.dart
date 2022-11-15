import 'package:flutter/material.dart';

import '../../../../config/app_routes.dart';
import '../../../../generated/l10n.dart';

class RestorePasswordButton extends StatelessWidget {
  const RestorePasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.restorePassword);
            },
            child: Text(
              S.of(context).forgot_password,
            )),
      ],
    );
  }
}
