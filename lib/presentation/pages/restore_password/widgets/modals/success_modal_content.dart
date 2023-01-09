import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';

class SuccessModalContent extends StatelessWidget {
  final String message;
  const SuccessModalContent({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kBasePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icon/tick-circle.svg',
            width: 36,
            height: 36,
            color: MyTheme.of(context).greenColor,
          ),
          const SizedBox(height: kPadding),
          Text(
            S.of(context).password_changed,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: kBasePadding),
          HtmlWidget(
            message,
            textStyle: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: kBasePadding * 3),
          PrimaryElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              text: S.of(context).ok),
        ],
      ),
    );
  }
}
