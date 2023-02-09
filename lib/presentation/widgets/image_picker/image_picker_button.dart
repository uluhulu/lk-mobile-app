import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/theme/elements/theme_data.dart';
import '../../../generated/l10n.dart';

class ImagePickerButton extends StatelessWidget {
  final Function() onPressed;

  const ImagePickerButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return SizedBox(
      width: 98,
      height: 98,
      child: CupertinoButton(
        onPressed: onPressed(),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.zero,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              color: myColors.secondaryButtonColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icon/add-square.svg",
                width: 32,
                color: myColors.primaryColor,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                S.of(context).add.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: myColors.primaryColor,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
