import 'package:flutter/material.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../data/api/help/entity/help_entity.dart';
import '../widgets/help_loaded_list_item_body.dart';
import '../widgets/help_loaded_list_item_header.dart';

class HelpLoadedListItem extends StatelessWidget {
  final Content content;

  const HelpLoadedListItem({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HelpLoadedListItemHeader(title: content.name ?? "", rawSvg: content.rawSwg ?? "",),
        HelpLoadedListItemBody(childContent: content.child ?? [], title: content.name ?? "",),

      ],
    );
  }
}
