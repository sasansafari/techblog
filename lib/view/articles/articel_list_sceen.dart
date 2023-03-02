import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tec/component/my_component.dart';
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
          padding: const EdgeInsets.all(8.0),
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
                            padding: const EdgeInsets.all(8.0),
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(16)),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover)),
                                      );
                                    })),
                                    placeholder: ((context, url) {
                                      return const Loading();
                                    }),
                                    errorWidget: ((context, url, error) {
                                      return const Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 50,
                                          color: Colors.grey);
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
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
                                    const SizedBox(
                                      height: 16,
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
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          listArticleController
                                                  .articleList[index].view! +
                                              " بازدید ",
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
