import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/invoices/invoices_search_bloc/invoices_search_bloc.dart';
import 'package:mkk/presentation/widgets/loading_widget.dart';
import 'package:mkk/presentation/widgets/scaffold/screen_view.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/buttons/primary_elevated_button.dart';
import '../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../widgets/search/views/search_content.dart';
import '../widgets/search/widgets/search_error_widget.dart';
import '../widgets/search/views/search_loaded.dart';

class InvoicesSearchPage extends StatelessWidget {
  const InvoicesSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvoicesSearchBloc>(
      create: _createSearchBloc,
      child: const InvoicesSearchContent(),
    );
  }

  InvoicesSearchBloc _createSearchBloc(BuildContext context) {
    return InvoicesSearchBloc(
      repository: sl.get<Repository>(),
    );
  }
}

class InvoicesSearchContent extends StatelessWidget {
  const InvoicesSearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoicesSearchBloc, InvoicesSearchState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(BuildContext context, InvoicesSearchState state) {
    if (state is InvoicesSearchLoadingS) {
      return LoadingPage(title: S.of(context).search);
    }
    if (state is InvoicesSearchLoadedS) {
      return ScreenView(
        needPadding: false,
        context: context,
        title: S.of(context).invoice,
        child: InvoicesSearchLoaded(
          invoicesSearch: state.invoicesSearch,
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
        floatingActionButton: const InvoicesSearchButton(),
        child: const InvoicesSearchContentWidget(),
      ),
    );
  }

  void _listener(BuildContext context, InvoicesSearchState state) {
    if (state is InvoicesSearchErrorS) {
      final bloc = context.read<InvoicesSearchBloc>();
      BaseBottomSheetWidget(
        context: context,
        child: BlocProvider.value(
          value: bloc,
          child: SearchErrorWidget(
            message: state.message,
          ),
        ),
      ).show();
    }
  }
}

class InvoicesSearchButton extends StatelessWidget {
  const InvoicesSearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuperValidationBuilder(
        superValidation: context.read<InvoicesSearchBloc>().search,
        builder: (context, validation, isValid) {
          return PrimaryElevatedButton(
            canPress: context.read<InvoicesSearchBloc>().search.isValid,
            btnWidth: 200,
            onPressed: () {
              context.read<InvoicesSearchBloc>().add(InvoicesSearchFetchE());
            },
            text: S.of(context).apply,
          );
        });
  }
}
