import 'package:flutter/material.dart';

import '../../../../config/theme/elements/theme_data.dart';

class StatusColorHelper {
  static Color getMarketStatusColor(BuildContext context, String marketStatus) {
    switch (marketStatus) {
      case 'Доставлен':
        return MyTheme.of(context).successColor;
      case 'Выкуплен':
        return MyTheme.of(context).successColor;
      case 'Не выкуплен':
        return MyTheme.of(context).orangeColor;
      case 'Отозван':
        return MyTheme.of(context).errorColor;
      case 'Готов к выдаче':
        return MyTheme.of(context).successColor;
      default:
        return MyTheme.of(context).greyIconColor;
    }
  }
}
