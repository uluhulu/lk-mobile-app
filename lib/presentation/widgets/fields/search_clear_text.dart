import 'package:flutter/material.dart';

import '../../../config/theme/elements/theme_data.dart';

class SearchClearText extends StatelessWidget {
  final Stream<String?> stream;
  final Function() initialize;
  final Function() clear;
  const SearchClearText({
    super.key,
    required this.stream,
    required this.initialize,
    required this.clear,
  });

  @override
  Widget build(BuildContext context) {
    final colors = MyTheme.of(context);
    return StreamBuilder<String?>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.data?.isNotEmpty ?? false) {
            return InkWell(
                onTap: () {
                  if (snapshot.data!.length < 3) {
                    clear();
                  } else {
                    initialize();
                  }
                },
                child: Icon(Icons.clear_rounded, color: colors.spaceGrey));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
