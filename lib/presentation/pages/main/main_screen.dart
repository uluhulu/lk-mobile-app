import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/presentation/pages/authorization/authorization_bloc/authorization_bloc.dart';
import 'package:mkk/presentation/pages/main/navigation_bar_bloc/home_navigation_bar.dart';
import 'package:mkk/presentation/pages/main/views/main_content.dart';
import 'package:mkk/presentation/pages/main/views/main_navigation_bar.dart';
import 'package:mkk/presentation/pages/main/views/main_navigator.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';
import 'package:mkk/presentation/widgets/ui/confirm_dialog.dart';

/// Главный экран
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainNavigator(
      child: BlocProvider<HomeNavigationBarBloc>(
        create: _createNavigationBloc,
        child: ScreenView(
          context: context,
          needPadding: false,
          bottomNavigationBar: const MainNavigationBar(),
          titleWidget: SvgPicture.asset('assets/icon/app_bar_logo.svg'),
          leading: InkWell(
              onTap: () {
                showDialog(context: context, builder: _showDialog);
              },
              child: Padding(
                padding: const EdgeInsets.all(kPadding),
                child: SvgPicture.asset(
                  'assets/icon/question.svg',
                  color: Colors.white,
                ),
              )),
          child: const MainContent(),
        ),
      ),
    );
  }

  HomeNavigationBarBloc _createNavigationBloc(BuildContext context) {
    return HomeNavigationBarBloc();
  }

  Widget _showDialog(BuildContext context) {
    return ConfirmDialog(
        isFirst: false,
        titleText: 'Я еще до этого не дошел))',
        contentText: 'Но вы можете выйти из аккаунта нажав одну из кнопок',
        confirmButtonText: 'Выйти',
        confirmCallback: () {
          context.read<AuthorizationBloc>().add(AuthorizationLogOutE());
        });
  }
}
