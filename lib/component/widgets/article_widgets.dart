

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/manage_article_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/articles/articel_list_sceen.dart';

Widget articleEmptyState(TextTheme textTheme) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.images.emptyState.path,
          height: Dimens.xlarge + 36,
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimens.medium),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: MyStrings.articleEmpty,
              style: textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget cats(textheme) {
  var homeScreenController = Get.find<HomeScreenController>();
  var manageArticleController = Get.find<ManageArticleController>();
  return SizedBox(
    height: Get.height / 1.7,
    child: GridView.builder(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      scrollDirection: Axis.vertical,
      itemCount: homeScreenController.tagsList.length,
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: () async {
            manageArticleController.articleInfoModel.update((val) {
              val?.catId = homeScreenController.tagsList[index].id!;
              val?.catName = homeScreenController.tagsList[index].title!;
            });

            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: Dimens.small),
            child: Container(
              height: Dimens.large - 2,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  color: SolidColors.primaryColor),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      Dimens.small, Dimens.small, Dimens.small, Dimens.small),
                  child: Center(
                    child: Text(
                      homeScreenController.tagsList[index].title!,
                      style: textheme.headline2,
                    ),
                  )),
            ),
          ),
        );
      }),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
    ),
  );
}


Widget similar(textheme) {
  var singleArticleController = Get.find<SingleArticleController>();
  return SizedBox(
    height: Get.height / 3.5,
    child: ListView.builder(
        itemCount: singleArticleController.relatedList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          //blog item
          return GestureDetector(
            onTap: (() {
              singleArticleController.getArticleInfo(
                  singleArticleController.relatedList[index].id);
            }),
            child: Padding(
              padding: EdgeInsets.only(right: index == 0 ? Get.width / 15 : 15),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(Dimens.small),
                    child: SizedBox(
                      height: Get.height / 5.3,
                      width: Get.width / 2.4,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: singleArticleController
                                .relatedList[index].image!,
                            imageBuilder: ((context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Dimens.medium)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                  foregroundDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimens.medium)),
                                      gradient: const LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: GradientColors.blogPost)),
                                )),
                            placeholder: ((context, url) => const Loading()),
                            errorWidget: ((context, url, error) => Icon(
                                  Icons.image_not_supported_outlined,
                                  size: Dimens.xlarge - 14,
                                  color: SolidColors.greyColor,
                                )),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  singleArticleController
                                          .relatedList[index].author ??
                                      MyStrings.anonymousText,
                                  style: textheme.subtitle1,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      singleArticleController
                                          .relatedList[index].view!,
                                      style: textheme.subtitle1,
                                    ),
                                    SizedBox(
                                      width: Dimens.small,
                                    ),
                                    Icon(
                                      Icons.remove_red_eye_sharp,
                                      color: SolidColors.lightIcon,
                                      size: Dimens.medium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 2.4,
                    child: Text(
                      singleArticleController.relatedList[index].title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            ),
          );
        })),
  );
}

Widget tags(textTheme) {
  var singleArticleController = Get.find<SingleArticleController>();
  return Padding(
    padding: EdgeInsets.only(right: Get.width * 0.03),
    child: SizedBox(
      height: Dimens.large + 3,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: singleArticleController.tagList.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () async {
                var tagId = singleArticleController.tagList[index].id!;
                await Get.find<ListArticleController>()
                    .getArticleListWithTagsId(tagId);
                String tagName = singleArticleController.tagList[index].title!;
                Get.to(ArticleListScreen(
                  title: tagName,
                ));
              },
              child: Padding(
                padding: EdgeInsets.only(left: Dimens.small),
                child: Container(
                  height: Dimens.large - 2,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.medium + 8)),
                      color: SolidColors.greyColor),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(Dimens.small, Dimens.small,
                          Dimens.small, Dimens.small),
                      child: Text(
                        singleArticleController.tagList[index].title!,
                        style: textTheme.headline2,
                      )),
                ),
              ),
            );
          })),
    ),
  );
}