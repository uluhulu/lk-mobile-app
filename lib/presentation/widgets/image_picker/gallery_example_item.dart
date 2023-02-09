import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/theme/elements/theme_data.dart';

class GalleryItem extends StatelessWidget {
  const GalleryItem({
    Key? key,
    required this.file,
    required this.width,
    required this.height,
    required this.onTap,
    required this.onDelete,
    required this.isDeleted,
  }) : super(key: key);

  final File file;
  final double width;
  final double height;

  final GestureTapCallback onTap;

  final Function() onDelete;
  // final Function(ClaimDraftFile image) onDeleteClaimDraftFile;
  final bool isDeleted;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: Image.file(
                file,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          isDeleted
              ? Positioned(
                  top: 4,
                  right: -4,
                  // alignment: Alignment.topRight,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor:
                          MaterialStateProperty.all(myColors.whiteColor),
                      shape: MaterialStateProperty.all<CircleBorder>(
                        const CircleBorder(
                            // borderRadius: BorderRadius.circular(24.0),
                            ),
                      ),
                      // shape:  CircleBorder(),
                    ),
                    onPressed: () => onDelete(),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                        'assets/icon/trash_empty.svg',
                        color: myColors.errorColor,
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
