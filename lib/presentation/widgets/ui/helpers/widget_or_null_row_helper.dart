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
  const WidgetOrNullRowHelper({
    Key? key,
    required this.title,
    this.value,
    this.valueColor,
    this.isDetail,
    this.needValueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value == null || value!.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(bottom: kPadding),
            child: Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 14,
                      color: isDetail == null
                          ? null
                          : MyTheme.of(context).whiteColor),
                ),
                TextWithCopy(
                  value!,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
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
