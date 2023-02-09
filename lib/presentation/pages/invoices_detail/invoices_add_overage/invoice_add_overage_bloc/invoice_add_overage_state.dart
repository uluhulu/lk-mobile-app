part of 'invoice_add_overage_bloc.dart';

abstract class InvoiceAddOverageState extends Equatable {
  const InvoiceAddOverageState();

  @override
  List<Object> get props => [];
}

class InvoiceAddOverageInitialS extends InvoiceAddOverageState {}

class InvoiceAddOverageProductS extends InvoiceAddOverageState {
  final ClaimDraftsFindOveragesEntity entity;
  const InvoiceAddOverageProductS({
    required this.entity,
  });

  @override
  List<Object> get props => [entity];
}

class InvoiceAddOverageSearchErrorS extends InvoiceAddOverageState {
  final String message;

  const InvoiceAddOverageSearchErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class InvoiceAddOveragesSeriesS extends InvoiceAddOverageState {
  final ClaimDraftFindOverageData product;
  const InvoiceAddOveragesSeriesS({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

class InvoiceAddOverageEditProductS extends InvoiceAddOverageState {
  final ClaimDraftsProductsData product;
  final List<ClaimDraftFile> attachments;
  final int draftId;
  final bool isImageGalleryLoading;
  const InvoiceAddOverageEditProductS({
    required this.product,
    required this.draftId,
    required this.attachments,
    required this.isImageGalleryLoading,
  });

  @override
  List<Object> get props =>
      [product, attachments, isImageGalleryLoading, draftId];
}

class InvoiceAddOverageLoadingS extends InvoiceAddOverageState {}

class InvoiceAddOverageErrorS extends InvoiceAddOverageState {
  final String message;

  const InvoiceAddOverageErrorS({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class InvoiceAddOverageSaveSuccesS extends InvoiceAddOverageState {
  final int id;

  const InvoiceAddOverageSaveSuccesS({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class InvoiceAddOverageSaveErrorS extends InvoiceAddOverageState {
  final String message;
  final String title;

  const InvoiceAddOverageSaveErrorS({
    required this.message,
    required this.title,
  });

  @override
  List<Object> get props => [message, title];
}
