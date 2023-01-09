import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../../widgets/text/text_with_copy.dart';
import '../../../widgets/text/copy_text_widget.dart';

class TitleInfoWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextStyle? style;
  final VoidCallback? onTap;
  const TitleInfoWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        subtitle == null
            ? Padding(
                padding: const EdgeInsets.only(bottom: kBasePadding),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              )
            : Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              ),
        subtitle == null
            ? const SizedBox.shrink()
            : subtitle == ''
                ? const SizedBox(height: kBasePadding)
                : Padding(
                    padding: const EdgeInsets.only(bottom: kBasePadding),
                    child: CopyTextWidget(
                      onTap: onTap,
                      copyData: subtitle,
                      child: TextWithCopy(
                        subtitle!,
                        style: style ?? Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
      ],
    );
  }
}
