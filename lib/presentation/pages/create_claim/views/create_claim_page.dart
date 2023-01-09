import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/create_claim/create_claim_bloc/create_claim_bloc.dart';
import 'package:mkk/presentation/pages/create_claim/views/create_claim_loaded.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';

import '../../../../config/app_routes.dart';
import '../../../../core/help/navigation_claims_filter_page_params.dart';
import 'create_claim_product_info.dart';

class CreateClaimProvider extends StatelessWidget {
  final String uuid;
  const CreateClaimProvider({
    super.key,
    required this.uuid,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateClaimBloc>(
      create: _createBloc,
      child: const CreateClaimContent(),
    );
  }

  CreateClaimBloc _createBloc(BuildContext context) {
    return CreateClaimBloc(
      repository: sl.get<Repository>(),
      uuid: uuid,
    );
  }
}

class CreateClaimContent extends StatefulWidget {
  const CreateClaimContent({super.key});

  @override
  State<CreateClaimContent> createState() => _CreateClaimContentState();
}

class _CreateClaimContentState extends State<CreateClaimContent> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateClaimBloc, CreateClaimState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(BuildContext context, CreateClaimState state) {
    if (state is CreateClaimLoadingS) {
      return ScreenView(
        context: context,
        title: S.of(context).claim_drafts,
        child: const LoadingWidget(),
      );
    }
    if (state is CreateClaimStartS) {
      return CreateClaimLoaded(entity: state.data);
    }
    if (state is CreateClaimProductS) {
      return WillPopScope(
        onWillPop: _onWillPop,
        //  () {
        //   BaseBottomSheetWidget(
        //           context: context,
        //           child: Container(
        //               height: 250,
        //               width: double.infinity,
        //               child: Text('sdfdsfsdf')))
        //       .show();
        //   return Future.value(false);
        // },
        child: CreateClaimProductInfo(
          data: state.product,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  void _listener(BuildContext context, CreateClaimState state) {
    if (state is CreateClaimSaveSuccesS) {
      Navigator.of(context).popAndPushNamed(
        AppRoutes.claimDraftsInfo,
        arguments: ClaimsDraftsListPageParams(id: state.id),
      );
    }
  }
}
