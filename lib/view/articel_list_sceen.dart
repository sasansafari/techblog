import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/list_article_controller.dart';
import 'package:tec/controller/single_article_controller.dart';
import 'package:tec/view/single.dart';

// ignore: must_be_immutable
class ArticleListScreen extends StatelessWidget {
  String title;
  ArticleListScreen({required this.title,Key? key}) : super(key: key);
 
  ListArcticleController listarcticleController =
      Get.put(ListArcticleController());
  SingleArcticleController singleArcticleController =
      Get.put(SingleArcticleController());
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
              () => !singleArcticleController.loading.value ? ListView.builder(
                 scrollDirection: Axis.vertical,
                itemCount: listarcticleController.articleList.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: (() async{
                      

                      await singleArcticleController.getArticleInfo(listarcticleController.articleList[index].id);

                      Get.to(Single());
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
                              imageUrl: listarcticleController
                                  .articleList[index].image!,
                              imageBuilder: (((context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
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
                                  listarcticleController
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
                                    listarcticleController
                                        .articleList[index].author!,
                                    style: textTheme.caption,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    listarcticleController
                                            .articleList[index].view! +
                                        " بازدید ",
                                    style: textTheme.caption,
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
              ) : const Loading(),
            ),
          ),
        ),
      ),
    );
  }
}
