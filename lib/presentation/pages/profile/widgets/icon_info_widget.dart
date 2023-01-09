import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../../widgets/text/text_with_copy.dart';
import '../../../widgets/text/copy_text_helper.dart';
import '../../../widgets/text/copy_text_widget.dart';

class IconInfoWidget extends StatelessWidget {
  final String? content;
  final Widget asset;
  final String? subtitle;
  final VoidCallback? onPressed;
  final double? topPadding;
  final double? bottomPadding;
  const IconInfoWidget({
    Key? key,
    required this.content,
    required this.asset,
    this.subtitle,
    this.onPressed,
    this.topPadding,
    this.bottomPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return content == null
        ? const SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.only(
              bottom: bottomPadding ?? 0,
              top: topPadding ?? 0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    asset,
                    const SizedBox(width: kPadding),
                    InkWell(
                      onTap: onPressed,
                      child: TextWithCopy(
                        content ?? '',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
                subtitle != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: kPadding),
                        child: TextWithCopy(
                          subtitle!,
                          style: Theme.of(context).textTheme.subtitle2,
                        ))
                    : const SizedBox.shrink(),
              ],
            ),
          );
  }
}
