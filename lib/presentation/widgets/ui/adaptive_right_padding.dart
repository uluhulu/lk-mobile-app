import 'package:flutter/material.dart';

class AdaptiveScreen extends StatelessWidget {
  final Widget child;
  final Widget lowWidthChild;
  const AdaptiveScreen({
    super.key,
    required this.child,
    required this.lowWidthChild,
  });

  @override
  Widget build(BuildContext context) {
    return calculateWidth(context);
  }

  Widget calculateWidth(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    if (width < 322) {
      return lowWidthChild;
    }
    if (width > 350 && width < 385) {
      return child;
    }
    if (width > 385 && width < 400) {
      return child;
    }
    if (width > 400 && width < 420) {
      return child;
    }
    return child;
  }
}
