part of 'invoice_add_overage_bloc.dart';

abstract class InvoiceAddOverageEvent extends Equatable {
  const InvoiceAddOverageEvent();

  @override
  List<Object> get props => [];
}

class InvoiceAddOverageSearchE extends InvoiceAddOverageEvent {}

class InvoiceAddOverageSeriesE extends InvoiceAddOverageEvent {}

class InvoiceAddOverageSearchSeriesE extends InvoiceAddOverageEvent {}

class InvoiceAddOverageFiltersE extends InvoiceAddOverageEvent {}

class InvoiceAddOverageInitialE extends InvoiceAddOverageEvent {}

class InvoiceAddOverageInitializeE extends InvoiceAddOverageEvent {}

class InvoiceAddOverageSaveE extends InvoiceAddOverageEvent {}

class InvoiceAddOverageDeleteProductE extends InvoiceAddOverageEvent {
  final int id;

  const InvoiceAddOverageDeleteProductE({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

//save

class InvoiceAddOverageSaveProductE extends InvoiceAddOverageEvent {}

class InvoiceAddOverageUploadAttachmentsE extends InvoiceAddOverageEvent {
  final List<File> newAttachments;

  const InvoiceAddOverageUploadAttachmentsE({
    required this.newAttachments,
  });

  @override
  List<Object> get props => [newAttachments];
}

//CreateClaimDeleteImageE

class InvoiceAddOverageDeleteImageE extends InvoiceAddOverageEvent {
  final int id;

  const InvoiceAddOverageDeleteImageE({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class InvoiceAddOverageClearSeriesE extends InvoiceAddOverageEvent {}

class InvoiceAddOverageBackE extends InvoiceAddOverageEvent {}
