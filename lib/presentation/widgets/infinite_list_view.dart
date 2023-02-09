// import 'package:flutter/material.dart';

// import '../../core/utils/constants.dart';

// class InfiniteListView extends StatefulWidget {
//   final int itemCount;
//   final Widget Function(BuildContext context, int index)? separatorBuilder;
//   final Widget Function(BuildContext context, int index) builder;
//   final int total;
//   final Function onFetchMore;
//   const InfiniteListView({
//     super.key,
//     required this.itemCount,
//     this.separatorBuilder,
//     required this.builder,
//     required this.total,
//     required this.onFetchMore,
//   });

//   @override
//   State<InfiniteListView> createState() => _InfiniteListViewState();
// }

// class _InfiniteListViewState extends State<InfiniteListView> {
//   final _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_scrollListener);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       padding: const EdgeInsets.only(bottom: kBasePadding * 4),
//       shrinkWrap: true,
//       separatorBuilder: _separatorBuilder,
//       itemCount: widget.itemCount,
//       itemBuilder: widget.builder,
//       controller: _scrollController,
//     );
//   }

//   Widget _separatorBuilder(BuildContext context, int index) {
//     return const Divider(
//       height: 48,
//     );
//   }

//   void _scrollListener() {
//     if (_scrollController.position.maxScrollExtent ==
//         _scrollController.offset) {
//       if (widget.itemCount < widget.total) {
//         widget.onFetchMore();
//       }
//     }
//   }
// }

///EXAMPLE (create_claim_item_list.dart)
///
  // InfiniteListView(
  //                 itemCount: state.data.data.length,
  //                 total: state.data.meta?.total ?? 0,
  //                 onFetchMore: () {
  //                   bloc.add(CreateClaimFetchMoreE());
  //                 },
  //                 builder: (context, index) {
  //                   final item = state.data.data[index];
  //                   return RadioListTile<InvoicesDetailProductData>(
  //                     contentPadding: const EdgeInsets.all(0),
  //                     visualDensity: VisualDensity.comfortable,
  //                     activeColor: MyTheme.of(context).primaryButtonColor,
  //                     controlAffinity: ListTileControlAffinity.trailing,
  //                     value: state.data.data[index],
  //                     groupValue: value,
  //                     onChanged: (newValue) {
  //                       bloc.invoiceItem.value = newValue;
  //                     },
  //                     title: CreateClaimItemTitle(item: item),
  //                   );
  //                 }),