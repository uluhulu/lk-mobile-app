import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/modal/modal_bottom_sheet_widget.dart';

class ModalRegisterInfoWidget extends StatelessWidget {
  const ModalRegisterInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet<void>(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kSheetBorderRadius),
              topRight: Radius.circular(kSheetBorderRadius),
            )),
            context: context,
            builder: (BuildContext context) {
              return const ModalBottomSheetWidget();
            });
      },
      child: Text(S.of(context).register),
    );
  }
}
