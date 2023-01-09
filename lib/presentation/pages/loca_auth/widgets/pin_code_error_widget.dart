import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';

import '../../../../core/utils/constants.dart';

class PinErrorWidget extends StatelessWidget {
  final bool needPadding;
  const PinErrorWidget({
    Key? key,
    required this.hasError,
    required this.incorrectCode,
    this.needPadding = true,
  }) : super(key: key);

  final bool hasError;
  final String incorrectCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: kPadding),
      //margin: needPadding ? const EdgeInsets.only(bottom: kPadding * 3) : null,
      alignment: Alignment.center,
      height: 36,
      child: hasError
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icon/info-circle.svg',
                  color: Theme.of(context).errorColor,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: kPadding),
                Text(
                  incorrectCode,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: Theme.of(context).errorColor,
                      ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
