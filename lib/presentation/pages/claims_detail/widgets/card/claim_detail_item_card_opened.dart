import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_column_helper.dart';
import '../../../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';
import '../../../../../data/api/claims/products/entity/claims_detail_products_entity.dart';
import '../../../../../domain/repositories/repository.dart';
import '../../../../../locator/locator.dart';
import '../../../../../services/appmetrica/appmetrica_service.dart';
import '../../../../widgets/image_picker/attachments_load_error.dart';
import '../../../../widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';
import '../../../../widgets/image_picker/claims_files_cubit/claims_files_state.dart';
import '../../../../widgets/image_picker/custom_image_picker.dart';
import '../../../../widgets/image_picker/dialog_for_picking_files_instance.dart';
import '../../../../widgets/loading_widget.dart';
import '../../claim_products_bloc/claim_products_bloc.dart';

class ClaimDetailItemCardOpened extends StatefulWidget {
  final ClaimsProductsData data;
  final String status;

  const ClaimDetailItemCardOpened({
    Key? key,
    required this.data,
    required this.status,
  }) : super(key: key);

  @override
  State<ClaimDetailItemCardOpened> createState() =>
      _ClaimDetailItemCardOpenedState();
}

class _ClaimDetailItemCardOpenedState extends State<ClaimDetailItemCardOpened> {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ClaimProductsBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetOrNullColumnHelper(
            needPadding: false, title: 'Код', value: widget.data.code),
        WidgetOrNullColumnHelper(
            title: S.of(context).invoice_quantity,
            value: widget.data.quantity.toString()),
        WidgetOrNullColumnHelper(
            title: S.of(context).claim_quantity,
            value: widget.data.claimQuantity.toString()),
        WidgetOrNullColumnHelper(
            title: S.of(context).claim_type, value: widget.data.claimTypeName),
        WidgetOrNullColumnHelper(
          title: S.of(context).comment,
          value: widget.data.comment,
        ),
        BlocProvider<ClaimsFilesCubit>(
          create: (context) => ClaimsFilesCubit(
            repository: sl.get<Repository>(),
          )..claimAttachmentToFiles(widget.data.attachment ?? []),
          child: BlocBuilder<ClaimsFilesCubit, ClaimsFileState>(
              builder: (context, state) {
            var cubit = BlocProvider.of<ClaimsFilesCubit>(context);
            if (state is ClaimsFileLoadingS) {
              return Column(
                children: [
                  const SizedBox(height: kPadding * 3),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Файлы',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  const SizedBox(height: kBasePadding),
                  const LoadingWidget(),
                ],
              );
            }
            if (state is ClaimsFileLoadedS) {
              List<File> list = List.from(state.createdAttachments)
                ..addAll(state.newAttachments);
              var showPicker = _showPicker(widget.status);
              if (!showPicker && list.isEmpty) {
                return const SizedBox();
              }
              return Column(
                children: [
                  const SizedBox(height: kPadding * 3),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Файлы',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  const SizedBox(height: kBasePadding),
                  CustomImageAndFilesPicker(
                    onAddButton: () => showCustomDialog(
                        context: context,
                        addImageFromCamera: () => cubit.updateClaimImages(
                              claimUuid: bloc.uuid,
                              productUuid: widget.data.uuid,
                              fromGallery: false,
                              context: context,
                              appMetricaService: sl.get<AppMetricaService>(),
                            ),
                        addImageFromGallery: () => cubit.updateClaimImages(
                              claimUuid: bloc.uuid,
                              productUuid: widget.data.uuid,
                              fromGallery: true,
                              context: context,
                              appMetricaService: sl.get<AppMetricaService>(),
                            )),
                    claimFile: list,
                    showPicker: showPicker,
                    isDeleted: false,
                    onDeleteClaimFile: (image) {},
                    onDeleteClaimDraftFile: (ClaimDraftFile image) {},
                  ),
                ],
              );
            }
            if (state is ClaimsFileErrorS) {
              return Column(
                children: [
                  const SizedBox(height: kPadding * 3),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Файлы',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  const SizedBox(height: kBasePadding),
                  const AttachmentLoadError(),
                ],
              );
            }
            return const SizedBox();
          }),
        )
      ],
    );
  }

  bool _showPicker(String status) {
    switch (status) {
      case 'Удовлетворена':
        return false;
      case 'Отклонена':
        return false;
      case 'Отказ клиента':
        return false;
      default:
        return true;
    }
  }
}
