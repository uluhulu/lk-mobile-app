import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';
import 'invoices_filter_empty_info.dart';

class FilterEmptyFieldWidget extends StatelessWidget {
  final String? message;
  const FilterEmptyFieldWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Container(
      margin: _padding(),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: kBasePadding),
          SvgPicture.asset(
            'assets/icon/danger.svg',
            width: 40,
            height: 40,
            color: theme.orangeColor,
          ),
          const SizedBox(height: kPadding),
          Text(S.of(context).not_found,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: kBasePadding),
          FilterEmptyInfo(message: message),
          const SizedBox(height: kBasePadding * 2),
          _backButton(context),
        ],
      ),
    );
  }

  PrimaryElevatedButton _backButton(BuildContext context) {
    return PrimaryElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: S.of(context).ok);
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
        left: kBasePadding,
        right: kBasePadding,
        bottom: kBasePadding * 2,
        top: kBasePadding);
  }
}
