import 'package:flutter/material.dart';

import '../../../../data/api/help/entity/help_entity.dart';
import 'help_loaded_list.dart';

class HelpLoaded extends StatelessWidget {
  final List<Content> content;

  const HelpLoaded({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HelpLoadedList(content: content);
  }
}
