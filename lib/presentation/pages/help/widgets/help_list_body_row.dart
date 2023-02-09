import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/theme/elements/theme_data.dart';

class HelpListBodyRow extends StatelessWidget {
  final String name;

  const HelpListBodyRow({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      child: Row(
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Spacer(),
          SvgPicture.asset(
            "assets/icon/arrow-right.svg",
            color: MyTheme.of(context).greyIconColor,
            width: 20,
          ),
        ],
      ),
    );
  }
}
