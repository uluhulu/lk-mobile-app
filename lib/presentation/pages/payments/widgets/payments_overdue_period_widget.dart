import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/text/text_with_copy.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';

class OverduePeriodWidget extends StatelessWidget {
  final int days;
  final String unit;
  const OverduePeriodWidget({
    Key? key,
    required this.days,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    final myTheme = Theme.of(context);
    return Padding(
      padding: _padding(),
      child: OverduePeriodContent(
        myColors: myColors,
        myTheme: myTheme,
        days: days,
        unit: unit,
      ),
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.symmetric(
      horizontal: kBasePadding,
      vertical: kBasePadding * 2,
    );
  }
}

class OverduePeriodContent extends StatelessWidget {
  const OverduePeriodContent({
    Key? key,
    required this.myColors,
    required this.myTheme,
    required this.days,
    required this.unit,
  }) : super(key: key);

  final MyThemeData myColors;
  final ThemeData myTheme;
  final int days;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _icon(),
        const SizedBox(width: kPadding),
        _content(context),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).overdue_period,
          style: myTheme.textTheme.subtitle2?.copyWith(
            color: myColors.errorColor,
          ),
        ),
        TextWithCopy(
          '$days $unit',
          style: myTheme.textTheme.headline5?.copyWith(
            color: myColors.errorColor,
          ),
        ),
      ],
    );
  }

  Widget _icon() {
    return SvgPicture.asset(
      'assets/icon/all-debt.svg',
      width: 26,
      height: 27,
      color: myColors.errorColor,
    );
  }
}
