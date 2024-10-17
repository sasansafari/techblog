import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/view/widgets/article_widgets.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/controller/article/manage_article_controller.dart';
import 'package:tec/route_manager/names.dart';

import '../../constant/my_strings.dart';

// ignore: must_be_immutable
class ManageArticle extends StatelessWidget {
  ManageArticle({Key? key}) : super(key: key);

  var articleManageController = Get.find<ManageArticleController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      appBar: appBar(MyStrings.titleAppBarManageArticle),
      body: Obx(
        () => articleManageController.loading.value
            ? const Loading()
            : articleManageController.articleList.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: articleManageController.articleList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: (() async {
                          //route to single manage
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
                                  imageUrl: articleManageController
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
                                      articleManageController
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
                                        articleManageController
                                            .articleList[index].author!,
                                        style: textTheme.bodySmall,
                                      ),
                                      SizedBox(
                                        width: Dimens.medium + 4,
                                      ),
                                      Text(
                                        articleManageController
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
                : ArticleEmptyState(
                    textTheme: textTheme,
                  ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: Dimens.large),
        child: Padding(
          padding: EdgeInsets.all(Dimens.small),
          child: ElevatedButton(
            style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(
                    Size(Get.width / 3, Dimens.xlarge - 8))),
            onPressed: () {
              Get.toNamed(NamedRoute.singleManageArticle);
            },
            child: Text(MyStrings.textManageArticle),
          ),
        ),
      ),
    ));
  }
}
