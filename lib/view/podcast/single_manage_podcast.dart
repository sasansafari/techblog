import 'dart:io';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
                                            style: textheme.headline2,
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
                            bottomSheet();
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
                                          style: textheme.headline4,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          managePodcastController
                                              .titleTextEditingControllerMinute
                                              .text,
                                          style: const TextStyle(
                                              color: SolidColors.blackColor),
                                        ),
                                        const Text(
                                          ":",
                                          style: TextStyle(
                                              color: SolidColors.blackColor),
                                        ),
                                        Text(
                                          managePodcastController
                                              .titleTextEditingControllerHour
                                              .text,
                                          style: const TextStyle(
                                              color: SolidColors.blackColor),
                                        ),
                                      ],
                                    ),
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
                          buffered: controller.bufferedValue.value,
                          progressBarColor: SolidColors.selectedPodCast,
                          progress: controller.progressValue.value,
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

  bottomSheet() {
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Get.height / 6,
                    width: Get.width / 3.1,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: SolidColors.lightIcon,
                    ),
                    child: Column(
                      children: [
                        IconButton(
                            iconSize: Dimens.xlarge - 4,
                            onPressed: () {
                              //انتخاب فایل صوتی
                              audioFile();
                            },
                            icon: ImageIcon(
                                AssetImage(Assets.icons.audiofile.path))),
                        Text(MyStrings.selectAudioFile,
                            style: TextStyle(
                                fontSize: Dimens.small + 4,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 14,
                  ),
                  Container(
                    height: Get.height / 6,
                    width: Get.width / 2.1,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: SolidColors.lightIcon),
                    // child: managePodcastController.chooseTime(),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Dimens.bodyMargin * 5,
                            width: Dimens.bodyMargin * 1.7,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: Dimens.small + 4),
                                  child: TextField(
                                      maxLength: 2,
                                      controller: managePodcastController
                                          .titleTextEditingControllerMinute,
                                      keyboardType: TextInputType.number,
                                      cursorColor: SolidColors.blackColor,
                                      style: const TextStyle(
                                          color: SolidColors.blackColor),
                                      decoration: InputDecoration(
                                        fillColor:
                                            SolidColors.minutesColorColor,
                                        border: const OutlineInputBorder(),
                                        hintText: MyStrings.enterNumber,
                                      ),
                                      onChanged: (value) {
                                        managePodcastController.input!.value =
                                            int.tryParse(value)!;
                                        if (managePodcastController.input! >
                                            60) {
                                          managePodcastController
                                              .isvisibleMinute.value = true;
                                          managePodcastController
                                              .titleTextEditingControllerMinute
                                              .clear();
                                        } else {
                                          managePodcastController
                                              .isvisibleMinute.value = false;
                                          value = "";
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(Dimens.small-7),
                                  child: Row(
                                    children: [
                                      Visibility(
                                        visible: managePodcastController
                                            .isvisibleMinute.value,
                                        child:  Padding(
                                          padding: EdgeInsets.all(Dimens.small-5),
                                          child: Text(
                                            MyStrings.errorText,
                                            style: const TextStyle(
                                                color: SolidColors.erorColor),
                                          ),
                                        ),
                                      ),
                                       Text(
                                        MyStrings.minute,
                                        style: const TextStyle(color: SolidColors.blackColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                           Padding(
                            padding: EdgeInsets.only(bottom: Dimens.xlarge-14),
                            child: Text(
                              ":",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: Dimens.xlarge-14),
                            ),
                          ),
                          SizedBox(
                            height: Dimens.bodyMargin * 5,
                            width: Dimens.bodyMargin * 1.7,
                            child: Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: Dimens.small+4),
                                  child: TextField(
                                      maxLength: 2,
                                      controller: managePodcastController
                                          .titleTextEditingControllerHour,
                                      keyboardType: TextInputType.number,
                                      cursorColor:
                                          SolidColors.blackColor,
                                      style: const TextStyle(
                                          color: SolidColors.blackColor),
                                      decoration:  InputDecoration(
                                        fillColor:
                                            SolidColors.minutesColorColor,
                                        border: const OutlineInputBorder(),
                                        hintText:MyStrings.enterNumber,
                                      ),
                                      onChanged: (value) {
                                        managePodcastController.inputHoure!
                                            .value = int.tryParse(value)!;
                                        if (managePodcastController
                                                .inputHoure! >
                                            12) {
                                          managePodcastController
                                              .isvisibleHour.value = true;

                                          managePodcastController
                                              .titleTextEditingControllerHour
                                              .clear();
                                        } else {
                                          managePodcastController
                                              .isvisibleHour.value = false;
                                          value = "";
                                        }
                                      }),
                                ),
                                Padding(
                                  padding:  EdgeInsets.all(Dimens.small-7),
                                  child: Row(
                                    children: [
                                      Visibility(
                                        visible: managePodcastController
                                            .isvisibleHour.value,
                                        child:  Padding(
                                          padding: EdgeInsets.all(Dimens.small-5),
                                          child: Text(
                                            MyStrings.errorText,
                                            style: const TextStyle(
                                                color: SolidColors.erorColor),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                       Text(
                                        MyStrings.houre,
                                        style: const TextStyle(color: SolidColors.blackColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: Dimens.large-2),
              child: ElevatedButton(
                style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all(Size(Get.width / 3, Dimens.xlarge-8))),
                onPressed: (() async {
                  await managePodcastController.titlePodcast();
                  await managePodcastController.filePodcast();
                  await managePodcastController.UpdatePodcast();
                }),
                child:  Text(
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
