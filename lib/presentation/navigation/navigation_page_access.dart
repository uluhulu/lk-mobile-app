import 'package:flutter/widgets.dart';

/// Доступ к странице
mixin NavigationPageAccess {
  bool canAccess(
    BuildContext context,
    RouteSettings? settings,
  );
}
