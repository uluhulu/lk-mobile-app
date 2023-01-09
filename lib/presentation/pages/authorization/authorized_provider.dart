import 'package:flutter/material.dart';
import '../banner/banner_widget.dart';

class AuthorizedProvider extends StatelessWidget {
  final Widget child;
  const AuthorizedProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BannerBuilder(child: child);
  }
}
