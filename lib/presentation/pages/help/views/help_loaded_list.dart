import 'package:flutter/material.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../data/api/help/entity/help_entity.dart';
import 'help_loaded_list_item.dart';

class HelpLoadedList extends StatelessWidget {
  final List<Content> content;

  const HelpLoadedList({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      itemCount: content.length,
      itemBuilder: (context, i) {
        return content[i].child!.isNotEmpty
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: HelpLoadedListItem(
                      content: content[i],
                    ),
                  ),
                  const Align(
                    child: Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Divider(
                      ),
                    ),
                  )
                ],
              )
            : const SizedBox();
      },
    );
  }
}
