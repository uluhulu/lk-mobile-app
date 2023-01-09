// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:mkk/generated/l10n.dart';

import '../../../../core/utils/constants.dart';
import '../widgets/fields/restore_password_code_text_field.dart';
import '../widgets/restore_password_timer.dart';

class RestorePasswordEnterCode extends StatefulWidget {
  final String? message;
  const RestorePasswordEnterCode({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  State<RestorePasswordEnterCode> createState() =>
      _RestorePasswordEnterCodeState();
}

class _RestorePasswordEnterCodeState extends State<RestorePasswordEnterCode> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return ListView(
      padding: const EdgeInsets.only(top: kPadding),
      children: [
        HtmlWidget(
          widget.message ?? '',
          textStyle:
              Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
        ),
        const SizedBox(height: kPadding),
        Text(
          S.of(context).restore_password_enter_code_info,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
        ),
        const SizedBox(height: kBasePadding * 2),
        const RestorePasswordCodeTextField(),
        const SizedBox(height: kPadding),
        const RestorePasswordTimer(),
      ],
    );
  }
}
