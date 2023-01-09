import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../text/text_with_copy.dart';

class WidgetOrNullColumnHelper extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? widgetValue;
  final bool? isDetail;
  final bool? needPadding;
  final bool needColumnPadding;
  const WidgetOrNullColumnHelper({
    Key? key,
    required this.title,
    this.value,
    this.isDetail,
    this.widgetValue,
    this.needPadding = true,
    this.needColumnPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return value == null || value!.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: needPadding == true
                ? const EdgeInsets.only(top: kBasePadding)
                : EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: isDetail == null
                            ? null
                            : myColors.deepBlueTextColor)),
                needColumnPadding
                    ? const SizedBox(height: kPadding / 2)
                    : const SizedBox.shrink(),
                widgetValue != null
                    ? Row(
                        children: [
                          TextWithCopy(value!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      color: isDetail == null
                                          ? null
                                          : myColors.whiteColor)),
                          const SizedBox(width: kPadding),
                          widgetValue!,
                        ],
                      )
                    : TextWithCopy(value!,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                                isDetail == null ? null : myColors.whiteColor)),
              ],
            ),
          );
  }
}
