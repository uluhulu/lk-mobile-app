import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/constants.dart';

enum ClaimsSearchType {
  number,
}

extension ClaimsSearchTypeX on ClaimsSearchType {
  Widget get name {
    switch (this) {
      case ClaimsSearchType.number:
        return Row(children: [
          SvgPicture.asset(
            'assets/icon/receipt-search.svg',
            width: 24,
            height: 24,
            color: const Color.fromARGB(255, 125, 125, 125),
          ),
          const SizedBox(width: kPadding),
          const Expanded(child: Text('Искать по номеру претензии'))
        ]);
    }
  }
}

class ClaimsSearchTypeParser {
  static String searchBy(ClaimsSearchType type) {
    switch (type) {
      case ClaimsSearchType.number:
        return 'number';
    }
  }

  static String searchByToString(ClaimsSearchType type) {
    switch (type) {
      case ClaimsSearchType.number:
        return 'Искать номер претензии';
    }
  }
}
