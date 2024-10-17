import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/view/widgets/article_widgets.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/article/manage_article_controller.dart';
import 'package:tec/controller/file_controller.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/services/pick_file.dart';
import 'article_content_editor.dart';

// ignore: must_be_immutable
class SingleManageArticle extends StatelessWidget {
  SingleManageArticle({
    Key? key,
  }) : super(key: key);

  var manageArticleController = Get.find<ManageArticleController>();
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  FilePickerController filePickerController = Get.put(FilePickerController());

  getTitle() {
    Get.defaultDialog(
        title: MyStrings.titleDialogSingleManageArticle,
        titleStyle: const TextStyle(color: SolidColors.scaffoldBg),
        content: TextField(
          controller: manageArticleController.titleTextEditingController,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: SolidColors.colorTitle),
          decoration:
              InputDecoration(hintText: MyStrings.hintTextSingleManageArticle),
        ),
        backgroundColor: SolidColors.primaryColor,
        radius: 8,
        confirm: ElevatedButton(
            onPressed: (() {
              manageArticleController.updateTitle();
              Get.back();
            }),
            child: Text(MyStrings.save)));
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
                  height: Get.height / 3,
                  child: filePickerController.file.value.name == 'nothing'
                      ? CachedNetworkImage(
                          imageUrl: manageArticleController
                              .articleInfoModel.value.image!,
                          imageBuilder: ((context, imageProvider) =>
                              Image(image: imageProvider)),
                          placeholder: ((context, url) => const Loading()),
                          errorWidget: ((context, url, error) => Image.asset(
                                Assets.images.singlePlaceHolder.path,
                                fit: BoxFit.cover,
                              )),
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
                      height: Dimens.xlarge - 4,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: GradientColors.singleAppbarGradiant)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: Dimens.medium + 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: SolidColors.lightIcon,
                              size: Dimens.medium + 8,
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
                          height: Dimens.large - 2,
                          width: Get.width / 3,
                          decoration: BoxDecoration(
                              color: SolidColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Dimens.small + 4),
                                topRight: Radius.circular(Dimens.small + 4),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                MyStrings.selectImage,
                                style: textheme.displayMedium,
                              ),
                              const Icon(
                                Icons.add,
                                color: SolidColors.lightIcon,
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: Dimens.medium + 8,
            ),

            GestureDetector(
              onTap: () {
                getTitle();
              },
              child: SeeMoreBlog(
                bodyMargin: Dimens.halfBodyMargin,
                textTheme: textheme,
                title: MyStrings.editTitleArticle,
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
            GestureDetector(
              onTap: () => Get.to(() => ArticleContentEditor()),
              child: SeeMoreBlog(
                bodyMargin: Dimens.halfBodyMargin,
                textTheme: textheme,
                title: MyStrings.editMainTextArticle,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(Dimens.small),
              child: HtmlWidget(
                manageArticleController.articleInfoModel.value.content!,
                textStyle: textheme.headlineSmall,
                enableCaching: true,
                onLoadingBuilder: ((context, element, loadingProgress) =>
                    const Loading()),
              ),
            ),
            SizedBox(
              height: Dimens.medium + 9,
            ),
            GestureDetector(
              onTap: () {
                chooseCatsBottomSheet(textheme);
              },
              child: SeeMoreBlog(
                bodyMargin: Dimens.halfBodyMargin,
                textTheme: textheme,
                title: MyStrings.selectCategory,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Dimens.halfBodyMargin),
              child: Text(
                manageArticleController.articleInfoModel.value.catName == null
                    ? MyStrings.noCategorySelected
                    : manageArticleController.articleInfoModel.value.catName!,
                maxLines: 2,
                style: textheme.titleLarge,
              ),
            ),

            ElevatedButton(
                onPressed: (() async =>
                    await manageArticleController.storeArticle()),
                child: Padding(
                  padding: EdgeInsets.all(Dimens.small),
                  child: Text(manageArticleController.loading.value
                      ? MyStrings.wait
                      : MyStrings.sendText),
                ))
            // tags(textheme),
          ]),
        ),
      ),
    ));
  }

  chooseCatsBottomSheet(TextTheme textTheme) {
    Get.bottomSheet(
        Container(
          height: Get.height / 1.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.medium + 4),
                topRight: Radius.circular(Dimens.medium + 4)),
          ),
          child: Padding(
            padding: EdgeInsets.all(Dimens.small),
            child: SingleChildScrollView(
              child: Column(children: [
                Text(MyStrings.selectCategory),
                SizedBox(
                  height: Dimens.small,
                ),
                Cats(
                  textTheme: textTheme,
                  homeScreenController: homeScreenController,
                  manageArticleController: manageArticleController,
                )
              ]),
            ),
          ),
        ),
        isScrollControlled: true,
        persistent: true);
  }
}
