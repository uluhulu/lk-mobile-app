import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';

class DetailButton extends StatelessWidget {
  final String iconPath;
  final String title;
  final Function()? onTap;
  final Color? iconColor;
  const DetailButton({
    Key? key,
    required this.iconPath,
    required this.title,
    this.onTap,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    final sizes = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: sizes.width * 0.45,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: myColors.whiteColor,
          borderRadius: BorderRadius.circular(kBorderRadius),
          border: Border.all(color: myColors.greyIconColor.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath, color: iconColor),
            const SizedBox(height: kPadding / 2),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
