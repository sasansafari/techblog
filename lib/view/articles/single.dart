import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/articles/articel_list_sceen.dart';

// ignore: must_be_immutable
class Single extends StatelessWidget {
  Single({Key? key}) : super(key: key);

  var singleArticleController = Get.find<SingleArticleController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => singleArticleController.articleInfoModel.value.title == null
              ? SizedBox(height: Get.height, child: const Loading())
              : singleArticleController.loading.value 
                  ? const Loading()
                  : Column(children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: singleArticleController
                                .articleInfoModel.value.image!,
                            imageBuilder: ((context, imageProvider) =>
                                Image(image: imageProvider)),
                            placeholder: ((context, url) => const Loading()),
                            errorWidget: ((context, url, error) => Image.asset(
                                Assets.images.singlePlaceHolder.path)),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 60,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        end: Alignment.bottomCenter,
                                        begin: Alignment.topCenter,
                                        colors: GradientColors
                                            .singleAppbarGradiant)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: (() => Get.back()),
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    GestureDetector(
                                      onTap: () {
                                        /// will added to your bookmark list
                                      },
                                      child: const Icon(
                                        Icons.bookmark_border_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await Share.share(
                                            singleArticleController
                                                .articleInfoModel.value.title!);
                                      },
                                      child: const Icon(
                                        Icons.share,
                                        size: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          singleArticleController.articleInfoModel.value.title!,
                          maxLines: 2,
                          style: textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image(
                              image:
                                  Image.asset(Assets.images.profileAvatar.path)
                                      .image,
                              height: 50,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              singleArticleController
                                  .articleInfoModel.value.author!,
                              style: textTheme.headlineMedium,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              singleArticleController
                                  .articleInfoModel.value.createdAt!,
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HtmlWidget(
                          singleArticleController
                              .articleInfoModel.value.content!,
                          textStyle: textTheme.headlineSmall,
                          enableCaching: true,
                          onLoadingBuilder:
                              ((context, element, loadingProgress) =>
                                  const Loading()),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      tags(textTheme),
                      const SizedBox(
                        height: 25,
                      ),
                      similar(textTheme)
                    ]),
        ),
      ),
    ));
  }

  Widget tags(textTheme) {
    return Padding(
      padding: EdgeInsets.only(right: Get.width * 0.03),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: singleArticleController.tagList.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () async {
                  var tagId = singleArticleController.tagList[index].id!;
                  await Get.find<ListArticleController>()
                      .getArticleListWithTagsId(tagId);
                  String tagName =
                      singleArticleController.tagList[index].title!;
                  Get.to(ArticleListScreen(
                    title: tagName,
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    height: 30,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        color: Colors.grey),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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

  Widget similar(textheme) {
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
                      padding: const EdgeInsets.all(8.0),
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
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
                              errorWidget: ((context, url, error) => const Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 50,
                                    color: Colors.grey,
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
                                            .relatedList[index].author ??
                                        "ناشناس",
                                    style: textheme.subtitle1,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        singleArticleController
                                            .relatedList[index].view!,
                                        style: textheme.subtitle1,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Icon(
                                        Icons.remove_red_eye_sharp,
                                        color: Colors.white,
                                        size: 16,
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
}
