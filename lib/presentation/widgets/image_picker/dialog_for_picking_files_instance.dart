import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/theme/elements/theme_data.dart';
import '../../../generated/l10n.dart';
import '../../../services/platform.dart';
import '../buttons/base_text_button.dart';
import '../buttons/primary_elevated_button.dart';
import '../modal/modal_bottom_sheet_widget.dart';
import '../../../core/utils/constants.dart';

void showCustomDialog({
  required BuildContext context,
  required Function() addImageFromCamera,
  required Function() addImageFromGallery,
}) {
  isIOS()
      ? showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                S.of(context).cancel,
              ),
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  addImageFromCamera();
                },
                child: Text(
                  S.of(context).make_photo,
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  addImageFromGallery();
                },
                child: Text(
                  S.of(context).choose_photo_from_gallery,
                ),
              ),
            ],
          ),
        )
      :
  showBottomSheet(
    context: context,
    shape: shape(),
    builder: (context) => Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 27,
              ),
              Text(
                S.of(context).add_file,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 40,
              ),
              PrimaryElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  addImageFromCamera();
                },
                icon: SvgPicture.asset("assets/icon/camera.svg"),
                text: S.of(context).make_photo,
              ),
              const SizedBox(
                height: 16,
              ),
              BaseTextButton(
                icon: SvgPicture.asset(
                  "assets/icon/gallery.svg",
                  width: 20,
                  color: MyTheme.of(context).primaryButtonColor,
                ),
                title: S.of(context).open_gallery,
                onPressed: () {
                  Navigator.pop(context);
                  addImageFromGallery();
                },
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
        const DragHandleWidget(),
        const ModalBottomSheetIconBackWidget(),
      ],
    ),
  );
}

RoundedRectangleBorder shape() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(kSheetBorderRadius),
      topRight: Radius.circular(kSheetBorderRadius),
    ),
  );
}
