import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/generated/l10n.dart';

import '../../../claims_search_bloc/claims_search_bloc.dart';

class ClaimSearchEmptyInfo extends StatelessWidget {
  const ClaimSearchEmptyInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimsSearchBloc>();
    return _errorText(context, bloc);
  }

  Widget _errorText(BuildContext context, ClaimsSearchBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).invoice_search_error,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextSpan(
                  text: 'номеру претензии',
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextSpan(
                  text: S.of(context).claim_search_error_by_number,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextSpan(
                    text: 'Поиск претензии',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: MyTheme.of(context).primaryButtonColor,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pop();
                        //TODO: добавить переход в справку
                      }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
