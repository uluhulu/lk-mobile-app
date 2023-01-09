import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class PinCodeErrorSubTitleWidget extends StatelessWidget {
  const PinCodeErrorSubTitleWidget({
    Key? key,
    required this.errorSubtitle,
  }) : super(key: key);

  final String? errorSubtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kPadding, bottom: kPadding * 2),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Text(
          errorSubtitle ?? '',
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
