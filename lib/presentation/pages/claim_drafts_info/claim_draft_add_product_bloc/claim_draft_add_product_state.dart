part of 'claim_draft_add_product_bloc.dart';

abstract class ClaimDraftAddProductState extends Equatable {
  const ClaimDraftAddProductState();

  @override
  List<Object> get props => [];
}

class ClaimDraftAddProductInitialS extends ClaimDraftAddProductState {}

class ClaimDraftAddProductLoadingS extends ClaimDraftAddProductState {}

class ClaimDraftAddProductStartS extends ClaimDraftAddProductState {
  final ClaimDraftsProductsEntity data;

  const ClaimDraftAddProductStartS({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class ClaimDraftAddProductS extends ClaimDraftAddProductState {
  final int id;
  final ClaimDraftsProductsData product;
  final bool isLoadingGallery;
  final List<ClaimDraftFile> attachmentsList;

  const ClaimDraftAddProductS({
    required this.id,
    required this.product,
    required this.isLoadingGallery,
    required this.attachmentsList,
  });

  @override
  List<Object> get props => [id,product,isLoadingGallery,];
}

class ClaimDraftAddProductSaveSuccesS extends ClaimDraftAddProductState {
  final int id;

  const ClaimDraftAddProductSaveSuccesS({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class ClaimDraftAddProductErrorS extends ClaimDraftAddProductState {}
