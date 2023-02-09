import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/presentation/number_paginator/ui/widgets/inherited_number_paginator.dart';

class PaginatorButton extends StatelessWidget {
  /// Callback for button press.
  final VoidCallback? onPressed;

  /// The child of the button.
  final Widget child;
  final Widget? activeChild;

  /// Whether the button is currently selected.
  final bool selected;

  final bool isArrow;

  /// Creates an instance of [PaginatorButton].
  const PaginatorButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.selected = false,
    this.isArrow = false,
    this.activeChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.09,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(
              _backgroundColor(context, selected) ?? Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(
              _foregroundColor(context, selected) ?? Colors.white),
        ),
        child: isArrow
            ? selected
                ? activeChild!
                : child
            : child,
      ),
    );
  }

  Color? _backgroundColor(BuildContext context, bool selected) => isArrow
      ? selected
          ? (InheritedNumberPaginator.of(context)
                  .config
                  .arrowSelectedBackgroundColor ??
              Theme.of(context).colorScheme.secondary)
          : InheritedNumberPaginator.of(context)
              .config
              .arrowUnselectedBackgroundColor
      : selected
          ? (InheritedNumberPaginator.of(context)
                  .config
                  .buttonSelectedBackgroundColor ??
              Theme.of(context).colorScheme.secondary)
          : InheritedNumberPaginator.of(context)
              .config
              .buttonUnselectedBackgroundColor;

  Color? _foregroundColor(BuildContext context, bool selected) => selected
          ? (InheritedNumberPaginator.of(context)
                  .config
                  .buttonSelectedForegroundColor ??
              Colors.white)
          : InheritedNumberPaginator.of(context)
              .config
              .buttonUnselectedForegroundColor;
}
