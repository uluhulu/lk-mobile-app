import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mkk/domain/repositories/settings_repository.dart';
import 'package:mkk/services/logger/logger_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../../locator/locator.dart';
import '../../presentation/widgets/image_picker/image_load_error_content.dart';
import '../../presentation/widgets/modal/base_bottom_sheet_widget.dart';
import 'package:image/image.dart' as img;

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<List<File>> addImageFromGallery(
      {required BuildContext context}) async {
    // Navigator.pop(context);
    List<File> newFilesList = [];
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      var totalSize = 0.0;
      for (var image in images) {
        final imageTemp = File(image.path);
        int sizeInBytes = imageTemp.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb > 10) {
          BaseBottomSheetWidget(
            context: context,
            child: const ImageLoadErrorContent(),
          ).show();
          continue;
        }
        totalSize += sizeInMb;
        if (totalSize > 32) {
          BaseBottomSheetWidget(
            context: context,
            child: const ImageLoadErrorContent(),
          ).show();
          continue;
        }
        newFilesList.add(imageTemp);
      }
      // bloc.updateClaimDraftImages(newFilesList);
    }
    return newFilesList;
  }

  Future<List<File>> addImageFromCamera({required BuildContext context}) async {
    List<File> newFilesList = [];
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      final imageTemp = await _deleteImageRotated(File(photo.path));
      int sizeInBytes = imageTemp.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 10) {
        BaseBottomSheetWidget(
          context: context,
          child: const ImageLoadErrorContent(),
        ).show();
        return [];
      }

      newFilesList.add(imageTemp);

      await _saveImageToGallery(imageTemp);
    }
    return newFilesList;
  }

  Future<void> _saveImageToGallery(File image) async {
    final bool needSave = sl.get<SettingsRepository>().getSavePhoto();
    if (needSave) {
      try {
        await GallerySaver.saveImage(
          image.path,
          albumName: 'ФК ПУЛЬС',
        );
      } catch (e) {
        L.e('Error saving image to gallery: $e');
      }
    }
    return;
  }

  Future<File> _deleteImageRotated(File image) async {
    final img.Image? imageFile = img.decodeImage(image.readAsBytesSync());
    if (imageFile != null) {
      final img.Image orientedImage = img.bakeOrientation(imageFile);
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final File tempFile = File('$tempPath/${_generateRandomImageName()}');
      await tempFile.writeAsBytes(img.encodeJpg(orientedImage));
      return tempFile;
    }
    return image;
  }

  String _generateRandomImageName() {
    final int random = DateTime.now().millisecondsSinceEpoch;
    return 'photo_$random.jpg';
  }
}
