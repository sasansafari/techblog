




import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/models/fake_data/fake_data.dart';
import 'package:tec/route_manager/names.dart';

Widget topPodcasts(
  final Size size,
  final TextTheme textTheme,
  final double bodyMargin,
) {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  return SizedBox(
    height: size.height / 3.5,
    child: Obx(
      () => ListView.builder(
          itemCount: homeScreenController.topPodcasts.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            //podcast item
            return GestureDetector(
              onTap: () {
                Get.toNamed(NamedRoute.singlePodcast,
                    arguments: homeScreenController.topPodcasts[index]);
              },
              child: Padding(
                padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: size.height / 5.3,
                          width: size.width / 2.4,
                          child: CachedNetworkImage(
                            imageUrl:
                                homeScreenController.topPodcasts[index].poster!,
                            imageBuilder: ((context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimens.medium)),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                )),
                            placeholder: ((context, url) => const Loading()),
                            errorWidget: ((context, url, error) => Icon(
                  Icons.image_not_supported_outlined,
                                  size: Dimens.xlarge - 14,
                                  color: SolidColors.greyColor,
                                )),
                          )),
                    ),
                    SizedBox(
                        width: size.width / 2.4,
                        child: Text(
                          homeScreenController.topPodcasts[index].title!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ))
                  ],
                ),
              ),
            );
          })),
    ),
  );
}


Widget topVisited(
  final Size size,
  final TextTheme textTheme,
  final double bodyMargin,
) {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());
  return SizedBox(
    height: size.height / 3.5,
    child: Obx(
      () => ListView.builder(
          itemCount: homeScreenController.topVisitedList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            //blog item
            return GestureDetector(
              onTap: (() {
                singleArticleController.getArticleInfo(
                    homeScreenController.topVisitedList[index].id);
              }),
              child: Padding(
                padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Dimens.small),
                      child: SizedBox(
                        height: size.height / 5.3,
                        width: size.width / 2.4,
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: homeScreenController
                                  .topVisitedList[index].image!,
                              imageBuilder: ((context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimens.medium)),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                    foregroundDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Dimens.medium)),
                                        gradient: const LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: GradientColors.blogPost)),
                                  )),
                              placeholder: ((context, url) => const Loading()),
                              errorWidget: ((context, url, error) => Icon(
                                    Icons.image_not_supported_outlined,
                                    size: Dimens.xlarge - 14,
                                    color: SolidColors.greyColor,
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
                                    homeScreenController
                                        .topVisitedList[index].author!,
                                    style: textTheme.titleMedium,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        homeScreenController
                                            .topVisitedList[index].view!,
                                        style: textTheme.titleMedium,
                                      ),
                                      SizedBox(
                                        width: Dimens.small,
                                      ),
                                      Icon(
                                        Icons.remove_red_eye_sharp,
                                        color: SolidColors.lightIcon,
                                        size: Dimens.medium,
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
                        width: size.width / 2.4,
                        child: Text(
                          homeScreenController.topVisitedList[index].title!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ))
                  ],
                ),
              ),
            );
          })),
    ),
  );
}




Widget tag(
  final TextTheme textTheme,
  final double bodyMargin,
) {
  return SizedBox(
    height: Dimens.xlarge - 4,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tagList.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 8, index == 0 ? bodyMargin : 15, 8),
            child: MainTags(
              textTheme: textTheme,
              index: index,
            ),
          );
        })),
  );
}

Widget poster(
  final Size size,
  final TextTheme textTheme,
) {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  return Stack(
    children: [
      Container(
        width: size.width / 1.25,
        height: size.height / 4.2,
        child: CachedNetworkImage(
          imageUrl: homeScreenController.poster.value.image!,
          imageBuilder: ((context, imageProvider) => Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.medium)),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              )),
          placeholder: ((context, url) => SpinKitFadingCube(
                color: SolidColors.primaryColor,
                size: Dimens.large,
              )),
          errorWidget: ((context, url, error) => Icon(
                Icons.image_not_supported_outlined,
                size: Dimens.xlarge - 14,
                color: SolidColors.greyColor,
              )),
        ),
        foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.medium)),
            gradient: const LinearGradient(
              colors: GradientColors.homePosterCoverGradiant,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
      ),
      Positioned(
        bottom: 8,
        left: 0,
        right: 0,
        child: Column(
          children: [
            Text(
              homeScreenController.poster.value.title!,
              style: textTheme.displayLarge,
            ),
          ],
        ),
      )
    ],
  );
}