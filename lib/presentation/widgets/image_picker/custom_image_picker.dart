import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mkk/presentation/widgets/image_picker/gallery_example_item.dart';
import 'package:mkk/presentation/widgets/image_picker/image_picker_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:path/path.dart';

import '../../../data/api/claim_drafts/claim_draft_attachments/claim_draft_file.dart';

class CustomImageAndFilesPicker extends StatelessWidget {
  final Function() onAddButton;
  final Function(File image) onDeleteClaimFile;
  final Function(ClaimDraftFile image) onDeleteClaimDraftFile;
  final List<File> claimFile;
  List<ClaimDraftFile>? claimDraftFileItems;
  final bool showPicker;
  final bool isDeleted;
  final double width;
  final double height;

  CustomImageAndFilesPicker({
    Key? key,
    required this.onAddButton,
    required this.onDeleteClaimFile,
    required this.claimFile,
    required this.showPicker,
    this.claimDraftFileItems,
    this.isDeleted = false,
    this.width = 98.0,
    this.height = 98.0,
    required this.onDeleteClaimDraftFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        claimDraftFileItems != null
            ? GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 9,
                  crossAxisCount: 3,
                  mainAxisSpacing: 9.5,
                ),
                itemCount: showPicker
                    ? claimDraftFileItems!.length + 1
                    : claimDraftFileItems!.length,
                itemBuilder: (context, index) {
                  // return Container(width: 100, height: 100, color: Colors.red,);
                  return showPicker && index == claimDraftFileItems!.length
                      ? ImagePickerButton(
                          onPressed: () {
                            return onAddButton;
                          },
                        )
                      : GalleryItem(
                          width: width,
                          height: height,
                          file: claimDraftFileItems![index].attachment,
                          onTap: () {
                            openClaimDraft(context, index);
                          },
                          onDelete: () => onDeleteClaimDraftFile(
                              claimDraftFileItems![index]),
                          isDeleted: isDeleted,
                        );
                },
              )
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 9,
                  crossAxisCount: 3,
                  mainAxisSpacing: 9.5,
                ),
                itemCount: showPicker ? claimFile.length + 1 : claimFile.length,
                itemBuilder: (context, index) {
                  return showPicker && index == claimFile.length
                      ? ImagePickerButton(
                          onPressed: () => onAddButton,
                        )
                      : GalleryItem(
                          width: width,
                          height: height,
                          file: claimFile[index],
                          onTap: () {
                            open(context, index);
                          },
                          onDelete: () => onDeleteClaimFile(claimFile[index]),
                          isDeleted: isDeleted,
                        );
                },
              ),
      ],
    );
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          claimGalleryItems: claimFile,
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
          initialIndex: index,
          // scrollDirection: verticalGallery ? Axis.vertical : Axis.horizontal,
        ),
      ),
    );
  }

  void openClaimDraft(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          claimDraftGalleryItems: claimDraftFileItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
          initialIndex: index, claimGalleryItems: [],
          // scrollDirection: verticalGallery ? Axis.vertical : Axis.horizontal,
        ),
      ),
    );
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.claimGalleryItems,
    this.claimDraftGalleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<File> claimGalleryItems;
  final List<ClaimDraftFile>? claimDraftGalleryItems;

  // final List<File> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.claimDraftGalleryItems != null
                  ? widget.claimDraftGalleryItems!.length
                  : widget.claimGalleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Align(alignment: Alignment.topCenter, child: _appBar(context)),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: 72,
                height: MediaQuery.of(context).size.height * 0.11,
                color: Colors.white.withOpacity(0.7),
                // color: Colors.red,
              ),
            ),
            Positioned(
              left: 16,
              bottom: 29,
              width: 250,
              child: Text(
                basename(
                  widget.claimDraftGalleryItems != null
                      ? widget
                          .claimDraftGalleryItems![currentIndex].attachment.path
                      : widget.claimGalleryItems[currentIndex].path,
                ),
                textWidthBasis: TextWidthBasis.parent,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.black, fontSize: 12.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      color: Colors.white.withOpacity(0.7),
      alignment: Alignment.bottomCenter,
      child: Row(
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              'assets/icon/arrow-left-1.svg',
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Expanded(
            child: Text(
                widget.claimDraftGalleryItems != null
                    ? "${currentIndex + 1} из ${widget.claimDraftGalleryItems!.length}"
                    : "${currentIndex + 1} из ${widget.claimGalleryItems.length}",
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.black,
                    )),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final File item = widget.claimDraftGalleryItems != null
        ? widget.claimDraftGalleryItems![index].attachment
        : widget.claimGalleryItems[index];
    return PhotoViewGalleryPageOptions.customChild(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.76,
          child: Image.file(
            item,
          ),
        ),
        childSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.76),
        basePosition: Alignment(0.0, 0.1));
  }
}
