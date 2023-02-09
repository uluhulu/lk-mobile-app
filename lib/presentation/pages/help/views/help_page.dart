import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/api/help/entity/help_entity.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../domain/repositories/user_repository.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/error/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/scaffold/screen_view.dart';
import '../help_bloc/help_block.dart';
import '../help_bloc/help_state.dart';
import 'help_loaded.dart';

class HelpPageProvider extends StatelessWidget {
  const HelpPageProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HelpBlock>(
      create: (_createBloc),
      child: ScreenView(
        context: context,
        needPadding: false,
        title: S.of(context).help,
        child: const HelpContent(),
      ),
    );
  }

  HelpBlock _createBloc(BuildContext context) {
    return HelpBlock(
      repository: sl.get<Repository>(),
      userRepository: sl.get<UserRepository>(),
    );
  }
}

class HelpContent extends StatelessWidget {
  const HelpContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HelpBlock>();
    return BlocBuilder<HelpBlock, HelpState>(
      builder: (context, state) {
        if (state is HelpLoadingS) {
          return const LoadingWidget();
        }
        if (state is HelpLoadedS) {
          return HelpLoaded(
            content: state.content,
          );
        }

        if (state is HelpErrorS) {
          return AppErrorWidget(callback: () {
            // bloc.add(InvoicesRefreshE());
          });
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
