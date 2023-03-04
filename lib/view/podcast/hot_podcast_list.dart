

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/text_style.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/controller/podcast/single_podcast_cotroller.dart';
import 'package:tec/view/podcast/single_podcast.dart';

import '../../component/dimens.dart';
import '../../component/my_component.dart';
import '../../models/podcast_model.dart';
import '../../route_manager/names.dart';

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
          padding: const EdgeInsets.fromLTRB(0, 16, 15, 0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: homeScreenController.topPodcasts.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
              Get.toNamed(NamedRoute.singlePodcast,arguments: homeScreenController.topPodcasts[index] );
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl: homeScreenController
                                  .topPodcasts[index].poster!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              placeholder: ((context, url) => const Loading()),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported_outlined,
                                size: 50,
                                color: Color.fromARGB(255, 227, 10, 10),
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