import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/theme/elements/theme_data.dart';
import '../../../core/utils/constants.dart';
import '../buttons/primary_elevated_button.dart';

class ImageLoadErrorContent extends StatelessWidget {
  const ImageLoadErrorContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: _padding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   S.of(context).save_changes,
            //   style: Theme.of(context).textTheme.headline2,
            //   textAlign: TextAlign.start,
            // ),
            // const SizedBox(height: kBasePadding * 3),
            // const SizedBox(height: kBasePadding),
            _cancelButton(context),
            // const SizedBox(height: kBasePadding),
            Center(
              child: Text(
                "Не удалось загрузить файлы",
                style: Theme.of(context).textTheme.headline2?.copyWith(
                    // color: MyTheme.of(context).primaryColor,
                    ),
              ),
            ),
            const SizedBox(height: kBasePadding),
            Center(
              child: Text(
                "Размер загруженного файла не должен превышать 10 Мб. Максимальный суммарный размер всех загружаемых файлов — 32 Мб.",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    // color: MyTheme.of(context).primaryColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: kBasePadding * 2),
            _saveButton(context),
            // Positioned(
            //   top: 17,
            //   child: SvgPicture.asset("assets/icon/info-circle.svg"),
            // )
          ],
        ));
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      // top: kBasePadding * 2,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kBottomSheetBottomPadding,
    );
  }

  Widget _cancelButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: kBasePadding * 2),
        minimumSize: const Size(double.infinity, 40),
      ),
      child: SvgPicture.asset(
        "assets/icon/info-circle.svg",
        width: 40,
        height: 40,
        color: MyTheme.of(context).errorColor,
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return PrimaryElevatedButton(
      canPress: true,
      onPressed: () {
        Navigator.of(context).pop();
      },
      text: "Понятно",
    );
  }
}
