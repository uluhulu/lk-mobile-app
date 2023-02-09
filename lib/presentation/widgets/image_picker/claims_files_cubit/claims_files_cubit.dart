import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/services/permisson_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../../../../data/api/claim_drafts/claim_draft_attachments/add_claim_draft_attachments/params/add_claim_draft_attachments_params.dart';
import '../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';
import '../../../../data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import '../../../../data/api/claims/attachments/entity/claim_new_attachment_entity.dart';
import '../../../../data/api/claims/attachments/params/claim_new_attachment_params.dart';
import '../../../../data/api/claims/products/entity/claims_detail_products_entity.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../services/appmetrica/appmetrica_service.dart';
import '../../../../services/image_picker_service/image_picker_service.dart';
import 'claims_files_state.dart';

class ClaimsFilesCubit extends Cubit<ClaimsFileState> {
  final Repository repository;
  final ImagePickerService imagePickerService = ImagePickerService();
  List<ClaimDraftsListAttachments> newFiles = [];
  List<ClaimDraftFile> deletedFiles = [];

  ClaimsFilesCubit({
    required this.repository,
  }) : super(ClaimsFileInitial()) {
    //_initialize();
  }

  // Future<void> _initialize() async {
  //   await PermissionService.checkPermission();
  // }

  void setInitialClaimsDraftsAttachments(List<ClaimDraftFile> attachment) {
    emit(ClaimDraftFileLoadedS(attachment: attachment));
  }

  Future<void> claimAttachmentToFiles(List<Attachment> attachment) async {
    if (attachment.isNotEmpty) {
      emit(ClaimsFileLoadingS());
      try {
        var list = await loadClaimImages(attachment);

        emit(ClaimsFileLoadedS(createdAttachments: list, newAttachments: []));
      } catch (e) {
        log("mapAttachmentToFiles error : $e");
        emit(
          ClaimsFileErrorS(),
        );
      }
    } else {
      emit(
        const ClaimsFileLoadedS(createdAttachments: [], newAttachments: []),
      );
    }
  }

  Future<List<File>> loadClaimImages(List<Attachment> attachment) async {
    List<File> list = [];
    for (var attachment in attachment) {
      final response = await repository.getClaimsImage(attachment.path!);
      Uint8List bytes = base64.decode(response.data.base64!);
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File(join(documentDirectory.path, attachment.name));
      file.writeAsBytesSync(bytes);
      list.add(file);
    }
    return list;
  }

  Future<void> claimDraftAttachmentToFiles(
      List<ClaimDraftsListAttachments> attachments) async {
    try {
      if (attachments.isNotEmpty) {
        if (deletedFiles.isNotEmpty) {
          for (var deletedItem in deletedFiles) {
            attachments.removeWhere((element) => element.id == deletedItem.id);
          }
        }
        emit(ClaimsFileLoadingS());
        var list = await loadClaimDraftImages(attachments);

        emit(
          ClaimDraftFileLoadedS(attachment: list),
        );
      } else {
        emit(
          const ClaimDraftFileLoadedS(attachment: []),
        );
      }
    } catch (e) {
      emit(
        ClaimsFileErrorS(),
      );
    }
  }

  Future<List<ClaimDraftFile>> loadClaimDraftImages(
      List<ClaimDraftsListAttachments> attachments) async {
    List<ClaimDraftFile> list = [];
    for (var attachment in attachments) {
      final response = await repository.getClaimDraftImage(attachment.id!);

      Uint8List bytes = base64.decode(response.base64);
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File(join(documentDirectory.path, attachment.name));
      file.writeAsBytesSync(bytes);
      var item = ClaimDraftFile(
        attachment: file,
        id: attachment.id!,
      );
      list.add(item);
    }
    return list;
  }

