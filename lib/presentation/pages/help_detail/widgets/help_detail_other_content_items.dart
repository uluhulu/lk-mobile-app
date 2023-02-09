import 'package:flutter/material.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../data/api/help/entity/help_entity.dart';
import '../../../../generated/l10n.dart';
import '../../help/widgets/help_loaded_list_item_body.dart';
import 'help_detail_bottom_title.dart';

class OtherContentItems extends StatelessWidget {
  final String helpTitle;
  final List<Content> otherContentItems;

  OtherContentItems(
      {Key? key, required this.helpTitle, required this.otherContentItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Divider(
            color: MyTheme.of(context).dividerGreyColor,
            height: 1,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        HelpDetailBottomTitle(
          title: S.of(context).other_questions_in_help_detail(
                helpTitle,
              ),
          fontSize: 16,
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: HelpLoadedListItemBody(
            childContent: otherContentItems,
            title: helpTitle,
          ),
        ),
      ],
    );
  }
}
