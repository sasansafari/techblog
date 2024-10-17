import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/view/widgets/article_widgets.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/gen/assets.gen.dart';

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
                                height: Dimens.xlarge - 4,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        end: Alignment.bottomCenter,
                                        begin: Alignment.topCenter,
                                        colors: GradientColors
                                            .singleAppbarGradiant)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: Dimens.medium + 4,
                                    ),
                                    GestureDetector(
                                      onTap: (() => Get.back()),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: SolidColors.lightIcon,
                                        size: Dimens.medium + 8,
                                      ),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    GestureDetector(
                                      onTap: () {
                                        /// will added to your bookmark list
                                      },
                                      child: Icon(
                                        Icons.bookmark_border_rounded,
                                        color: SolidColors.lightIcon,
                                        size: Dimens.medium + 8,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimens.medium + 4,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await Share.share(
                                            singleArticleController
                                                .articleInfoModel.value.title!);
                                      },
                                      child: Icon(
                                        Icons.share,
                                        size: Dimens.medium + 8,
                                        color: SolidColors.lightIcon,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimens.medium + 4,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimens.small),
                        child: Text(
                          singleArticleController.articleInfoModel.value.title!,
                          maxLines: 2,
                          style: textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimens.small),
                        child: Row(
                          children: [
                            Image(
                              image:
                                  Image.asset(Assets.images.profileAvatar.path)
                                      .image,
                              height: Dimens.xlarge - 14,
                            ),
                            SizedBox(
                              width: Dimens.medium,
                            ),
                            Text(
                              singleArticleController
                                  .articleInfoModel.value.author!,
                              style: textTheme.headlineMedium,
                            ),
                            SizedBox(
                              width: Dimens.medium,
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
                        padding: EdgeInsets.all(Dimens.small),
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
                      SizedBox(
                        height: Dimens.medium + 9,
                      ),
                      Tags(
                        textheme: textTheme,
                        singleArticleController: singleArticleController,
                      ),
                      SizedBox(
                        height: Dimens.medium + 9,
                      ),
                      Similar(
                        textheme: textTheme,
                        singleArticleController: singleArticleController,
                      )
                    ]),
        ),
      ),
    ));
  }
}
