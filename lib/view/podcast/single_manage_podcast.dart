import 'dart:io';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tec/component/decrations.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/file_controller.dart';
import 'package:tec/controller/podcast/manage_podcast_controller.dart';
import 'package:tec/controller/podcast/single_podcast_cotroller.dart';
import 'package:tec/services/pick_file.dart';
import '../../gen/assets.gen.dart';

// ignore: must_be_immutable
class SingleManagePodcast extends StatelessWidget {
  SinglePodcastController controller = Get.put(SinglePodcastController());
  ManagePodcastController managePodcastController =
      Get.put(ManagePodcastController());
  FilePickerController filePickerController = Get.put(FilePickerController());

  SingleManagePodcast({Key? key}) : super(key: key);

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
                child: Obx(
                  (() => Column(children: [
                        Stack(
                          children: [
                            filePickerController.file.value.name == 'nothing'
                                ? SizedBox(
                                    width: Get.width,
                                    height: Get.height / 3,
                                    child: CachedNetworkImage(
                                      // imageUrl: managePodcastController.podcastFileModel.value.,
                                      imageUrl:
                                          "https://s2.uupload.ir/files/th_occc.jpg",
                                      imageBuilder: ((context, imageProvider) =>
                                          Image(image: imageProvider)),
                                      placeholder: ((context, url) =>
                                          const Loading()),
                                      errorWidget: ((context, url, error) =>
                                          Image.asset(
                                            Assets
                                                .images.singlePlaceHolder.path,
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  )
                                : Image.file(
                                    File(filePickerController.file.value.path!),
                                    fit: BoxFit.cover,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Dimens.medium + 4,
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.back(),
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: SolidColors.lightIcon,
                                          size: Dimens.medium + 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      //pickFile
                                      pickFile();
                                    },
                                    child: Container(
                                      height: Dimens.large - 2,
                                      width: Get.width / 3,
                                      decoration: BoxDecoration(
                                          color: SolidColors.primaryColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                Dimens.small + 4),
                                            topRight: Radius.circular(
                                                Dimens.small + 4),
                                          )),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            MyStrings.selectImage,
                                            style: textheme.displayMedium,
                                          ),
                                          const Icon(
                                            Icons.add,
                                            color: SolidColors.lightIcon,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        GestureDetector(
                          onTap: (() {
                            getTitle();
                          }),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: Dimens.bodyMargin / 3),
                            child: SeeMoreBlog(
                              bodyMargin: Dimens.bodyMargin / 2,
                              textTheme: textheme,
                              title: MyStrings.editTitlePodcast,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Dimens.bodyMargin * 1),
                          child: Text(
                            managePodcastController
                                .podcastFileModel.value.title!,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: Dimens.medium + 5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: Dimens.bodyMargin * 1.2,
                        ),
                        GestureDetector(
                          onTap: (() {
                            bottomSheet(textheme);
                          }),
                          child: SeeMoreBlog(
                            bodyMargin: Dimens.bodyMargin / 2,
                            textTheme: textheme,
                            title: MyStrings.addNewFile,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: Dimens.xxlarge,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    right: Dimens.bodyMargin / 2,
                                    left: Dimens.bodyMargin / 2,
                                    top: Dimens.bodyMargin / 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ImageIcon(
                                          Image.asset(
                                                  Assets.icons.microphon.path)
                                              .image,
                                          color: SolidColors.seeMore,
                                        ),
                                        SizedBox(
                                          width: Dimens.small,
                                        ),
                                        Text(
                                          MyStrings.frilance,
                                          style: textheme.headlineMedium,
                                        ),
                                      ],
                                    ),
                                    Text(
                                        '${managePodcastController.currentHourValue.value}:${managePodcastController.currentMinuteValue.value}:${managePodcastController.currentSecondeValue.value}',
                                        style: const TextStyle(
                                            color: SolidColors.blackColor))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ])),
                )),
          ),
          Positioned(
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
                          timeLabelTextStyle:
                              const TextStyle(color: SolidColors.lightText),
                          thumbColor: SolidColors.yelowColor,
                          baseBarColor: SolidColors.lightText,
                          buffered: controller.bufferState.value,
                          progressBarColor: SolidColors.selectedPodCast,
                          progress: controller.progressState.value,
                          onSeek: (position) {
                            controller.player.seek(position);

                            controller.player.playing
                                ? controller.startProgress()
                                : controller.timer!.cancel();
                          },
                          total: controller.player.duration ??
                              const Duration(seconds: 0)),
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

                            controller.playState.value =
                                controller.player.playing;

                            controller.currentFileIndex.value =
                                controller.player.currentIndex!;
                          },
                          child: Obx(
                            () => Icon(
                              controller.playState.value
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_fill,
                              color: SolidColors.lightIcon,
                              size: 48,
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
            ),
          )
        ],
      )),
    );
  }

  getTitle() {
    Get.defaultDialog(
      title: MyStrings.meaningFullTitle,
      titleStyle: const TextStyle(color: SolidColors.blackColor),
      content: TextField(
        controller: managePodcastController.titleTextEditingController,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: SolidColors.blackColor),
        decoration: InputDecoration(
          hintText: MyStrings.hintTextSingleManageArticle,
          fillColor: SolidColors.lightText,
        ),
      ),
      backgroundColor: SolidColors.lightBackColor,
      radius: Dimens.small,
      confirm: Row(
        children: [
          TextButton(
              onPressed: () {
                managePodcastController.updateTitle();
              },
              child: Text(
                MyStrings.verification,
                style: const TextStyle(
                    color: SolidColors.blackColor, fontWeight: FontWeight.bold),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                MyStrings.later,
                style: const TextStyle(
                    color: SolidColors.blackColor, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  bottomSheet(TextTheme textheme) {
    Get.bottomSheet(
      Container(
        height: Get.height / 2.2,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.large - 2),
              topRight: Radius.circular(Dimens.large - 2)),
          color: SolidColors.submitPodCast,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image.asset(Assets.icons.file.path,height: 32,),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimens.medium + 9,
                      right: Dimens.large - 2,
                      top: Dimens.medium - 1),
                  child: SvgPicture.asset(
                    Assets.images.tcbot.path,
                    height: Dimens.xlarge - 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimens.large + 3, top: Dimens.xlarge - 14),
                  child: Text(
                    MyStrings.addNewTimeFile,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.bodyMargin / 1.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await audioFile();
                    },
                    child: Column(
                      children: [
                        Assets.icons.audiofile.image(
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'انتخاب فایل صوتی',
                          style: textheme.headlineMedium!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Obx(
                    () => Column(
                      children: [
                        SizedBox(
                          height: Get.height / 6,
                          width: 60,
                          child: NumberPicker(
                            haptics: true,
                            minValue: 0,
                            maxValue: 60,
                            value: managePodcastController
                                .currentSecondeValue.value,
                            onChanged: (value) => managePodcastController
                                .currentSecondeValue.value = value,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('ثانیه'),
                      ],
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyle(fontSize: 25),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        SizedBox(
                          height: Get.height / 6,
                          width: 60,
                          child: NumberPicker(
                            haptics: true,
                            minValue: 0,
                            maxValue: 60,
                            value: managePodcastController
                                .currentMinuteValue.value,
                            onChanged: (value) => managePodcastController
                                .currentMinuteValue.value = value,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('دقیقه'),
                      ],
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyle(fontSize: 25),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        SizedBox(
                          height: Get.height / 6,
                          width: 60,
                          child: NumberPicker(
                            haptics: true,
                            minValue: 0,
                            maxValue: 12,
                            value:
                                managePodcastController.currentHourValue.value,
                            onChanged: (value) => managePodcastController
                                .currentHourValue.value = value,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('ساعت'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.large - 2),
              child: ElevatedButton(
                style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(
                        Size(Get.width / 3, Dimens.xlarge - 8))),
                onPressed: (() async {
                  await managePodcastController.titlePodcast();
                  await managePodcastController.filePodcast();
                  await managePodcastController.updatePodcast();
                }),
                child: Text(
                  MyStrings.verification,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
