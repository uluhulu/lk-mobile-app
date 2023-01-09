import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/help/navigation_route_params.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../invoices_bloc/invoices_bloc.dart';
import '../widgets/invoices_item_card.dart';
import '../widgets/invoices_pagination.dart';
import '../widgets/sorting/invoices_search_sort.dart';

class InvoicesLoaded extends StatefulWidget {
  final InvoicesEntity data;
  final int numberPages;
  final Function(int index) onPageChange;

  const InvoicesLoaded({
    Key? key,
    required this.data,
    required this.numberPages,
    required this.onPageChange,
  }) : super(key: key);

  @override
  State<InvoicesLoaded> createState() => _InvoicesLoadedState();
}

class _InvoicesLoadedState extends State<InvoicesLoaded> {
  final ScrollController _scrollController = ScrollController();
  bool isVisible = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invoices = widget.data.data;
    return BlocBuilder<InvoicesBloc, InvoicesState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              padding: _bodyPadding(),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                isVisible
                    ? const BoxShadow(color: Colors.transparent)
                    : BoxShadow(
                        color: Colors.black.withOpacity(0.30),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      )
              ]),
              child: InvoicesSearchSort(data: widget.data),
            ),
            const SizedBox(height: kPadding / 2),
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                separatorBuilder: _separatorBuilder,
                padding: _padding(),
                itemCount: invoices.length,
                itemBuilder: _itemBuilder,
              ),
            ),
          ],
        );
      },
    );
  }

  EdgeInsets _bodyPadding() {
    return const EdgeInsets.only(
      top: kPadding * 3,
      left: kBasePadding,
      right: kBasePadding,
      bottom: kPadding,
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.symmetric(
        vertical: kPadding, horizontal: kBasePadding);
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const SizedBox(height: kBasePadding);
  }

  Widget _itemBuilder(
    BuildContext context,
    int index,
  ) {
    final item = widget.data.data[index];
    final bloc = context.read<InvoicesBloc>();
    if (index == widget.data.data.length - 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InvoicesItemCard(
            data: item,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.invoicesDetail,
                  arguments: NavigationRouteParams(item.uuid));
            },
          ),
          const SizedBox(height: kBasePadding),
          InvoicesPagination(bloc: bloc),
          const SizedBox(height: kBasePadding),
        ],
      );
    }
    return InvoicesItemCard(
      data: item,
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.invoicesDetail,
            arguments: NavigationRouteParams(item.uuid));
      },
    );
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isVisible) {
        setState(() {
          isVisible = false;
        });
      }
    }
    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        _scrollController.offset <= 0) {
      if (!isVisible) {
        setState(() {
          isVisible = true;
        });
      }
    }
  }
}
