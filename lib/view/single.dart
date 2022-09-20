import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/list_article_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/articel_list_sceen.dart';

import '../controller/single_article_controller.dart';

// ignore: must_be_immutable
class Single extends StatelessWidget {
  Single({Key? key}) : super(key: key);

  var singleArcticleController = Get.find<SingleArcticleController>();

  @override
  Widget build(BuildContext context) {
    var textheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => singleArcticleController.articleInfoModel.value.title == null
              ? SizedBox(height: Get.height, child: const Loading())
              : Column(children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: singleArcticleController
                            .articleInfoModel.value.image!,
                        imageBuilder: ((context, imageProvider) =>
                            Image(image: imageProvider)),
                        placeholder: ((context, url) => const Loading()),
                        errorWidget: ((context, url, error) =>
                            Image.asset(Assets.images.singlePlaceHolder.path)),
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
                                    colors:
                                        GradiantColors.singleAppbarGradiant)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Expanded(child: SizedBox()),
                                Icon(
                                  Icons.bookmark_border_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
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
                      singleArcticleController.articleInfoModel.value.title!,
                      maxLines: 2,
                      style: textheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image(
                          image: Image.asset(Assets.images.profileAvatar.path)
                              .image,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          singleArcticleController
                              .articleInfoModel.value.author!,
                          style: textheme.headline4,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          singleArcticleController
                              .articleInfoModel.value.createdAt!,
                          style: textheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HtmlWidget(
                      singleArcticleController.articleInfoModel.value.content!,
                      textStyle: textheme.headline5,
                      enableCaching: true,
                      onLoadingBuilder: ((context, element, loadingProgress) =>
                          const Loading()),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  tags(textheme),
                  const SizedBox(
                    height: 25,
                  ),
                  simmilar(textheme)
                ]),
        ),
      ),
    ));
  }

  Widget tags(textTheme) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: singleArcticleController.tagList.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () async {
                var tagId = singleArcticleController.tagList[index].id!;
                await Get.find<ListArticleController>()
                    .getArticleListWithTagsId(tagId);
                String tagName = singleArcticleController.tagList[index].title!;
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
                        singleArcticleController.tagList[index].title!,
                        style: textTheme.headline2,
                      )),
                ),
              ),
            );
          })),
    );
  }

  Widget simmilar(textTheme) {
    return SizedBox(
      height: Get.height / 3.5,
      child: ListView.builder(
          itemCount: singleArcticleController.releatedList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            //blog item
            return GestureDetector(
              onTap: (() {
                singleArcticleController.getArticleInfo(
                    singleArcticleController.releatedList[index].id);
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
                              imageUrl: singleArcticleController
                                  .releatedList[index].image!,
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
                                            colors: GradiantColors.blogPost)),
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
                                    singleArcticleController
                                        .releatedList[index].author!,
                                    style: textTheme.subtitle1,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        singleArcticleController
                                            .releatedList[index].view!,
                                        style: textTheme.subtitle1,
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
                          singleArcticleController.releatedList[index].title!,
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
