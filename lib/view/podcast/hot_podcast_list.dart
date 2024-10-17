import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/text_style.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/controller/podcast/single_podcast_cotroller.dart';
import '../../component/dimens.dart';
import '../../component/my_component.dart';
import '../../models/podcast_model.dart';
import '../../route_manager/names.dart';

// ignore: must_be_immutable
class HotPodcastList extends StatelessWidget {
  final String title;

  late SinglePodcastController controller;
  PodcastModel? podcastModel;
  SinglePodcastController singlePodcastController =
      Get.put(SinglePodcastController());
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  HotPodcastList({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(title),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0, Dimens.medium, Dimens.medium - 1, 0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: homeScreenController.topPodcasts.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(NamedRoute.singlePodcast,
                      arguments: homeScreenController.topPodcasts[index]);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: Dimens.xlarge + 36,
                          width: Dimens.xlarge + 36,
                          child: Padding(
                            padding: EdgeInsets.all(Dimens.small),
                            child: CachedNetworkImage(
                              imageUrl: homeScreenController
                                  .topPodcasts[index].poster!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Dimens.medium),
                                    ),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              placeholder: ((context, url) => const Loading()),
                              errorWidget: (context, url, error) => Icon(
                                Icons.image_not_supported_outlined,
                                size: Dimens.xlarge - 14,
                                color: SolidColors.erorColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, 0, 0, Dimens.bodyMargin / 1),
                          child: Column(
                            children: [
                              Text(
                                homeScreenController.topPodcasts[index].title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                homeScreenController
                                    .topPodcasts[index].publisher!,
                                style: subTextPodcastList,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
