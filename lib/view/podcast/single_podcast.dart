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

import 'package:share_plus/share_plus.dart';

class PodcastSingle extends StatelessWidget {
  late final SinglePodcastController controller;
  late final PodcastModel podcastModel;

  PodcastSingle({Key? key}) : super(key: key) {
    if (Get.arguments is PodcastModel) {
      podcastModel = Get.arguments;
    } else {
      podcastModel = PodcastModel(
        id: '0',
        title: '',
        poster: '',
        publisher: 'ناشناس',
        view: '',
        createdAt: '',
      );
    }
    if (Get.isRegistered<SinglePodcastController>()) {
      Get.delete<SinglePodcastController>();
    }
    controller = Get.put(SinglePodcastController(id: podcastModel.id));
  }

  @override
  Widget build(BuildContext context) {
    var textheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        controller.player.stop();
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: Get.height / 3,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl: podcastModel.poster ?? '',
                              imageBuilder: ((context, imageProvider) => Image(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
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
                                  GestureDetector(
                                    onTap: () async {
                                      await Share.share(
                                        '${podcastModel.title ?? ''}\n${podcastModel.poster ?? ''}',
                                      );
                                    },
                                    child: Icon(
                                      Icons.share,
                                      color: SolidColors.lightIcon,
                                      size: Dimens.medium + 8,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimens.medium + 4,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                      // title
                      Titlee(podcastModel: podcastModel, textheme: textheme),

                      // writer / publisher
                      Writer(podcastModel: podcastModel, textheme: textheme),

                      const SizedBox(height: 8),

                      // file list
                      FileList(controller: controller, textheme: textheme),

                      // Space to ensure bottom items aren't covered by PlayerManager
                      SizedBox(height: Get.height / 6),
                    ],
                  ),
                ),
              ),

              // player manager
              PlayerManager(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}







