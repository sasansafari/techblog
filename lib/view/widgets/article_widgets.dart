import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

class ArticleEmptyState extends StatelessWidget {
  const ArticleEmptyState({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
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
}

// ignore: must_be_immutable
class Cats extends StatelessWidget {
  Cats(
      {Key? key,
      required this.homeScreenController,
      required this.manageArticleController,
      required this.textTheme})
      : super(key: key);

  final HomeScreenController homeScreenController;
  final ManageArticleController manageArticleController;
  TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 1.7,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: homeScreenController.tagsList.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () async {
              manageArticleController.articleInfoModel.update((val) {
                val?.catName = homeScreenController.tagsList[index].title!;
                val?.catId = homeScreenController.tagsList[index].id!;
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
                        style: textTheme.displayMedium,
                      ),
                    )),
              ),
            ),
          );
        }),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }
}

class Similar extends StatelessWidget {
  const Similar({
    Key? key,
    required this.singleArticleController,
    required this.textheme,
  }) : super(key: key);

  final SingleArticleController singleArticleController;
  final TextTheme textheme;

  @override
  Widget build(BuildContext context) {
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
                padding:
                    EdgeInsets.only(right: index == 0 ? Get.width / 15 : 15),
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
                                    foregroundDecoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        gradient: LinearGradient(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    singleArticleController
                                        .relatedList[index].author!,
                                    style: textheme.titleMedium,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        singleArticleController
                                            .relatedList[index].view!,
                                        style: textheme.titleMedium,
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
                        ))
                  ],
                ),
              ),
            );
          })),
    );
  }
}

class Tags extends StatelessWidget {
  const Tags({
    Key? key,
    required this.singleArticleController,
    required this.textheme,
  }) : super(key: key);

  final SingleArticleController singleArticleController;
  final TextTheme textheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  height: Dimens.large,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Colors.grey),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(Dimens.small, Dimens.small,
                          Dimens.small, Dimens.small),
                      child: Text(
                        singleArticleController.tagList[index].title!,
                        style: textheme.displayMedium,
                      )),
                ),
              ),
            );
          })),
    );
  }
}