  Future<void> updateClaimDraftImages({
    required int claimId,
    required int productId,
    required bool fromGallery,
    required BuildContext context,
  }) async {
    try {
      var s = state as ClaimDraftFileLoadedS;
      var newAttachments = fromGallery
          ? await imagePickerService.addImageFromGallery(context: context)
          : await imagePickerService.addImageFromCamera(context: context);
      if (newAttachments != null && newAttachments.isNotEmpty) {
        emit(ClaimsFileLoadingS());
        var list = newAttachments
            .map((file) => ClaimDraftAttachmentsParams.fromFile(file))
            .toList();
        final addClaimDraftAttachmentsParams = AddClaimDraftAttachmentsParams(
          claimId: claimId,
          productId: productId,
          attachments: list,
        );
        var imageResult = await repository
            .updateClaimDraftAttachments(addClaimDraftAttachmentsParams);
        newFiles.addAll(imageResult.attachments);
        ClaimDraftsProductsData? currentProduct;
        bool hasFind = false;
        int page = 1;
        while (!hasFind) {
          Future.delayed(const Duration(seconds: 5)).then((value) {
            if (hasFind) return;
            throw TimeoutException('Превышено время ожидания');
          });
          final productResult = await repository.claimDraftProducts(
              claimId,
              ClaimDraftsProductsParams(
                id: claimId,
                page: page,
                perPage: 25,
              ));

          for (var item in productResult.data) {
            if (item.id == productId) {
              currentProduct = item;
              hasFind = true;
              break;
            }
          }
          page += 1;
        }
        claimDraftAttachmentToFiles(currentProduct!.attachments ?? []);
      }
    } catch (e) {
      emit(ClaimsFileErrorS());
    }
  }

  Future<void> deleteImage({
    required int id,
  }) async {
    try {
      // var deleteImage = await repository.deleteClaimDraftImage(id);
      var s = state as ClaimDraftFileLoadedS;
      var imagesList = [...s.attachment];
      var i = imagesList.indexWhere((element) => element.id == id);
      deletedFiles.add(imagesList[i]);
      imagesList.removeAt(i);
      emit(
        ClaimDraftFileLoadedS(attachment: imagesList),
      );
    } catch (e) {
      emit(ClaimsFileErrorS());
    }
  }

  Future<void> deleteImages({
    required bool isSaved,
  }) async {
    if (newFiles.isNotEmpty && !isSaved) {
      for (var item in newFiles) {
        var deleteImage = await repository.deleteClaimDraftImage(item.id!);
      }
      newFiles.clear();
    }
    if (deletedFiles.isNotEmpty && isSaved) {
      for (var item in deletedFiles) {
        var deleteImage = await repository.deleteClaimDraftImage(item.id);
      }
      deletedFiles.clear();
    }
  }

  Future<void> updateClaimImages({
    required String claimUuid,
    required String productUuid,
    required bool fromGallery,
    required BuildContext context,
    required AppMetricaService appMetricaService,
  }) async {
    try {
      appMetricaService
          .onEvent("Претензии Нажатие по кнопке : Добавление фото претензии");
      var s = state as ClaimsFileLoadedS;
      var newImages = fromGallery
          ? await imagePickerService.addImageFromGallery(context: context)
          : await imagePickerService.addImageFromCamera(context: context);
      if (newImages != null && newImages.isNotEmpty) {
        emit(ClaimsFileLoadingS());
        var list =
            newImages.map((file) => AttachmentsParams.fromFile(file)).toList();
        final ClaimsNewAttachmentsParams attachmentsParams =
            ClaimsNewAttachmentsParams(
          claimUuid: claimUuid,
          productUuid: productUuid,
          attachments: list,
        );
        final ClaimsNewAttachmentsEntity result =
            await repository.updateClaimAttachments(attachmentsParams);
        var newAttach = [...s.newAttachments];
        newAttach.addAll(newImages);
        emit(ClaimsFileLoadedS(
          createdAttachments: s.createdAttachments,
          newAttachments: newAttach,
        ));
      }
    } catch (e) {
      emit(ClaimsFileErrorS());
    }
  }
}
