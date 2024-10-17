import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/view/widgets/podcast_widgets.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/podcast/single_podcast_cotroller.dart';
import 'package:tec/gen/assets.gen.dart';

import 'package:tec/models/podcast_model.dart';

// ignore: must_be_immutable
class PodcastSingle extends StatelessWidget {
  late SinglePodcastController controller;
  late PodcastModel podcastModel;
  PodcastSingle({Key? key}) : super(key: key) {
    podcastModel = Get.arguments;
    controller = Get.put(SinglePodcastController(id: podcastModel.id));
  }

  @override
  Widget build(BuildContext context) {
    var textheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                Stack(
                  children: [
                    SizedBox(
                      height: Get.height / 3,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: podcastModel.poster!,
                        imageBuilder: ((context, imageProvider) => Image(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            )),
                        placeholder: ((context, url) => const Loading()),
                        errorWidget: ((context, url, error) =>
                            Image.asset(Assets.images.singlePlaceHolder.path)),
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
                                onTap: () async {
                                  await controller.player.stop();
                                  controller.startProgress();
                                  controller.progressState.value =
                                      const Duration(seconds: 0);
                                  controller.selectedIndex.value = 0;
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: SolidColors.lightIcon,
                                  size: Dimens.medium + 8,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              SizedBox(
                                width: Dimens.medium + 4,
                              ),
                              Icon(
                                Icons.share,
                                color: SolidColors.lightIcon,
                                size: Dimens.medium + 8,
                              ),
                              SizedBox(
                                width: Dimens.medium + 4,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),

                //title
                Titlee(podcastModel: podcastModel, textheme: textheme),

                //writer
                Writer(podcastModel: podcastModel, textheme: textheme),

                //file list
                FileList(controller: controller, textheme: textheme),
              ]),
            ),
          ),

          //player manager
          PlayerManager(
            controller: controller,
          )
        ],
      )),
    );
  }
}
