import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec_blog_new/components/my_colors.dart';
import 'package:tec_blog_new/controller/delet_My_article.dart';
import 'package:tec_blog_new/controller/get_article_info.dart';
import 'package:tec_blog_new/controller/new_article_published_by_me_controller.dart';
import 'package:tec_blog_new/main.dart';

class NewArticlePublishedByMeScreen extends StatefulWidget {
  NewArticlePublishedByMeScreen({super.key});

  @override
  State<NewArticlePublishedByMeScreen> createState() =>
      _NewArticlePublishedByMeScreenState();
}

class _NewArticlePublishedByMeScreenState
    extends State<NewArticlePublishedByMeScreen> {
  NewArticlePublishedByMeController newArticlePublishedByMeController =
      Get.put(NewArticlePublishedByMeController());

  GetArticleInfoController getArticleInfoController =
      Get.put(GetArticleInfoController());

  DeleteMyArticle deleteMyArticle = Get.put(DeleteMyArticle());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Get.width / 19.5),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Get.height / 16.5,
                    width: Get.height / 16.5,
                    decoration: BoxDecoration(
                        color: MyColors.purpleAccentColor,
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'لیست مقاله ها',
                    style: textTheme.titleSmall!
                        .copyWith(color: MyColors.purpleAccentColor),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                  itemCount:
                      newArticlePublishedByMeController.newArticleList.length,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? Get.height / 19.5 : Get.height / 40,
                        bottom: index ==
                                newArticlePublishedByMeController
                                        .newArticleList.length -
                                    1
                            ? Get.height / 19.5
                            : Get.height / 40,
                      ),
                      child: Dismissible(
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            return Get.defaultDialog(
                                title: 'حذف مقاله',
                                middleText: 'آیا مطمئن هستید؟',
                                textConfirm: 'بله',
                                textCancel: 'خیر',
                                onConfirm: () async {
                                  log('article id ::' +
                                      newArticlePublishedByMeController
                                          .newArticleList[index].id);
                                  await deleteMyArticle
                                      .deletMyArticlePostMethode(
                                          articleId:
                                              newArticlePublishedByMeController
                                                  .newArticleList[index].id);

                                  newArticlePublishedByMeController.update();
                                  Navigator.of(context).pop(true);
                                });
                          }

                          return null;
                        },
                        key: Key(newArticlePublishedByMeController
                            .newArticleList[index].id),
                        background: Container(
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'حذف',
                                style: textTheme.titleSmall!
                                    .copyWith(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          newArticlePublishedByMeController
                              .newArticleList[index].id;
                          newArticlePublishedByMeController.newArticleList
                              .removeAt(index);
                          newArticlePublishedByMeController.update();
                          setState(() {});
                        },
                        child: GestureDetector(
                          onTap: () async {
                            await getArticleInfoController
                                .articleInfoGetMethode(
                                    id: newArticlePublishedByMeController
                                        .newArticleList[index].id);
                            Get.toNamed(RoutPage.articleInfoScreen,
                                arguments: newArticlePublishedByMeController
                                    .newArticleList[index].id);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width / 4.2,
                                height: Get.width / 4.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: FancyShimmerImage(
                                      imageUrl:
                                          newArticlePublishedByMeController
                                              .newArticleList[index].image,
                                      boxFit: BoxFit.cover,
                                    )),
                              ),
                              SizedBox(
                                width: Get.width / 19.5,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      newArticlePublishedByMeController
                                          .newArticleList[index].title,
                                      style: textTheme.titleSmall,
                                    ),
                                    SizedBox(
                                      height: Get.height / 68,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            newArticlePublishedByMeController
                                                .newArticleList[index].author,
                                            style: textTheme.titleSmall!
                                                .copyWith(fontSize: 12)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                              newArticlePublishedByMeController
                                                  .newArticleList[index].view,
                                              style: textTheme.titleSmall!
                                                  .copyWith(fontSize: 12)),
                                        ),
                                        Text(
                                            newArticlePublishedByMeController
                                                .newArticleList[index].catName,
                                            style: textTheme.titleSmall!
                                                .copyWith(
                                                    color: Colors.blue,
                                                    fontSize: 12)),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: Get.height / 30,
              ),
              SizedBox(
                width: Get.width / 1.36,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RoutPage.writeArticleScreen);
                    },
                    child: Text('بریم برای نوشتن یه مقاله باحال',
                        style: textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ))),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
