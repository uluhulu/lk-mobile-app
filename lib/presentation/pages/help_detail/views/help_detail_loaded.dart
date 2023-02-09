import 'package:flutter/material.dart';
import 'package:mkk/presentation/pages/help_detail/widgets/help_detail_body.dart';
import 'package:mkk/presentation/pages/help_detail/widgets/help_detail_bottom_title.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../data/api/help/entity/help_entity.dart';
import '../../../../generated/l10n.dart';
import '../widgets/help_detail_bottom_text.dart';
import '../widgets/help_detail_other_content_items.dart';
import '../widgets/help_detail_title.dart';

class HelpDetailLoaded extends StatelessWidget {
  final String htmlContent;
  final String title;
  final String helpTitle;
  List<Content>? otherContentItems;

  HelpDetailLoaded({
    Key? key,
    required this.htmlContent,
    required this.title,
    required this.helpTitle,
    this.otherContentItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 24,
        ),
        HelpDetailTitle(
          title: title,
        ),
        const SizedBox(
          height: 8,
        ),
        HelpDetailBody(
          htmlContent: htmlContent,
        ),
        Divider(
          color: MyTheme.of(context).dividerGreyColor,
          height: 2,
        ),
        const SizedBox(
          height: 32,
        ),
        HelpDetailBottomTitle(
          title: S.of(context).have_questions,
        ),
        const SizedBox(
          height: 16,
        ),
        const HelpDetailBottomText(),
        const SizedBox(
          height: 32,
        ),
        otherContentItems != null && otherContentItems!.isNotEmpty
            ? OtherContentItems(
                helpTitle: helpTitle,
                otherContentItems: otherContentItems!,
              )
            : const SizedBox(),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
