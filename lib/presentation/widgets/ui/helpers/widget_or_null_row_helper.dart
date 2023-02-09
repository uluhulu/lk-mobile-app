import 'package:flutter/material.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../text/text_with_copy.dart';

class WidgetOrNullRowHelper extends StatelessWidget {
  final String title;
  final String? value;
  final Color? valueColor;
  final bool? isDetail;
  final bool? needValueColor;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const WidgetOrNullRowHelper({
    Key? key,
    required this.title,
    this.value,
    this.valueColor,
    this.isDetail,
    this.needValueColor,
    this.titleStyle,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: kPadding),
        child: Row(
          children: [
            Text(
              title,
              style: titleStyle ??
                  Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 14,
                      color: isDetail == null
                          ? null
                          : MyTheme.of(context).whiteColor),
            ),
            TextWithCopy(
              value!,
              style: valueStyle ??
                  Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: isDetail == null
                            ? valueColor
                            : needValueColor == null
                                ? MyTheme.of(context).whiteColor
                                : valueColor,
                        fontSize: 14,
                      ),
            ),
          ],
        ),
      );
    }
  }
}
