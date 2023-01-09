import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';
import 'modal_bottom_sheet_widget.dart';

class BaseBottomSheetWidget {
  final BuildContext context;
  final Widget child;
  final bool isDismissible;
  final bool needMenu;

  BaseBottomSheetWidget({
    required this.context,
    required this.child,
    this.isDismissible = true,
    this.needMenu = true,
  });

  Future<void> show() {
    return showModalBottomSheet<void>(
        isDismissible: isDismissible,
        isScrollControlled: true,
        shape: _shape(),
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.89),
        context: context,
        builder: ((context) {
          return needMenu
              ? Stack(
                  children: [
                    child,
                    const DragHandleWidget(),
                    const ModalBottomSheetIconBackWidget(),
                  ],
                )
              : child;
        }));
  }

  RoundedRectangleBorder _shape() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kSheetBorderRadius),
        topRight: Radius.circular(kSheetBorderRadius),
      ),
    );
  }
}
