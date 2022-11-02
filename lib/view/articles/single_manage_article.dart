import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/manage_article_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/controller/file_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/services/pick_file.dart';
import 'package:tec/view/articles/articel_list_sceen.dart';

// ignore: must_be_immutable
class SingleManageArticle extends StatelessWidget {
  SingleManageArticle({Key? key}) : super(key: key);

  var manageArticleController = Get.find<ManageArticleController>();
  FilePickerController filePickerController = Get.put(FilePickerController());


  getTitle(){

    Get.defaultDialog(
      title: "عنوان مقاله",
      titleStyle: const TextStyle(
          color: SolidColors.scafoldBg
        ),
      content:  TextField(
        controller: manageArticleController.titleTextEditingController,
        keyboardType: TextInputType.text,
          style: const TextStyle(
          color: SolidColors.colorTitle
        ),
        decoration:   const InputDecoration(

          hintText: 'اینجا بنویس'
        ),
      ),
       backgroundColor: SolidColors.primeryColor,
        radius: 8,
        confirm: ElevatedButton(onPressed: (() {
          manageArticleController.updateTitle();
          Get.back();

        }), child: const Text('ثبت'))
    
    );

  }

  @override
  Widget build(BuildContext context) {
    var textheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => Column(children: [
            Stack(
              children: [
                SizedBox(
                  width: Get.width,
                  height: Get.height/3,
                  child:  filePickerController.file.value.name == 'nothing'
                    ? CachedNetworkImage(
                        imageUrl: manageArticleController
                            .articleInfoModel.value.image!,
                        imageBuilder: ((context, imageProvider) =>
                            Image(image: imageProvider)),
                        placeholder: ((context, url) => const Loading()),
                        errorWidget: ((context, url, error) =>
                            Image.asset(Assets.images.singlePlaceHolder.path,fit: BoxFit.cover,)),
                      )
                    : Image.file(
                        File(filePickerController.file.value.path!),
                        fit: BoxFit.cover,
                      ),
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
                              colors: GradiantColors.singleAppbarGradiant)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          //pick file
                          await pickFile();
                        },
                        child: Container(
                          height: 30,
                          width: Get.width / 3,
                          decoration: const BoxDecoration(
                              color: SolidColors.primeryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "انتخاب تصویر",
                                style: textheme.headline2,
                              ),
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 24,
            ),

            GestureDetector(
              onTap: (){

                getTitle();
              },
              child: SeeMoreBlog(
                bodyMargin: Dimens.halfBodyMargin,
                textTheme: textheme,
                title: 'ویرایش عنوان مقاله',
              ),
            ),

            Padding(
              padding: EdgeInsets.all(Dimens.halfBodyMargin),
              child: Text(
                manageArticleController.articleInfoModel.value.title!,
                maxLines: 2,
                style: textheme.titleLarge,
              ),
            ),
            SeeMoreBlog(
              bodyMargin: Dimens.halfBodyMargin,
              textTheme: textheme,
              title: 'ویرایش متن اصلی مقاله',
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HtmlWidget(
                manageArticleController.articleInfoModel.value.content!,
                textStyle: textheme.headline5,
                enableCaching: true,
                onLoadingBuilder: ((context, element, loadingProgress) =>
                    const Loading()),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SeeMoreBlog(
              bodyMargin: Dimens.halfBodyMargin,
              textTheme: textheme,
              title: 'انتخاب دسته بندی ',
            ),

            // tags(textheme),
          ]),
        ),
      ),
    ));
  }

  Widget tags(textheme) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: manageArticleController.tagList.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () async {
                var tagId = manageArticleController.tagList[index].id!;
                await Get.find<ListArcticleController>()
                    .getArticleListWithTagsId(tagId);
                String tagName = manageArticleController.tagList[index].title!;
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
                        manageArticleController.tagList[index].title!,
                        style: textheme.headline2,
                      )),
                ),
              ),
            );
          })),
    );
  }
}
