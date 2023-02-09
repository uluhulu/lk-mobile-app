import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/theme/elements/theme_data.dart';
import '../../../core/utils/constants.dart';

class AttachmentLoadError extends StatelessWidget {
  const AttachmentLoadError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: kBasePadding,
        ),
        SvgPicture.asset(
          "assets/icon/info-circle.svg",
          width: 28,
          color: MyTheme.of(context).redColor,
        ),
        const SizedBox(
          height: kBasePadding / 2,
        ),
        Center(
          child: Text(
            "Не удалось загрузить изображение",
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: MyTheme.of(context).redColor,
                ),
          ),
        ),
        const SizedBox(
          height: kBasePadding,
        ),
      ],
    );
  }
}
