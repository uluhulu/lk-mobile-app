part of 'claim_products_bloc.dart';

abstract class ClaimProductsEvent extends Equatable {
  const ClaimProductsEvent();

  @override
  List<Object> get props => [];
}

class ClaimProductsFetchE extends ClaimProductsEvent {}

// class ClaimProductsNewImagesE extends ClaimProductsEvent {
//   final String productUuid;
//   final List<File> newImages;
//
//   ClaimProductsNewImagesE({
//     required this.productUuid,
//     required this.newImages,
//   });
//
//   @override
//   List<Object> get props => [
//         productUuid,
//         newImages,
//       ];
// }
