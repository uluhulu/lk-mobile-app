import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../app_loader/app_loader_bloc/app_loader_bloc.dart';
import '../../claims/views/claims_page.dart';
import '../../invoices/views/invoices_page.dart';
import '../../payments/views/payments_page.dart';
import '../../profile/views/profile_page.dart';
import '../navigation_bar_bloc/home_navigation_bar.dart';

///
class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  static final List<Widget> _pages = <Widget>[
    const ProfileProvider(),
    const InvoicesProvider(),
    const ClaimsProvider(),
    const PaymentsProvider(),
  ];

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppLoaderBloc, AppLoaderState>(
      listener: _loaderListener,
      child: BlocConsumer<HomeNavigationBarBloc, HomeNavigationBarState>(
        builder: _builder,
        buildWhen: _buildWhen,
        listener: _listener,
        listenWhen: _listenWhen,
      ),
    );
  }

  Widget _builder(
    BuildContext context,
    HomeNavigationBarState state,
  ) {
    return state.when(
      change: (int index, _) => MainContent._pages.elementAt(index),
    );
  }

  bool _buildWhen(
    HomeNavigationBarState previous,
    HomeNavigationBarState current,
  ) =>
      current.index < MainContent._pages.length;

  bool _listenWhen(
    HomeNavigationBarState previous,
    HomeNavigationBarState current,
  ) =>
      current.index >= MainContent._pages.length;

  void _loaderListener(BuildContext context, AppLoaderState state) {
    if (state.isLoading) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }

  void _listener(
    BuildContext context,
    HomeNavigationBarState state,
  ) {}
}
