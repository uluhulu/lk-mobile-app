import 'navigation_page_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/not_found/not_found_screen.dart';

/// Доступ к странице
class NavigationPageRoute<T> extends MaterialPageRoute<T> {
  NavigationPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Widget buildContent(BuildContext context) {
    final Widget widget = super.buildContent(context);

    if (widget is NavigationPageAccess) {
      final bool canAccess = (widget as NavigationPageAccess).canAccess(
        context,
        settings,
      );

      if (canAccess == false) {
        return const NotFoundScreen();
      }
    }
    return widget;
  }
}
