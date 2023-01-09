import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';

import '../../../../config/theme/elements/theme_data.dart';

class InvoicesIsMarkingHelper {
  static Widget isMarking(bool isMark, BuildContext context) {
    if (isMark == false) {
      return Row(
        children: [
          SvgPicture.asset(
            'assets/icon/close-circle.svg',
            width: 17,
            height: 17,
            color: MyTheme.of(context).greyIconColor,
          ),
          const SizedBox(width: 6),
          Text(S.of(context).no, style: Theme.of(context).textTheme.subtitle1),
        ],
      );
    } else {
      return Row(
        children: [
          SvgPicture.asset(
            'assets/icon/tick-circle.svg',
            width: 17,
            height: 17,
            color: MyTheme.of(context).successColor,
          ),
          const SizedBox(width: 6),
          Text(S.of(context).there_is,
              style: Theme.of(context).textTheme.subtitle1),
        ],
      );
    }
  }

  static Widget isMarkingCard(bool isMark, BuildContext context) {
    if (isMark == false) {
      return Container(
        //width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade500,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kBasePadding, vertical: kPadding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/icon/close-circle.svg',
                width: 24,
                height: 24,
                color: MyTheme.of(context).whiteColor,
              ),
              const SizedBox(width: kPadding),
              Flexible(
                child: Text(
                  S.of(context).no_marking_item,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: MyTheme.of(context).whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        //width: double.infinity,
        decoration: BoxDecoration(
          color: MyTheme.of(context).markingStatusCardColor,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kBasePadding, vertical: kPadding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/icon/close-circle.svg',
                width: 24,
                height: 24,
                color: MyTheme.of(context).whiteColor,
              ),
              const SizedBox(width: kPadding),
              Flexible(
                child: Text(
                  S.of(context).contains_marking_item,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: MyTheme.of(context).whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
