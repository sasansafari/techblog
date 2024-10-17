import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/gen/assets.gen.dart';

import '../podcast/hot_podcast_list.dart';

class SeeMorePodcast extends StatelessWidget {
  const SeeMorePodcast({
    Key? key,
    required this.bodyMargin,
    required this.textTheme,
  }) : super(key: key);

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, bottom: Dimens.small),
      child: Row(
        children: [
          ImageIcon(
            Image.asset(Assets.icons.microphon.path).image,
            color: SolidColors.seeMore,
          ),
          SizedBox(
            width: Dimens.small,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, Dimens.small, 0),
            child: GestureDetector(
              onTap: () => Get.to(HotPodcastList(
                title: MyStrings.myFavPodcast,
              )),
              child: Text(
                MyStrings.viewHotestPodCasts,
                style: textTheme.displaySmall,
              ),
            ),
          )
        ],
      ),
    );
  }
}
