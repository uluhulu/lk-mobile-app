import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../../widgets/text/text_with_copy.dart';

class IconInfoWidget extends StatelessWidget {
  final String? content;
  final Widget asset;
  final String? subtitle;
  final VoidCallback? onPressed;
  final double? topPadding;
  final double? bottomPadding;
  final String? subtitleText;
  const IconInfoWidget({
    Key? key,
    required this.content,
    required this.asset,
    this.subtitle,
    this.onPressed,
    this.topPadding,
    this.bottomPadding,
    this.subtitleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return content == null ? const SizedBox.shrink() : _content(context);
  }

  Widget _content(BuildContext context) {
    return Padding(
      padding: _padding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          subtitle != null && subtitle!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: kPadding, left: kBasePadding * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        subtitleText ?? '',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(width: 2),
                      TextWithCopy(
                        subtitle!,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  EdgeInsets _padding() {
    return EdgeInsets.only(
      bottom: bottomPadding ?? 0,
      top: topPadding ?? 0,
    );
  }
}
