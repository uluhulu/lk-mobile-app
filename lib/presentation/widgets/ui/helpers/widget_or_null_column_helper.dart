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
  final TextStyle? valueStyle;
  final TextStyle? titleStyle;
  final bool? titleRightPadding;
  const WidgetOrNullColumnHelper({
    Key? key,
    required this.title,
    this.value,
    this.isDetail,
    this.widgetValue,
    this.needPadding = true,
    this.needColumnPadding = true,
    this.valueStyle,
    this.titleStyle,
    this.titleRightPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    if (value == null || value!.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: needPadding == true
            ? const EdgeInsets.only(top: kBasePadding)
            : EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: titleRightPadding == true
                  ? const EdgeInsets.only(right: kBasePadding * 5)
                  : EdgeInsets.zero,
              child: Text(title,
                  style: titleStyle ??
                      Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: isDetail == null
                              ? null
                              : myColors.deepBlueTextColor)),
            ),
            if (needColumnPadding)
              const SizedBox(height: kPadding / 2)
            else
              const SizedBox.shrink(),
            if (widgetValue != null)
              Row(
                children: [
                  TextWithCopy(value!,
                      style: valueStyle ??
                          Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: isDetail == null
                                  ? null
                                  : myColors.whiteColor)),
                  const SizedBox(width: kPadding),
                  widgetValue!,
                ],
              )
            else
              TextWithCopy(value!,
                  style: valueStyle ??
                      Theme.of(context).textTheme.subtitle1?.copyWith(
                          color:
                              isDetail == null ? null : myColors.whiteColor)),
          ],
        ),
      );
    }
  }
}

class WidgetOrNull extends StatelessWidget {
  final String? value;
  final Widget? widgetValue;
  final Widget nullWidget;
  final Widget child;
  const WidgetOrNull({
    super.key,
    this.value,
    this.widgetValue,
    this.nullWidget = const SizedBox.shrink(),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) {
      return nullWidget;
    } else {
      return child;
    }
  }
}
