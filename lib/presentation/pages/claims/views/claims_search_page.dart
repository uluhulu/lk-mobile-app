import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../../invoices/widgets/search/widgets/search_error_widget.dart';
import '../claims_search_bloc/claims_search_bloc.dart';
import '../widgets/search/claims_search_content.dart';
import '../widgets/search/claims_search_loaded.dart';
import '../widgets/search/widgets/claim_search_error_widget.dart';

class ClaimsSearchPage extends StatelessWidget {
  const ClaimsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClaimsSearchBloc>(
      create: _createSearchBloc,
      child: const InvoicesSearchContent(),
    );
  }

  ClaimsSearchBloc _createSearchBloc(BuildContext context) {
    return ClaimsSearchBloc(
      repository: sl.get<Repository>(),
    );
  }
}

class InvoicesSearchContent extends StatelessWidget {
  const InvoicesSearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClaimsSearchBloc, ClaimsSearchState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(BuildContext context, ClaimsSearchState state) {
    if (state is ClaimsSearchLoadingS) {
      return LoadingPage(title: S.of(context).search);
    }
    if (state is ClaimsSearchLoadedS) {
      return ScreenView(
        needPadding: false,
        context: context,
        title: S.of(context).claim,
        child: ClaimsSearchLoaded(
          claim: state.claimsData,
        ),
      );
    }
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: ScreenView(
        context: context,
        title: S.of(context).search,
        floatingActionButton: const ClaimsSearchButton(),
        child: const ClaimsSearchContent(),
      ),
    );
  }

  void _listener(BuildContext context, ClaimsSearchState state) {
    if (state is ClaimsSearchErrorS) {
      BaseBottomSheetWidget(
        context: context,
        child: BlocProvider.value(
          value: context.read<ClaimsSearchBloc>(),
          child: ClaimSearchErrorWidget(
            message: state.message,
          ),
        ),
      ).show();
    }
  }
}

class ClaimsSearchButton extends StatelessWidget {
  const ClaimsSearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuperValidationBuilder(
        superValidation: context.read<ClaimsSearchBloc>().number,
        builder: (context, validation, isValid) {
          return PrimaryElevatedButton(
            canPress: context.read<ClaimsSearchBloc>().number.isValid,
            btnWidth: 200,
            onPressed: () {
              context.read<ClaimsSearchBloc>().add(ClaimsSearchFetchE());
            },
            text: S.of(context).apply,
          );
        });
  }
}
