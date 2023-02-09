import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';

import '../upgrade_app_bloc/upgrader_bloc.dart';
import '../widgets/upgrader_bottom_sheet_content.dart';
import 'upgrade_app_page.dart';

class UpgraderWidget extends StatelessWidget {
  final Widget child;

  const UpgraderWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpgraderBloc, UpgraderState>(
      listener: (context, state) {
        final bloc = BlocProvider.of<UpgraderBloc>(context);
        if (state is UpgraderHasUpdateS) {
          BaseBottomSheetWidget(
            needMenu: false,
            context: context,
            child: BlocProvider.value(
              value: bloc,
              child: const UpgraderBottomSheetContent(),
            ),
          ).show();
        }
      },
      builder: (context, state) {
        if (state is UpgraderNeedUpdateS) {
          return const UpgradeAppPage();
        }
        return child;
      },
    );
  }
}
