import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/presentation/widgets/scaffold/status_bar_settings.dart';

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
  final Widget? floatingActionButton;
  final bool? needLeading;

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
    this.floatingActionButton,
    this.needLeading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      appBar: _appBar(context),
      body: ScreenViewContent(
        context: context,
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
      leading:
          needLeading != null ? ScreenViewLeading(context: context) : leading,
      toolbarHeight: 60,
      centerTitle: true,
      systemOverlayStyle: StatusBarSettings.settings(context),
    );
  }
}

class ScreenViewLeading extends StatelessWidget {
  const ScreenViewLeading({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: SvgPicture.asset(
            'assets/icon/question.svg',
            color: Colors.white,
          ),
        ));
  }
}

class ScreenViewContent extends StatelessWidget {
  final BuildContext context;
  final bool? needPadding;
  final Widget child;
  const ScreenViewContent({
    required this.context,
    super.key,
    required this.child,
    this.needPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(kBodyRadius),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding:
            needPadding == null ? const EdgeInsets.all(kPadding * 2) : null,
        color: MyTheme.of(context).whiteColor,
        child: child,
      ),
    );
  }
}

class SliverScreenView extends StatelessWidget {
  final BuildContext context;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget child;
  final Widget sliverAppBar;
  final String? title;
  final Widget? titleWidget;
  final bool? needPadding;
  final Widget? floatingActionButton;
  final bool? needLeading;
  final ScrollController? controller;
  const SliverScreenView({
    super.key,
    required this.context,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.actions,
    this.leading,
    required this.child,
    required this.sliverAppBar,
    this.title,
    this.titleWidget,
    this.needPadding,
    this.floatingActionButton,
    this.needLeading,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      appBar: _appBar(context),
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(kBodyRadius),
        ),
        child: NestedScrollView(
          controller: controller,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: const SizedBox.shrink(),
                flexibleSpace: sliverAppBar,
                // FlexibleSpaceBar(
                //   collapseMode: CollapseMode.pin,
                //   background: Container(
                //     color: Theme.of(context).primaryColor,
                //   ),
                // ),
                // expandedHeight: 0,
                // floating: false,
                // pinned: false,
                // snap: false
              ),
            ];
          },
          body: SliverScreenViewContent(
            context: context,
            needPadding: needPadding,
            child: child,
          ),
        ),
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
      leading:
          needLeading != null ? ScreenViewLeading(context: context) : leading,
      toolbarHeight: 60,
      centerTitle: true,
      systemOverlayStyle: StatusBarSettings.settings(context),
    );
  }
}

class SliverScreenViewContent extends StatelessWidget {
  final BuildContext context;
  final bool? needPadding;
  final Widget child;
  const SliverScreenViewContent({
    required this.context,
    super.key,
    required this.child,
    this.needPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: needPadding == null ? const EdgeInsets.all(kPadding * 2) : null,
      color: MyTheme.of(context).whiteColor,
      child: child,
    );
  }
}
