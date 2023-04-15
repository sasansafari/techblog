

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/decrations.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/podcast/single_podcast_cotroller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/podcast_model.dart';

Widget podcastEmpty(TextTheme textTheme) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.images.emptyState.path,
          height: Dimens.xlarge + 36,
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimens.medium),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: MyStrings.podcastEmpty,
                style: textTheme.headline4,
              )),
        ),
      ],
    ),
  );
}




Widget playerManager() {
  late SinglePodcastController controller;
  late PodcastModel podcastModel;
  podcastModel = Get.arguments;
  controller = Get.put(SinglePodcastController(id: podcastModel.id));
  return Positioned(
      bottom: Dimens.small,
      right: Dimens.bodyMargin,
      left: Dimens.bodyMargin,
      child: Container(
        height: Get.height / 7,
        decoration: MyDecorations.mainGradient,
        child: Padding(
          padding: EdgeInsets.all(Dimens.small),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(
                () => ProgressBar(
                  timeLabelTextStyle: const TextStyle(color: Colors.white),
                  thumbColor: SolidColors.yelowColor,
                  baseBarColor: SolidColors.lightIcon,
                  progressBarColor: SolidColors.selectedPodCast,
                  buffered: controller.bufferedValue.value,
                  progress: controller.progressValue.value,
                  total:
                      controller.player.duration ?? const Duration(seconds: 0),
                  onSeek: (position) async {
                    controller.player.seek(position);

                    if (controller.player.playing) {
                      controller.startProgress();
                    } else if (position <= const Duration(seconds: 0)) {
                      await controller.player.seekToNext();
                      controller.currentFileIndex.value =
                          controller.player.currentIndex!;
                      controller.timerCheck();
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await controller.player.seekToNext();
                      controller.currentFileIndex.value =
                          controller.player.currentIndex!;
                      controller.timerCheck();
                    },
                    child: const Icon(
                      Icons.skip_next,
                      color: SolidColors.lightIcon,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.player.playing
                          ? controller.timer!.cancel()
                          : controller.startProgress();

                      controller.player.playing
                          ? controller.player.pause()
                          : controller.player.play();

                      controller.playState.value = controller.player.playing;
                      controller.currentFileIndex.value =
                          controller.player.currentIndex!;
                    },
                    child: Obx(
                      () => Icon(
                        controller.playState.value
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: SolidColors.lightIcon,
                        size: Dimens.large + 16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await controller.player.seekToPrevious();
                      controller.currentFileIndex.value =
                          controller.player.currentIndex!;
                      controller.timerCheck();
                    },
                    child: const Icon(
                      Icons.skip_previous,
                      color: SolidColors.lightIcon,
                    ),
                  ),
                  const SizedBox(),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.setLoopMode();
                      },
                      child: Icon(
                        Icons.repeat,
                        color: controller.isLoopAll.value
                            ? SolidColors.seeMore
                            : SolidColors.lightIcon,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ));
}

Widget title(TextTheme textheme) {
  late PodcastModel podcastModel;
  podcastModel = Get.arguments;
  return Padding(
    padding: EdgeInsets.all(Dimens.small),
    child: Align(
      alignment: Alignment.centerRight,
      child: Text(
        podcastModel.title!,
        maxLines: 2,
        textAlign: TextAlign.start,
        style: textheme.titleLarge,
      ),
    ),
  );
}

Widget fileList(TextTheme textheme) {
  late SinglePodcastController controller;
  late PodcastModel podcastModel;
  podcastModel = Get.arguments;
  controller = Get.put(SinglePodcastController(id: podcastModel.id));
  return Padding(
    padding: EdgeInsets.all(Dimens.small),
    child: Obx(
      () => ListView.builder(
          itemCount: controller.podcastFileList.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return index < controller.podcastFileList.length - 1
                ? Padding(
                    padding: EdgeInsets.all(Dimens.small),
                    child:
                    
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                           onTap: () async {
                           
                            controller.startProgress();
                            controller.selectedIndex.value =
                                index;
                            await controller.player.seek(
                                Duration.zero,
                                index: controller
                                    .selectedIndex.value);
                            await controller.player.play();
                          },
                          child: Row(
                            children: [
                              ImageIcon(
                                Image.asset(Assets.icons.microphon.path).image,
                                color: SolidColors.seeMore,
                              ),
                              SizedBox(
                                width: Dimens.small,
                              ),
                              SizedBox(
                                width: Get.width / 1.5,
                                child: Text(
                                  controller.podcastFileList[index].title!,
                                  style: textheme.headline4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(controller.podcastFileList[index].lenght! + ":00")
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Dimens.small),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ImageIcon(
                                  Image.asset(Assets.icons.microphon.path)
                                      .image,
                                  color: SolidColors.seeMore,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SizedBox(
                                  width: Get.width / 1.5,
                                  child: Text(
                                    controller.podcastFileList[index].title!,
                                    style: textheme.headline4,
                                  ),
                                ),
                              ],
                            ),
                            Text(controller.podcastFileList[index].lenght! +
                                ":00")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 1.4,
                      )
                    ],
                  );
          })),
    ),
  );
}

Widget writer(TextTheme textheme) {
  late PodcastModel podcastModel;
  podcastModel = Get.arguments;
  return Padding(
    padding: EdgeInsets.all(Dimens.small),
    child: Row(
      children: [
        Image(
          image: Image.asset(Assets.images.profileAvatar.path).image,
          height: Dimens.xlarge - 14,
        ),
        SizedBox(
          width: Dimens.medium,
        ),
        Text(
          podcastModel.publisher!,
          style: textheme.headlineMedium,
        ),
        SizedBox(
          width: Dimens.medium,
        )
      ],
    ),
  );
}
