import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/profile/act/act_bloc/act_bloc.dart';
import 'package:mkk/presentation/pages/profile/act/widgets/act_error_widget.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import '../../../../widgets/modal/modal_bottom_sheet_widget.dart';
import '../../../../widgets/scaffold/screen_view.dart';
import '../widgets/act_loaded_widget.dart';
import 'create_act_page.dart';

class ActProvider extends StatelessWidget {
  const ActProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActBloc>(
      create: _createActBloc,
      child: ScreenView(
        context: context,
        title: S.of(context).act_request,
        child: const ActContent(),
      ),
    );
  }

  ActBloc _createActBloc(BuildContext context) {
    return ActBloc(
      repository: sl.get<Repository>(),
    );
  }
}

class ActContent extends StatelessWidget {
  const ActContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActBloc, ActState>(
      listener: _listener,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, ActState state) {
    if (state is ActLoadingS) {
      return const LoadingWidget();
    }
    return const CreateActPage();
  }

  void _listener(BuildContext context, ActState state) {
    if (state is ActLoadedS) {
      actBottomSheet(context, const ActLoadedWidget());
    }
    if (state is ActErrorS) {
      actBottomSheet(context, const ActErrorWidget());
    }
  }

  Future<void> actBottomSheet(BuildContext context, Widget widget) {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        shape: _shape(),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        context: context,
        builder: ((context) {
          return widget;
        }));
  }

  RoundedRectangleBorder _shape() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kSheetBorderRadius),
        topRight: Radius.circular(kSheetBorderRadius),
      ),
    );
  }
}
