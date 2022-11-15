import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mkk/core/utils/constants.dart';

import '../../../config/theme/elements/theme_data.dart';

class ScreenView extends StatelessWidget {
  final BuildContext context;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget child;
  final String? title;
  final Widget? titleWidget;
  final bool? needPadding;
  const ScreenView({
    required this.context,
    super.key,
    this.title,
    required this.child,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.actions,
    this.leading,
    this.titleWidget,
    this.needPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
      appBar: _appBar(context),
      body: ScreenViewContent(
        needPadding: needPadding,
        child: child,
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: titleWidget ??
          Text(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.white),
          ),
      actions: actions,
      leading: leading,
      toolbarHeight: 60,
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
}

class ScreenViewContent extends StatelessWidget {
  final bool? needPadding;
  final Widget child;
  const ScreenViewContent({
    super.key,
    required this.child,
    this.needPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: needPadding == null ? const EdgeInsets.all(kPadding * 2) : null,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(kBodyRadius),
        ),
        color: MyTheme.of(context).whiteColor,
      ),
      child: child,
    );
  }
}
