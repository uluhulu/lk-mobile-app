import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../payments/views/payments_page.dart';
import '../../profile/views/profile_page.dart';
import '../navigation_bar_bloc/home_navigation_bar.dart';

///
class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  static final List<Widget> _pages = <Widget>[
    const ProfileProvider(),
    TestPage(index: 2),
    TestPage(index: 3),
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
    return BlocConsumer<HomeNavigationBarBloc, HomeNavigationBarState>(
      builder: _builder,
      buildWhen: _buildWhen,
      listener: _listener,
      listenWhen: _listenWhen,
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

  void _listener(
    BuildContext context,
    HomeNavigationBarState state,
  ) {}
}

class TestPage extends StatelessWidget {
  final int index;
  const TestPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        index.toString(),
      )),
      body: Center(child: Text(index.toString())),
    );
  }
}
