// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_claim_bloc.dart';

abstract class CreateClaimState extends Equatable {
  const CreateClaimState();

  @override
  List<Object> get props => [];
}

class CreateClaimInitialS extends CreateClaimState {}

class CreateClaimLoadingS extends CreateClaimState {}

class CreateClaimStartS extends CreateClaimState {
  final InvoicesDetailProductsEntity data;

  const CreateClaimStartS({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class CreateClaimProductS extends CreateClaimState {
  final int id;
  final ClaimDraftsProductsData product;
  final List<ClaimDraftFile> attachments;
  final bool isImageGalleryLoading;

  const CreateClaimProductS({
    required this.id,
    required this.product,
    required this.attachments,
    required this.isImageGalleryLoading,
  });

  @override
  List<Object> get props => [id, product, attachments, isImageGalleryLoading];
  //
  // CreateClaimProductS copyWith({int? id, ClaimDraftsProductsData? product, List<
  //     ClaimDraftFile>? attachments, bool? isAttachmentsLoading}) {
  //   return CreateClaimProductS(
  //     id: id ?? this.id,
  //     product: product ?? this.product,
  //     attachments: attachments ?? this.attachments,);
  // }
}

class CreateClaimSaveSuccesS extends CreateClaimState {
  final int id;

  const CreateClaimSaveSuccesS({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class CreateClaimErrorS extends CreateClaimState {}
