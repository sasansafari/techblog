
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/component/widgets/main_widget.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/view/articles/articel_list_sceen.dart';
import 'see_more_podcast_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  }) : super(key: key);

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;
  @override
  Widget build(BuildContext context) {
    return Obx(() => homeScreenController.loading.value == false
        ? RefreshIndicator(
            // ignore: deprecated_member_use
            color: Theme.of(context).accentColor,
            onRefresh: () {
              return homeScreenController.getHomeItems();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, Dimens.medium, 0, 0),
                  child: Column(
                    children: [
                      poster(size, textTheme),
                      SizedBox(
                        height: Dimens.medium,
                      ),
                      tag(textTheme, bodyMargin),
                      SizedBox(
                        height: Dimens.large,
                      ),
                      GestureDetector(
                          onTap: () => Get.to(ArticleListScreen(
                                title: MyStrings.titleArticleText,
                              )),
                          child: SeeMoreBlog(
                            bodyMargin: bodyMargin,
                            textTheme: textTheme,
                            title: MyStrings.viewHotestBlog,
                          )),
                      topVisited(size, textTheme, bodyMargin),
                      SizedBox(
                        height: Dimens.large,
                      ),
                      SeeMorePodcast(
                          bodyMargin: bodyMargin, textTheme: textTheme),
                      topPodcasts(size, textTheme, bodyMargin),
                      SizedBox(
                        height: Dimens.xlarge + 36,
                      )
                    ],
                  )),
            ),
          )
        : const Loading());
  }
}
