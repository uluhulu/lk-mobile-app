import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';

class DetailButton extends StatelessWidget {
  final String iconPath;
  final String title;
  final Function()? onTap;
  final Color? iconColor;
  final Color? textColor;
  const DetailButton({
    Key? key,
    required this.iconPath,
    required this.title,
    this.onTap,
    this.iconColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    final sizes = MediaQuery.of(context).size;
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width < 322 ? sizes.width * 0.435 : sizes.width * 0.45,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: _decoration(myColors),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              color: iconColor,
              width: width < 322 ? 18 : null,
            ),
            const SizedBox(height: kPadding / 2),
            FittedBox(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: width < 322 ? 11 : 12,
                      color: textColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _decoration(MyThemeData myColors) {
    return BoxDecoration(
      color: myColors.whiteColor,
      borderRadius: BorderRadius.circular(kBorderRadius),
      border: Border.all(color: myColors.greyIconColor.withOpacity(0.25)),
    );
  }
}
