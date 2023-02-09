import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';

abstract class ClaimsFileState extends Equatable {
  const ClaimsFileState();

  @override
  List<Object> get props => [];
}

class ClaimsFileInitial extends ClaimsFileState {}

class ClaimsFileLoadingS extends ClaimsFileState {}
class ClaimsFileLoadingErrorS extends ClaimsFileState {}

class ClaimsFileLoadedS extends ClaimsFileState {
  final List<File> createdAttachments;
  final List<File> newAttachments;

  const ClaimsFileLoadedS(
      {required this.createdAttachments, required this.newAttachments});

  ClaimsFileLoadedS copyWith(
      {List<File>? createdAttachments, List<File>? newAttachments}) {
    return ClaimsFileLoadedS(
      createdAttachments: createdAttachments ?? this.createdAttachments,
      newAttachments: newAttachments ?? this.newAttachments,
    );
  }

  @override
  List<Object> get props => [createdAttachments, newAttachments];
}
class ClaimDraftFileLoadedS extends ClaimsFileState {
  final List<ClaimDraftFile> attachment;

  const ClaimDraftFileLoadedS(
      {required this.attachment,});


  @override
  List<Object> get props => [attachment, ];
}
class ClaimsFileErrorS extends ClaimsFileState {}
