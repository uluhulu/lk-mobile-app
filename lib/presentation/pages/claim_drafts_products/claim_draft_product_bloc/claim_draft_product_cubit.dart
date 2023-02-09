import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/core/utils/formatter.dart';
import 'package:mkk/data/api/claim_drafts/save/params/claim_drafts_save_params.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_drafts_error_cubit/claim_drafts_error_cubit.dart';
import 'package:mkk/presentation/pages/claim_drafts_products/claim_drafts_products_bloc/claim_drafts_products_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';
import '../../../../data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../domain/validators/claim_drafts/claim_drafts_validator.dart';
import 'package:path/path.dart';

import '../../../widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';

part 'claim_draft_product_state.dart';

class ClaimDraftProductBloc extends Cubit<ClaimDraftProductState> {
  final ClaimDraftsProductsBloc productsBloc;
  final ClaimDraftsProductsData data;
  final ClaimDraftsErrorCubit errorCubit;
  final ClaimsFilesCubit filesCubit;
  final Repository repository;
  final int draftId;

  ClaimDraftProductBloc({
    required this.productsBloc,
    required this.data,
    required this.errorCubit,
    required this.repository,
    required this.draftId,
    required this.filesCubit,
  }) : super(ClaimDraftProductInitialS()) {
    _initialize();

    claimType.streamValue.listen(_claimTypeListener);
    quantityClaim.stream.listen(_quantityClaimListener);
    comment.stream.listen(_commentListener);
  }

  bool? isErrorFirst;
  List<ClaimDraftFile>? attachments;
  List<ClaimDraftFile>? deletedImages;
  bool isEditable = false;

  Future<void> _initialize() async {
    isEditable = false;
    if (data.claimQuantity == 0) {
      quantityClaim.text = '';
    } else {
      quantityClaim.text = data.claimQuantity.toString();
    }
    quantityClaim.validation = null;
    comment.text = data.claimComment ?? '';
    if (data.claimType != null) {
      claimType.value = data.possibleClaimTypes!.entries
          .firstWhere((element) => int.parse(element.key) == data.claimType)
          .value;
      claimTypeNumber.value = data.claimType;
      isErrorFirst = null;
    }

    final errorState = errorCubit.state;
    if (errorState is ClaimDraftsErrorSendS) {
      errorState.data?.errors.forEach((key, value) {
        if (key == data.id.toString()) {
          for (var element in value.errors) {
            if (element.field == 'claim_type') {
              claimType.validation = element.message;
            } else if (element.field == 'claim_comment') {
              comment.validation = 'Заполните поле комментарий';
            } else if (element.field == 'claim_quantity') {
              quantityClaim.validation = element.message;
              isErrorFirst = true;
            }
          }
        }
      });
    }
    attachments = await loadImages(data.attachments ?? []);
    emit(ClaimDraftProductLoadedS(
        attachments: attachments!, isAttachmentsLoading: false));
  }

  Future<List<ClaimDraftFile>> loadImages(
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

  Future<void> deleteNewImage() async {
    try {
      await filesCubit.deleteImages(isSaved: false);
    } catch (e) {}
  }

  Future<void> save() async {
    await filesCubit.deleteImages(isSaved: true);
    productsBloc.saveProduct(ClaimDraftsProductsModel(
      id: data.id,
      claimQuantity:
          quantityClaim.text == "" ? 0 : int.parse(quantityClaim.text),
      claimComment: Formatter.textFormatter(comment.text),
      claimType: claimTypeNumber.value,
    ));
    errorCubit.deleteErrorProduct(data.id);
  }

  late SuperValidation quantityClaim = SuperValidation(
    validationFunc: (value) {
      return ClaimDraftsValidator.quantityClaim(
        value,
        data.invoiceQuantity,
        isErrorFirst,
        claimType.value,
        //TODO: перепроверить
        // data.possibleClaimTypes!.entries
        //     .firstWhere((element) => int.parse(element.key) == data.claimType)
        //     .value,
      );
    },
  );

  SuperValidation comment = SuperValidation(
    validationFunc: ClaimDraftsValidator.claimTypeWithDrafts,
  );

  SuperValidationEnum<String> claimType = SuperValidationEnum(
    validateFunc: ClaimDraftsValidator.claimTypeWithDrafts,
  );

  final SuperValidationEnum<int> claimTypeNumber = SuperValidationEnum();

  // late final String? oldClaimType = claimType.value;
  // late final String? oldQuantityClaim = quantityClaim.text;
  // late final String? oldComment = comment.text;

  void _claimTypeListener(String? event) {
    isEditable = true;
    if (event?.contains('Пересорт') ?? false) {
      comment.validation = null;
      //comment.validation = 'Заполните поле комментарий';
    } else {
      comment.validation = null;
    }
  }

  void _quantityClaimListener(String event) {
    isEditable = true;
  }

  void _commentListener(String event) {
    isEditable = true;
  }

  @override
  Future<void> close() {
    quantityClaim.dispose();
    comment.dispose();
    claimType.dispose();
    claimTypeNumber.dispose();
    return super.close();
  }
}
