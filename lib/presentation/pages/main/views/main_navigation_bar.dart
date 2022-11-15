// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';

import 'package:mkk/presentation/pages/main/navigation_bar_bloc/home_navigation_bar.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavigationBarBloc, HomeNavigationBarState>(
      builder: _builder,
      buildWhen: _buildWhen,
    );
  }

  Widget _builder(BuildContext context, HomeNavigationBarState state) {
    final activeColor = Theme.of(context).primaryColor;
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(14, 0, 0, 14),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (_) => _onTap(context, _),
        currentIndex: state.index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const BottomBarIconWidget(path: 'assets/icon/user.svg'),
            label: S.of(context).profile,
            activeIcon: BottomBarIconWidget(
              path: 'assets/icon/user.svg',
              color: activeColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: const BottomBarIconWidget(
              path: 'assets/icon/tick-square.svg',
            ),
            label: S.of(context).overhead,
            activeIcon: BottomBarIconWidget(
              path: 'assets/icon/tick-square.svg',
              color: activeColor,
            ),
          ),
          BottomNavigationBarItem(
              icon: const BottomBarIconWidget(
                  path: 'assets/icon/note-remove.svg'),
              label: S.of(context).claims,
              activeIcon: BottomBarIconWidget(
                path: 'assets/icon/note-remove.svg',
                color: activeColor,
              )),
          BottomNavigationBarItem(
              icon: const BottomBarIconWidget(path: 'assets/icon/payments.svg'),
              label: S.of(context).payments,
              activeIcon: BottomBarIconWidget(
                path: 'assets/icon/payments.svg',
                color: activeColor,
              )),
        ],
      ),
    );
  }

  bool _buildWhen(
    HomeNavigationBarState previous,
    HomeNavigationBarState current,
  ) =>
      previous.index != current.index;

  void _onTap(BuildContext context, int value) {
    context.read<HomeNavigationBarBloc>().add(
          HomeNavigationBarChanged(value),
        );
  }
}

class BottomBarIconWidget extends StatelessWidget {
  final String path;
  final Color? color;

  const BottomBarIconWidget({
    Key? key,
    required this.path,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kPadding / 2, top: kPadding),
      child: SvgPicture.asset(path,
          color: color ?? MyTheme.of(context).greyIconColor),
    );
  }
}
