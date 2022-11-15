import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';
import 'modal_bottom_sheet_widget.dart';

class BaseBottomSheetWidget {
  final BuildContext context;
  final Widget child;

  BaseBottomSheetWidget({
    required this.context,
    required this.child,
  });

  Future<void> show() {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        shape: _shape(),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        context: context,
        builder: ((context) {
          return Stack(
            children: [
              child,
              const DragHandleWidget(),
              const ModalBottomSheetIconBackWidget(),
            ],
          );
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
