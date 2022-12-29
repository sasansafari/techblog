import 'dart:developer';
import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/podcast/single_podcast_cotroller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tec/models/podcast_model.dart';

import '../../component/decrations.dart';

// ignore: must_be_immutable
class PodcastSingle extends StatelessWidget {

  late SinglePodcastController controller;
  late PodcastModel podcastModel;
  PodcastSingle(){
    podcastModel = Get.arguments;
    controller = Get.put(SinglePodcastController(id: podcastModel.id ));
  }

  @override
  Widget build(BuildContext context) {
    print(controller.id);
    
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
                      height: Get.height/3,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl:
                            podcastModel.poster!,
                        imageBuilder: ((context, imageProvider) =>
                            Image(image: imageProvider,fit: BoxFit.fill,)),
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
                          height: 60,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  end: Alignment.bottomCenter,
                                  begin: Alignment.topCenter,
                                  colors: GradiantColors.singleAppbarGradiant)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: (() => Get.back()),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),

                //title
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                     podcastModel.title!,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: textheme.titleLarge,
                    ),
                  ),
                ),

                //writer
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image:
                            Image.asset(Assets.images.profileAvatar.path).image,
                        height: 50,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        podcastModel.publisher!,
                        style: textheme.headline4,
                      ),
                      const SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),

                //file list
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    ()=> ListView.builder(
                        itemCount: controller.podcastFileList.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () async {
                              await controller.player.seek(Duration.zero,index: index);
                              controller.currentFileIndex.value = controller.player.currentIndex!;

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                        width: Get.width/1.5,
                                        child: Obx(
                                          ()=> Text(
                                            controller.podcastFileList[index].title!,
                                            style:controller.currentFileIndex.value==index? textheme.headline3:textheme.headline4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(controller.podcastFileList[index].lenght!+":00")
                                            
                                            
                                ],
                              ),
                            ),
                          );
                        })),
                  ),
                )
              ]),
            ),
          ),
          Positioned(
              bottom: 8,
              right: Dimens.bodyMargin,
              left: Dimens.bodyMargin,
              child: Container(
                  height: Get.height / 7,
                  decoration: MyDecorations.mainGradiant,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          Obx(
                            ()=> ProgressBar(
                            timeLabelTextStyle: TextStyle(color: Colors.white),
                            thumbColor: Colors.yellow,
                            baseBarColor: Colors.white,
                            progressBarColor: Colors.orange,
                            buffered: controller.bufferedValue.value,
                            progress: controller.progressValue.value,
                            total:controller.player.duration??const Duration(seconds: 0),
                            onSeek: (position) {
                              controller.player.seek(position);
                              controller.player.playing?
                              controller.startProgress():
                              controller.timer!.cancel();
                            },
                            
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:   [
                            GestureDetector(
                              onTap: () async {
                                await controller.player.seekToNext();
                               controller.currentFileIndex.value = controller.player.currentIndex!;

                              },
                              child: const Icon(
                                Icons.skip_next,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {


                               controller.player.playing?
                                controller.timer!.cancel():
                                controller.startProgress();
                                

                                controller.player.playing?
                                controller.player.pause():
                                controller.player.play();
                                



                                controller.playState.value = controller.player.playing;
                                controller.currentFileIndex.value = controller.player.currentIndex!;

                              },
                              child:  Obx(
                                ()=> Icon(
                                  controller.playState.value ?
                                  Icons.pause_circle_filled:
                                  Icons.play_circle_fill
 ,
                                  color: Colors.white,
                                  size: 48,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                               await controller.player.seekToPrevious();
                               controller.currentFileIndex.value = controller.player.currentIndex!;

                              },
                              child: const Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(),
                            Obx(
                              ()=> GestureDetector(
                                onTap: () {
                                  controller.setLoopMode();
                                },
                                child: Icon(
                                  Icons.repeat,
                                  color:controller.isLoopAll.value? Colors.blue:Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                    ))
        ],
      )),
    );
  }
}
