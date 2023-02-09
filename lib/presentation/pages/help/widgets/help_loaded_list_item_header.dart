import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HelpLoadedListItemHeader extends StatelessWidget {
  final String title;
  final String rawSvg;

  const HelpLoadedListItemHeader(
      {Key? key, required this.title, required this.rawSvg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 16),
      child: Row(
        children: [
          rawSvg.isNotEmpty
              ? SvgPicture.string(
                  rawSvg,
                  width: 24,
                )
              : const SizedBox(),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }
}
