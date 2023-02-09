import 'package:flutter/material.dart';
import 'package:mkk/presentation/pages/help_detail/views/help_detail_loaded.dart';

import '../../../../data/api/help/entity/help_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/scaffold/screen_view.dart';

class HelpDetailPageProvider extends StatelessWidget {
  final Content content;
  final String helpTitle;
  List<Content>? otherContentItems;

  HelpDetailPageProvider({
    Key? key,
    required this.content,
    required this.helpTitle,
    this.otherContentItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenView(
      context: context,
      needPadding: false,
      title: S.of(context).help,
      child: HelpDetailContent(
        content: content,
        helpTitle: helpTitle,
        otherContentItems: otherContentItems,
      ),
    );
  }
}

class HelpDetailContent extends StatelessWidget {
  final Content content;
  final String helpTitle;
  List<Content>? otherContentItems;

  HelpDetailContent({
    Key? key,
    required this.content,
    required this.helpTitle,
    this.otherContentItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HelpDetailLoaded(
        htmlContent: content.content ?? "",
        title: content.name ?? "",
        helpTitle: helpTitle,
        otherContentItems: otherContentItems);
  }
}

