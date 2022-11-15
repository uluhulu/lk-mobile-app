import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class PinCodeSubTitleWidget extends StatelessWidget {
  const PinCodeSubTitleWidget({
    Key? key,
    required this.subtitle,
  }) : super(key: key);

  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kPadding),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Text(
          subtitle ?? '',
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
