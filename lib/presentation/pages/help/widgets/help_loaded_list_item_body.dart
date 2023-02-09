import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/app_routes.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/help/navigation_claims_filter_page_params.dart';
import '../../../../data/api/help/entity/help_entity.dart';

class HelpLoadedListItemBody extends StatelessWidget {
  final List<Content> childContent;
  final String title;

  const HelpLoadedListItemBody(
      {Key? key, required this.childContent, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        // return GestureDetector(
        //   onTap: () => {
        //     Navigator.of(context).pushNamed(
        //       AppRoutes.helpDetail,
        //       arguments: HelpDetailParams(
        //         content: childContent![i],
        //         otherContentItems: getOtherItems(childContent, i), helpTitle: title,
        //       ),
        //     ),
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //       vertical: 12.0,
        //     ),
        //     child: Row(
        //       children: [
        //         Text(
        //           childContent![i].name ?? "",
        //           style: Theme.of(context).textTheme.bodyText1,
        //         ),
        //         const Spacer(),
        //         SvgPicture.asset("assets/icon/arrow-right.svg", color: MyTheme.of(context).greyIconColor, width: 20,),
        //       ],
        //     ),
        //   ),
        // );
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => {
            Navigator.of(context).pushNamed(
              AppRoutes.helpDetail,
              arguments: HelpDetailParams(
                content: childContent[i],
                otherContentItems: getOtherItems(childContent, i),
                helpTitle: title,
              ),
            ),
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Text(
                  childContent[i].name ?? "",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const Spacer(),
                SvgPicture.asset(
                  "assets/icon/arrow-right.svg",
                  color: MyTheme.of(context).greyIconColor,
                  width: 20,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(
      ),
      itemCount: childContent.length,
    );
  }

  List<Content> getOtherItems(List<Content> childContent, int index) {
    var list = [...childContent];
    list.removeAt(index);
    return list;
  }
}
