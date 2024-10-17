import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/route_manager/names.dart';

// ignore: must_be_immutable
class ArticleListScreen extends StatelessWidget {
  String title;
  ArticleListScreen({required this.title, Key? key}) : super(key: key);

  ListArticleController listArticleController =
      Get.put(ListArticleController());
  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: appBar(title),
        body: Padding(
          padding: EdgeInsets.all(Dimens.small),
          child: SizedBox(
            child: Obx(
              () => !singleArticleController.loading.value
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: listArticleController.articleList.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: (() async {
                            await singleArticleController.getArticleInfo(
                                listArticleController.articleList[index].id);
                            Get.toNamed(NamedRoute.routeSingleArticle);
                          }),
                          child: Padding(
                            padding: EdgeInsets.all(Dimens.small),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Get.height / 6,
                                  width: Get.width / 3,
                                  child: CachedNetworkImage(
                                    imageUrl: listArticleController
                                        .articleList[index].image!,
                                    imageBuilder: (((context, imageProvider) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(Dimens.medium)),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover)),
                                      );
                                    })),
                                    placeholder: ((context, url) {
                                      return const Loading();
                                    }),
                                    errorWidget: ((context, url, error) {
                                      return Icon(
                                          Icons.image_not_supported_outlined,
                                          size: Dimens.xlarge - 14,
                                          color: SolidColors.greyColor);
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimens.medium,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Get.width / 2,
                                      child: Text(
                                        listArticleController
                                            .articleList[index].title!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimens.medium,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          listArticleController
                                              .articleList[index].author!,
                                          style: textTheme.bodySmall,
                                        ),
                                        SizedBox(
                                          width: Dimens.medium + 4,
                                        ),
                                        Text(
                                          listArticleController
                                                  .articleList[index].view! +
                                              MyStrings.visit,
                                          style: textTheme.bodySmall,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                  : const Loading(),
            ),
          ),
        ),
      ),
    );
  }
}
