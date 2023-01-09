import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../config/theme/elements/theme_data.dart';

class ClaimsDraftsListEmpty extends StatelessWidget {
  const ClaimsDraftsListEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _bodyPadding(),
      child: Column(
        children: [
          const SizedBox(height: kPadding),
          //TODO: переписать под маленькие экраны и отрефакторить
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: kBasePadding * 4),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 230),
                    child: Lottie.asset(
                      'assets/lottie/searching_animation.json',
                    ),
                  ),
                  const SizedBox(height: kPadding),
                  Text(S.of(context).no_claim_drafts,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: MyTheme.of(context).greyIconColor)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  EdgeInsets _bodyPadding() {
    return const EdgeInsets.only(
      top: kPadding * 3,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kPadding,
    );
  }
}
